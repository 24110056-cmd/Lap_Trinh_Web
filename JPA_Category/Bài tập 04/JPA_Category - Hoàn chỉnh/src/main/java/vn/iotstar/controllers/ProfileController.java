
package vn.iotstar.controllers;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.regex.Pattern;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;
import vn.iotstar.utils.CloudinaryUtils;
import vn.iotstar.utils.EmailUtils;

@WebServlet(urlPatterns = {
    "/profile",
    "/profile/update",
    "/profile/verify-email"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IUserService userService = new UserServiceImpl();
    private final SecureRandom random = new SecureRandom();

    private static final long OTP_VALID_TIME = 5 * 60 * 1000;

    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^$|^0\\d{9}$");

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private static final long MAX_IMAGE_SIZE = 10 * 1024 * 1024;

    private void forward(HttpServletRequest req,
                         HttpServletResponse resp,
                         String page)
            throws ServletException, IOException {

        req.getRequestDispatcher(page).forward(req, resp);
    }

    private User getCurrentUser(HttpSession session) {
        if (session == null) {
            return null;
        }

        Object account = session.getAttribute("account");

        if (account instanceof User) {
            return (User) account;
        }

        return null;
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User currentUser = getCurrentUser(session);

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();

        if ("/profile/verify-email".equals(path)) {

            if (session.getAttribute("pending_profile_user") == null) {
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }

            forward(req, resp, "/views/verify-profile.jsp");

        } else {
            forward(req, resp, "/views/profile.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User currentUser = getCurrentUser(session);

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();

        if ("/profile/update".equals(path)) {

            handleUpdateProfile(req, resp, session, currentUser);

        } else if ("/profile/verify-email".equals(path)) {

            handleVerifyEmailOtp(req, resp, session);

        } else {

            resp.sendRedirect(req.getContextPath() + "/profile");
        }
    }

    private void handleUpdateProfile(
            HttpServletRequest req,
            HttpServletResponse resp,
            HttpSession session,
            User currentUser)
            throws ServletException, IOException {

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String newEmail = req.getParameter("email");

        if (fullname == null || fullname.trim().length() < 2
                || fullname.trim().length() > 255) {

            req.setAttribute("alert",
                    "Họ tên phải từ 2 đến 255 ký tự!");

            forward(req, resp, "/views/profile.jsp");
            return;
        }

        fullname = fullname.trim();

        if (phone == null) {
            phone = "";
        }

        phone = phone.trim();

        if (!PHONE_PATTERN.matcher(phone).matches()) {

            req.setAttribute("alert",
                    "Số điện thoại phải bắt đầu bằng số 0 và gồm 10 chữ số!");

            forward(req, resp, "/views/profile.jsp");
            return;
        }

        if (newEmail == null || newEmail.trim().isEmpty()) {

            req.setAttribute("alert", "Email không được để trống!");

            forward(req, resp, "/views/profile.jsp");
            return;
        }

        newEmail = newEmail.trim().toLowerCase();

        if (!EMAIL_PATTERN.matcher(newEmail).matches()) {

            req.setAttribute("alert",
                    "Địa chỉ email không hợp lệ!");

            forward(req, resp, "/views/profile.jsp");
            return;
        }

        Part imagePart;

        try {
            imagePart = req.getPart("image");
        } catch (Exception e) {
            req.setAttribute("alert", "Không thể nhận file ảnh!");
            forward(req, resp, "/views/profile.jsp");
            return;
        }

        String imageUrl = currentUser.getImages();

        // Kiểm tra và upload ảnh nếu người dùng chọn ảnh mới
        if (imagePart != null && imagePart.getSize() > 0) {

            if (imagePart.getSize() > MAX_IMAGE_SIZE) {
                req.setAttribute("alert",
                        "Ảnh đại diện không được vượt quá 10MB!");

                forward(req, resp, "/views/profile.jsp");
                return;
            }

            String contentType = imagePart.getContentType();

            if (contentType == null ||
                    !contentType.toLowerCase().startsWith("image/")) {

                req.setAttribute("alert",
                        "File tải lên phải là hình ảnh!");

                forward(req, resp, "/views/profile.jsp");
                return;
            }

            try {
                String uploadedUrl =
                        CloudinaryUtils.uploadImage(imagePart);

                if (uploadedUrl == null || uploadedUrl.isEmpty()) {
                    req.setAttribute("alert",
                            "Không thể tải ảnh lên Cloudinary!");

                    forward(req, resp, "/views/profile.jsp");
                    return;
                }

                imageUrl = uploadedUrl;

            } catch (Exception e) {
                e.printStackTrace();

                req.setAttribute("alert",
                        "Lỗi Cloudinary: " + e.getMessage());

                forward(req, resp, "/views/profile.jsp");
                return;
            }
        }

        // Tạo bản cập nhật từ tài khoản hiện tại
        User updatedUser = new User();

        updatedUser.setId(currentUser.getId());
        updatedUser.setUsername(currentUser.getUsername());
        updatedUser.setPassword(currentUser.getPassword());
        updatedUser.setRoleid(currentUser.getRoleid());
        updatedUser.setEnabled(currentUser.isEnabled());
        updatedUser.setCode(currentUser.getCode());
        updatedUser.setFullname(fullname);
        updatedUser.setPhone(phone);
        updatedUser.setEmail(currentUser.getEmail());
        updatedUser.setImages(imageUrl);

        boolean emailChanged =
                !newEmail.equalsIgnoreCase(currentUser.getEmail());

        // Nếu email không thay đổi thì cập nhật trực tiếp
        if (!emailChanged) {

            userService.update(updatedUser);

            session.setAttribute("account", updatedUser);

            req.setAttribute("success",
                    "Cập nhật thông tin cá nhân thành công!");

            forward(req, resp, "/views/profile.jsp");
            return;
        }

        // Kiểm tra email mới đã được sử dụng chưa
        if (userService.checkExistEmail(newEmail)) {

            req.setAttribute("alert",
                    "Email mới đã được sử dụng bởi tài khoản khác!");

            forward(req, resp, "/views/profile.jsp");
            return;
        }

        // Sinh OTP 6 chữ số
        String otp = String.format("%06d",
                random.nextInt(900000) + 100000);

        String subject = "Xác nhận thay đổi Email - IotStar";

        String content =
                "Xin chào " + fullname + ",\n\n"
                + "Bạn đang thực hiện thay đổi địa chỉ Email.\n\n"
                + "Mã OTP xác nhận của bạn là: " + otp + "\n\n"
                + "Mã OTP có hiệu lực trong 5 phút.\n"
                + "Vui lòng không chia sẻ mã này với bất kỳ ai.";

        boolean sent = EmailUtils.sendEmail(
                newEmail, subject, content
        );

        if (!sent) {

            req.setAttribute("alert",
                    "Không thể gửi OTP đến email mới. "
                    + "Vui lòng kiểm tra địa chỉ email!");

            forward(req, resp, "/views/profile.jsp");
            return;
        }

        // Lưu thông tin chờ xác nhận vào Session
        updatedUser.setEmail(newEmail);

        session.setAttribute("pending_profile_user", updatedUser);
        session.setAttribute("profile_otp", otp);
        session.setAttribute("profile_otp_time",
                System.currentTimeMillis());
        session.setAttribute("profile_otp_attempts", 0);

        resp.sendRedirect(
                req.getContextPath() + "/profile/verify-email"
        );
    }

    private void handleVerifyEmailOtp(
            HttpServletRequest req,
            HttpServletResponse resp,
            HttpSession session)
            throws ServletException, IOException {

        String inputOtp = req.getParameter("otp");

        String sessionOtp =
                (String) session.getAttribute("profile_otp");

        Long otpTime =
                (Long) session.getAttribute("profile_otp_time");

        User pendingUser =
                (User) session.getAttribute("pending_profile_user");

        if (sessionOtp == null || otpTime == null
                || pendingUser == null) {

            req.setAttribute("alert",
                    "Phiên xác nhận không tồn tại. Vui lòng thực hiện lại!");

            forward(req, resp, "/views/profile.jsp");
            return;
        }

        // Kiểm tra thời gian OTP
        if (System.currentTimeMillis() - otpTime > OTP_VALID_TIME) {

            clearOtpSession(session);

            req.setAttribute("alert",
                    "Mã OTP đã hết hạn. Vui lòng cập nhật lại email!");

            forward(req, resp, "/views/profile.jsp");
            return;
        }

        // Giới hạn 5 lần nhập OTP
        Integer attempts =
                (Integer) session.getAttribute("profile_otp_attempts");

        if (attempts == null) {
            attempts = 0;
        }

        if (attempts >= 5) {

            clearOtpSession(session);

            req.setAttribute("alert",
                    "Bạn đã nhập sai OTP quá 5 lần. Vui lòng thực hiện lại!");

            forward(req, resp, "/views/profile.jsp");
            return;
        }

        if (inputOtp == null || !inputOtp.trim().equals(sessionOtp)) {

            attempts++;

            session.setAttribute("profile_otp_attempts", attempts);

            req.setAttribute("alert",
                    "Mã OTP không chính xác! Bạn còn "
                    + (5 - attempts) + " lần thử.");

            forward(req, resp, "/views/verify-profile.jsp");
            return;
        }

        // OTP đúng: cập nhật Database
        try {

            userService.update(pendingUser);

            session.setAttribute("account", pendingUser);

            clearOtpSession(session);

            req.setAttribute("success",
                    "Xác nhận email thành công! "
                    + "Thông tin cá nhân đã được cập nhật.");

            forward(req, resp, "/views/profile.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute("alert",
                    "Không thể cập nhật hồ sơ. Vui lòng thử lại!");

            forward(req, resp, "/views/verify-profile.jsp");
        }
    }

    private void clearOtpSession(HttpSession session) {

        session.removeAttribute("profile_otp");
        session.removeAttribute("profile_otp_time");
        session.removeAttribute("pending_profile_user");
        session.removeAttribute("profile_otp_attempts");
    }
}
