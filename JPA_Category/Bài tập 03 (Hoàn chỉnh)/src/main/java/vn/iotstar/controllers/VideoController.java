package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import vn.iotstar.dao.IVideoDao;
import vn.iotstar.dao.impl.VideoDao;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.utils.Constant;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,   // 2MB
    maxFileSize = 1024 * 1024 * 100,       // 100MB
    maxRequestSize = 1024 * 1024 * 150     // 150MB
)
@WebServlet(urlPatterns = {
    "/video", "/video/detail",
    "/admin/video/add", "/admin/video/insert",
    "/admin/video/edit", "/admin/video/update",
    "/admin/video/delete"
})
public class VideoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IVideoDao videoDao = new VideoDao();
    private final ICategoryService cateService = new CategoryServiceImpl();

    private String uploadFile(Part part, String uploadPath) throws IOException {
        if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
            String originalName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String savedName = System.currentTimeMillis() + "_" + originalName;
            part.write(uploadPath + File.separator + savedName);
            return savedName;
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (url.contains("/video/detail")) {
            showVideoDetail(req, resp);
        } else if (url.contains("/admin/video/add")) {
            req.setAttribute("categories", cateService.findAll());
            req.getRequestDispatcher("/views/video-form.jsp").forward(req, resp);
        } else if (url.contains("/admin/video/edit")) {
            String id = req.getParameter("id");
            req.setAttribute("video", videoDao.findById(id));
            req.setAttribute("categories", cateService.findAll());
            req.getRequestDispatcher("/views/video-form.jsp").forward(req, resp);
        } else if (url.contains("/admin/video/delete")) {
            String id = req.getParameter("id");
            if (id != null) videoDao.delete(id);
            resp.sendRedirect(req.getContextPath() + "/video");
        } else {
            listUserVideosWithPagination(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        User currentUser = (User) session.getAttribute("account");

        String url = req.getRequestURI();
        boolean isEdit = url.contains("/edit") || url.contains("/update");

        String videoId = req.getParameter("videoId");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        boolean active = "true".equalsIgnoreCase(req.getParameter("active"));
        String categoryIdParam = req.getParameter("categoryId");

        // Kiểm tra trùng mã VideoId khi thêm mới
        if (!isEdit && videoId != null && videoDao.findById(videoId.trim()) != null) {
            req.setAttribute("error", "Mã Video '" + videoId.trim() + "' đã tồn tại! Vui lòng nhập mã khác.");
            req.setAttribute("categories", cateService.findAll());
            req.getRequestDispatcher("/views/video-form.jsp").forward(req, resp);
            return;
        }

        Video video = isEdit ? videoDao.findById(videoId.trim()) : new Video();
        if (video == null) {
            video = new Video();
            isEdit = false;
        }

        if (!isEdit) {
            video.setVideoId(videoId.trim());
            video.setViews(0);
            video.setUser(currentUser);
        }

        video.setTitle(title);
        video.setDescription(description);
        video.setActive(active);

        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            video.setCategory(cateService.findById(Integer.parseInt(categoryIdParam)));
        }

        File uploadDir = new File(Constant.DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String savedPoster = uploadFile(req.getPart("posterFile"), Constant.DIR);
        if (savedPoster != null) {
            video.setPoster(savedPoster);
        }

        String savedVideo = uploadFile(req.getPart("videoFile"), Constant.DIR);
        if (savedVideo != null) {
            video.setVideoUrl(savedVideo);
        }

        if (isEdit) {
            videoDao.update(video);
        } else {
            videoDao.insert(video);
        }

        resp.sendRedirect(req.getContextPath() + "/video");
    }

    private void listUserVideosWithPagination(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("account");
        int pageSize = 6;
        int currentPage = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Math.max(1, Integer.parseInt(pageParam));
            } catch (NumberFormatException ignored) {}
        }

        long totalItems = videoDao.countByUserId(currentUser.getId());
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        List<Video> videos = videoDao.findByUserIdPaginated(currentUser.getId(), currentPage, pageSize);

        req.setAttribute("videos", videos);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/views/video-list.jsp").forward(req, resp);
    }

    private void showVideoDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id == null || id.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/video");
            return;
        }
        Video video = videoDao.findById(id);
        if (video != null) {
            video.setViews(video.getViews() + 1);
            videoDao.update(video);
        }
        req.setAttribute("video", video);
        req.getRequestDispatcher("/views/video-detail.jsp").forward(req, resp);
    }
}
