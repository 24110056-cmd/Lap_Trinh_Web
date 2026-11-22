package vn.iotstar.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.dao.IVideoDao;
import vn.iotstar.dao.impl.VideoDao;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IVideoDao videoDao = new VideoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("videos", videoDao.findTop10Newest());
        req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
    }
}
