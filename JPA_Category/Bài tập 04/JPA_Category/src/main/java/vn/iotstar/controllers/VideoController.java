package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Arrays;
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
import vn.iotstar.utils.ValidationUtils;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 100,
    maxRequestSize = 1024 * 1024 * 150
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
    private static final List<String> IMAGE_EXTS = Arrays.asList("jpg", "jpeg", "png", "gif", "webp");
    private static final List<String> VIDEO_EXTS = Arrays.asList("mp4", "webm", "mkv", "avi", "mov");

    private String getFileExtension(Part part) {
        if (part == null || part.getSubmittedFileName() == null) return "";
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        int idx = filename.lastIndexOf(".");
        return (idx > 0) ? filename.substring(idx + 1).toLowerCase() : "";
    }

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

        if (!isEdit && videoId != null && !videoId.trim().isEmpty() && videoDao.findById(videoId.trim()) != null) {
            req.setAttribute("error", "Mã Video '" + videoId.trim() + "' đã tồn tại! Vui lòng nhập mã khác.");
            req.setAttribute("alert", "Mã Video '" + videoId.trim() + "' đã tồn tại! Vui lòng nhập mã khác.");
            req.setAttribute("categories", cateService.findAll());
            req.getRequestDispatcher("/views/video-form.jsp").forward(req, resp);
            return;
        }

        Video video = isEdit ? videoDao.findById(videoId != null ? videoId.trim() : "") : new Video();
        if (video == null) {
            video = new Video();
            isEdit = false;
        }

        if (!isEdit) {
            video.setVideoId(videoId != null ? videoId.trim() : "");
            video.setViews(0);
            video.setUser(currentUser);
        }

        video.setTitle(title != null ? title.trim() : "");
        video.setDescription(description);
        video.setActive(active);

        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            video.setCategory(cateService.findById(Integer.parseInt(categoryIdParam)));
        }

        Part posterPart = req.getPart("posterFile");
        Part videoPart = req.getPart("videoFile");

        if (posterPart != null && posterPart.getSize() > 0) {
            String ext = getFileExtension(posterPart);
            if (!IMAGE_EXTS.contains(ext)) {
                forwardWithError(req, resp, video, "Ảnh Poster phải có định dạng: jpg, jpeg, png, gif, webp!");
                return;
            }
        }

        if (videoPart != null && videoPart.getSize() > 0) {
            String ext = getFileExtension(videoPart);
            if (!VIDEO_EXTS.contains(ext)) {
                forwardWithError(req, resp, video, "File Video phải có định dạng: mp4, webm, mkv, avi, mov!");
                return;
            }
        } else if (!isEdit) {
            forwardWithError(req, resp, video, "Vui lòng chọn file Video để tải lên!");
            return;
        }

        File uploadDir = new File(Constant.DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String savedPoster = uploadFile(posterPart, Constant.DIR);
        if (savedPoster != null) {
            video.setPoster(savedPoster);
        }

        String savedVideo = uploadFile(videoPart, Constant.DIR);
        if (savedVideo != null) {
            video.setVideoUrl(savedVideo);
        }

        String errorMsg = ValidationUtils.validate(video);
        if (errorMsg != null) {
            forwardWithError(req, resp, video, errorMsg);
            return;
        }

        if (isEdit) {
            videoDao.update(video);
        } else {
            videoDao.insert(video);
        }

        resp.sendRedirect(req.getContextPath() + "/video");
    }
    private void forwardWithError(HttpServletRequest req, HttpServletResponse resp, Video video, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.setAttribute("alert", message);
        req.setAttribute("video", video);
        req.setAttribute("categories", cateService.findAll());
        req.getRequestDispatcher("/views/video-form.jsp").forward(req, resp);
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
