package vn.iotstar.controllers.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.utils.Constant;

@WebServlet(urlPatterns = {"/image", "/images"})
public class DownloadImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.isEmpty()) return;

        File file = new File(Constant.DIR + File.separator + fileName);
        if (file.exists()) {
            String lowerName = fileName.toLowerCase();
            if (lowerName.endsWith(".mp4") || lowerName.endsWith(".webm") || lowerName.endsWith(".ogg")) {
                resp.setContentType("video/mp4");
                resp.setHeader("Accept-Ranges", "bytes");
            } else if (lowerName.endsWith(".png")) {
                resp.setContentType("image/png");
            } else {
                resp.setContentType("image/jpeg");
            }
            resp.setContentLengthLong(file.length());

            try (FileInputStream in = new FileInputStream(file)) {
                in.transferTo(resp.getOutputStream());
            }
        }
    }
}
