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
import vn.iotstar.utils.ValidationUtils;

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
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else if (url.contains("/register")) {
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        } else if (url.contains("/verify")) {
            req.getRequestDispatcher("/views/verify.jsp").forward(req, resp);
        } else if (url.contains("/forgot")) {
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
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

            // 1. Validation cho Login
            if (username == null || username.trim().isEmpty()
                    || password == null || password.trim().isEmpty()) {
                req.setAttribute("alert", "Tên đăng nhập và mật khẩu không được để trống!");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }

            User user = userService.login(username.trim(), password);

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("account", user);
                resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                req.setAttribute("alert",
                        "Tài khoản hoặc mật khẩu không chính xác, hoặc tài khoản chưa kích hoạt OTP!");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            }

        } else if (url.contains("/register")) {

            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String confirmPassword = req.getParameter("confirmPassword");
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");

            // 1. Kiểm tra mật khẩu nhập lại
            if (confirmPassword == null || !password.equals(confirmPassword)) {
                req.setAttribute("alert", "Mật khẩu nhập lại không khớp!");
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
                return;
            }

            // 2. Dùng Hibernate Validator kiểm tra dữ liệu Entity User
            User tempUser = new User();
            tempUser.setUsername(username != null ? username.trim() : "");
            tempUser.setPassword(password != null ? password : "");
            tempUser.setFullname(fullname != null ? fullname.trim() : "");
            tempUser.setEmail(email != null ? email.trim() : "");

            String errorMsg = ValidationUtils.validate(tempUser);
            if (errorMsg != null) {
                req.setAttribute("alert", errorMsg);
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
                return;
            }

            // 3. Gọi Service đăng ký
            boolean isSuccess = userService.register(
                    username.trim(), password, fullname.trim(), email.trim()
            );

            if (isSuccess) {
                req.setAttribute("email", email.trim().toLowerCase());
                req.setAttribute("success",
                        "Mã OTP đã được gửi. Vui lòng kiểm tra email!");
                req.getRequestDispatcher("/views/verify.jsp").forward(req, resp);
            } else {
                req.setAttribute("alert",
                        "Đăng ký thất bại. Email có thể đã được kích hoạt, username đã tồn tại hoặc hệ thống không gửi được OTP.");
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            }

        } else if (url.contains("/verify")) {

            String email = req.getParameter("email");
            String otp = req.getParameter("otp");

            if (otp == null || otp.trim().isEmpty()) {
                req.setAttribute("email", email);
                req.setAttribute("alert", "Vui lòng nhập mã OTP!");
                req.getRequestDispatcher("/views/verify.jsp").forward(req, resp);
                return;
            }

            boolean isVerified = userService.verifyAccount(email, otp.trim());

            if (isVerified) {
                req.setAttribute("success",
                        "Kích hoạt tài khoản thành công! Mời bạn đăng nhập.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("email", email);
                req.setAttribute("alert",
                        "Mã OTP không chính xác hoặc đã hết hạn!");
                req.getRequestDispatcher("/views/verify.jsp").forward(req, resp);
            }

        } else if (url.contains("/forgot")) {

            String email = req.getParameter("email");

            // Validation cho Forgot Password
            if (email == null || email.trim().isEmpty()) {
                req.setAttribute("alert", "Vui lòng nhập địa chỉ email của bạn!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            if (!email.trim().matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
                req.setAttribute("alert", "Định dạng email không hợp lệ!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            boolean isSent = userService.forgotPassword(email.trim());

            if (isSent) {
                req.setAttribute("email", email.trim());
                req.setAttribute("success",
                        "Mã OTP khôi phục mật khẩu đã được gửi đến email của bạn.");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            } else {
                req.setAttribute("alert",
                        "Không tìm thấy email đã kích hoạt hoặc gửi OTP thất bại!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            }
        }
    }
}
