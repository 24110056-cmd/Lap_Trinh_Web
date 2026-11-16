package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.utils.Constant;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(urlPatterns = {
    "/video", "/video/detail",
    "/admin/video/add", "/admin/video/insert",
    "/admin/video/edit", "/admin/video/update",
    "/admin/video/delete"
})
public class VideoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/video/detail")) {
            showVideoDetail(req, resp);
        } else if (url.contains("/admin/video/add")) {
            req.setAttribute("categories", cateService.findAll());
            req.getRequestDispatcher("/views/video-form.jsp").forward(req, resp);
        } else if (url.contains("/admin/video/edit")) {
            showEditForm(req, resp);
        } else if (url.contains("/admin/video/delete")) {
            deleteVideo(req, resp);
        } else {
            listVideosWithPagination(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/video/insert") || url.contains("/admin/video/add")) {
            saveOrUpdateVideo(req, resp, false);
        } else if (url.contains("/admin/video/update") || url.contains("/admin/video/edit")) {
            saveOrUpdateVideo(req, resp, true);
        }
    }

    private void listVideosWithPagination(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            int pageSize = 6;
            int currentPage = 1;
            String pageParam = req.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                try {
                    currentPage = Math.max(1, Integer.parseInt(pageParam.trim()));
                } catch (NumberFormatException ignored) {
                    currentPage = 1;
                }
            }

            Long totalItems = em.createQuery("SELECT COUNT(v) FROM Video v", Long.class).getSingleResult();
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);
            if (totalPages == 0) totalPages = 1;
            if (currentPage > totalPages) currentPage = totalPages;

            TypedQuery<Video> query = em.createQuery("SELECT v FROM Video v ORDER BY v.videoId DESC", Video.class);
            query.setFirstResult((currentPage - 1) * pageSize);
            query.setMaxResults(pageSize);

            req.setAttribute("videos", query.getResultList());
            req.setAttribute("currentPage", currentPage);
            req.setAttribute("totalPages", totalPages);
            req.getRequestDispatcher("/views/video-list.jsp").forward(req, resp);
        } finally {
            em.close();
        }
    }
    private void showVideoDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/video");
            return;
        }
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            Video video = findVideoById(em, idParam.trim());
            if (video != null) {
                trans.begin();
                video.setViews(video.getViews() + 1);
                em.merge(video);
                trans.commit();
            }
            req.setAttribute("video", video);
            req.getRequestDispatcher("/views/video-detail.jsp").forward(req, resp);
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/video");
        } finally {
            em.close();
        }
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/video");
            return;
        }
        EntityManager em = JpaConfig.getEntityManager();
        try {
            req.setAttribute("video", findVideoById(em, idParam.trim()));
            req.setAttribute("categories", cateService.findAll());
            req.getRequestDispatcher("/views/video-form.jsp").forward(req, resp);
        } finally {
            em.close();
        }
    }

    private void saveOrUpdateVideo(HttpServletRequest req, HttpServletResponse resp, boolean isEdit)
            throws ServletException, IOException {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            String videoId = req.getParameter("videoId");
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String activeParam = req.getParameter("active");
            String categoryIdParam = req.getParameter("categoryId");
            String posterUrl = req.getParameter("posterUrl");

            Video video = isEdit ? findVideoById(em, videoId) : new Video();
            if (video == null) {
                video = new Video();
                isEdit = false;
            }
            String oldPoster = isEdit ? video.getPoster() : null;

            if (!isEdit) {
                video.setVideoId(videoId);
                video.setViews(0);
            }
            video.setTitle(title);
            video.setDescription(description);
            video.setActive(activeParam == null || "1".equals(activeParam) || "true".equalsIgnoreCase(activeParam) || "on".equalsIgnoreCase(activeParam));

            if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {
                video.setCategory(cateService.findById(Integer.parseInt(categoryIdParam.trim())));
            }
            HttpSession session = req.getSession(false);
            if (session != null && session.getAttribute("account") != null) {
                video.setUser((User) session.getAttribute("account"));
            }

            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            Part filePart = null;
            try { filePart = req.getPart("poster"); } catch (Exception ignored) {}

            if (filePart != null && filePart.getSize() > 0) {
                if (isEdit && oldPoster != null && !oldPoster.startsWith("http") && !oldPoster.equals("avatar.png")) {
                    deleteFile(uploadPath + File.separator + oldPoster);
                }
                String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                int dotIndex = submittedName.lastIndexOf(".");
                String ext = dotIndex > 0 ? submittedName.substring(dotIndex + 1) : "jpg";
                String newFileName = System.currentTimeMillis() + "." + ext;
                filePart.write(uploadPath + File.separator + newFileName);
                video.setPoster(newFileName);
            } else if (posterUrl != null && !posterUrl.trim().isEmpty()) {
                video.setPoster(posterUrl.trim());
            } else if (!isEdit) {
                video.setPoster("avatar.png");
            }

            if (isEdit) em.merge(video);
            else em.persist(video);

            trans.commit();
            resp.sendRedirect(req.getContextPath() + "/video");
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/video");
        } finally {
            em.close();
        }
    }

    private void deleteVideo(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            EntityManager em = JpaConfig.getEntityManager();
            EntityTransaction trans = em.getTransaction();
            try {
                Video video = findVideoById(em, idParam.trim());
                if (video != null) {
                    trans.begin();
                    String oldPoster = video.getPoster();
                    if (oldPoster != null && !oldPoster.startsWith("http") && !oldPoster.equals("avatar.png")) {
                        deleteFile(Constant.DIR + File.separator + oldPoster);
                    }
                    em.remove(video);
                    trans.commit();
                }
            } catch (Exception e) {
                if (trans.isActive()) trans.rollback();
                e.printStackTrace();
            } finally {
                em.close();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/video");
    }

    private Video findVideoById(EntityManager em, String id) {
        if (id == null || id.trim().isEmpty()) return null;
        try {
            return em.find(Video.class, id);
        } catch (IllegalArgumentException e) {
            return em.find(Video.class, Integer.parseInt(id));
        }
    }

    private void deleteFile(String filePath) {
        try {
            Files.deleteIfExists(Paths.get(filePath));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
