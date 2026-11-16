package vn.iotstar.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = {
        "/login", "/register", "/verify", "/forgot", "/logout"
})
public class AuthController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private IUserService userService = new UserServiceImpl();

    @Override
    public void init() throws ServletException {
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        String url = req.getRequestURI();

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/login")) {

            req.getRequestDispatcher("/views/login.jsp")
                    .forward(req, resp);

        } else if (url.contains("/register")) {

            req.getRequestDispatcher("/views/register.jsp")
                    .forward(req, resp);

        } else if (url.contains("/verify")) {

            req.getRequestDispatcher("/views/verify.jsp")
                    .forward(req, resp);

        } else if (url.contains("/forgot")) {

            req.getRequestDispatcher("/views/forgot-password.jsp")
                    .forward(req, resp);

        } else if (url.contains("/logout")) {

            HttpSession session = req.getSession(false);

            if (session != null) {
                session.invalidate();
            }

            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String url = req.getRequestURI();

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/login")) {

            String username = req.getParameter("username");
            String password = req.getParameter("password");

            User user = userService.login(username, password);

            if (user != null) {

                HttpSession session = req.getSession();

                session.setAttribute("account", user);

                resp.sendRedirect(req.getContextPath() + "/home");

            } else {

                req.setAttribute("alert",
                        "Tài khoản hoặc mật khẩu không chính xác, hoặc tài khoản chưa kích hoạt OTP!");

                req.getRequestDispatcher("/views/login.jsp")
                        .forward(req, resp);
            }

        } else if (url.contains("/register")) {

            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String confirmPassword = req.getParameter("confirmPassword");
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");

            if (username == null || password == null
                    || confirmPassword == null
                    || fullname == null || email == null
                    || username.trim().isEmpty()
                    || password.isEmpty()
                    || fullname.trim().isEmpty()
                    || email.trim().isEmpty()) {

                req.setAttribute("alert", "Vui lòng nhập đầy đủ thông tin!");

                req.getRequestDispatcher("/views/register.jsp")
                        .forward(req, resp);

                return;
            }

            if (!password.equals(confirmPassword)) {

                req.setAttribute("alert",
                        "Mật khẩu nhập lại không khớp!");

                req.getRequestDispatcher("/views/register.jsp")
                        .forward(req, resp);

                return;
            }

            boolean isSuccess = userService.register(
                    username, password, fullname, email
            );

            if (isSuccess) {

                req.setAttribute("email", email.trim().toLowerCase());

                req.setAttribute("success",
                        "Mã OTP đã được gửi. Vui lòng kiểm tra email!");

                req.getRequestDispatcher("/views/verify.jsp")
                        .forward(req, resp);

            } else {

                req.setAttribute("alert",
                        "Đăng ký thất bại. Email có thể đã được kích hoạt, username đã tồn tại hoặc hệ thống không gửi được OTP.");

                req.getRequestDispatcher("/views/register.jsp")
                        .forward(req, resp);
            }

        } else if (url.contains("/verify")) {

            String email = req.getParameter("email");
            String otp = req.getParameter("otp");

            boolean isVerified =
                    userService.verifyAccount(email, otp);

            if (isVerified) {

                req.setAttribute("success",
                        "Kích hoạt tài khoản thành công! Mời bạn đăng nhập.");

                req.getRequestDispatcher("/views/login.jsp")
                        .forward(req, resp);

            } else {

                req.setAttribute("email", email);

                req.setAttribute("alert",
                        "Mã OTP không chính xác hoặc đã hết hạn!");

                req.getRequestDispatcher("/views/verify.jsp")
                        .forward(req, resp);
            }

        } else if (url.contains("/forgot")) {

            String email = req.getParameter("email");

            boolean isSent = userService.forgotPassword(email);

            if (isSent) {

                req.setAttribute("email", email);

                req.setAttribute("success",
                        "Mã OTP khôi phục mật khẩu đã được gửi đến email của bạn.");

                req.getRequestDispatcher("/views/reset-password.jsp")
                        .forward(req, resp);

            } else {

                req.setAttribute("alert",
                        "Không tìm thấy email đã kích hoạt hoặc gửi OTP thất bại!");

                req.getRequestDispatcher("/views/forgot-password.jsp")
                        .forward(req, resp);
            }
        }
    }
}
