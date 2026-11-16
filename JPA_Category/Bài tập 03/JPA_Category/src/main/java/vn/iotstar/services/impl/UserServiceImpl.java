package vn.iotstar.services.impl;

import java.security.SecureRandom;

import org.mindrot.jbcrypt.BCrypt;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.utils.EmailUtils;

public class UserServiceImpl implements IUserService {

    private IUserDao userDao = new UserDao();
    private SecureRandom random = new SecureRandom();

    private String generateOTP() {
        return String.format("%06d", random.nextInt(1000000));
    }

    @Override
    public User login(String username, String password) {
        if (username == null || password == null) {
            return null;
        }

        User user = userDao.findByUsername(username.trim());

        if (user != null && user.isEnabled() && user.getPassword() != null) {
            String dbPassword = user.getPassword();
            if (dbPassword.startsWith("$2a$") || dbPassword.startsWith("$2b$")) {
                if (BCrypt.checkpw(password, dbPassword)) {
                    return user;
                }
            } else {
                if (password.equals(dbPassword)) {
                    return user;
                }
            }
        }

        return null;
    }

    @Override
    public boolean register(String username, String password,
                            String fullname, String email) {

        username = username.trim();
        email = email.trim().toLowerCase();

        User existingUser = userDao.findByEmail(email);

        if (existingUser != null) {
            if (existingUser.isEnabled()) {
                System.out.println("Email da ton tai: " + email);
                return false;
            }

            String otp = generateOTP();
            existingUser.setCode(otp);
            userDao.update(existingUser);

            String subject = "Ma xac thuc kich hoat tai khoan";
            String content = "Xin chao " + existingUser.getFullname()
                    + ",\nMa OTP moi cua ban la: " + otp
                    + "\nVui long khong chia se ma nay cho nguoi khac.";

            boolean sent = EmailUtils.sendEmail(email, subject, content);
            if (!sent) {
                System.out.println("Gui lai OTP that bai: " + email);
                return false;
            }
            return true;
        }

        if (userDao.checkExistUsername(username)) {
            System.out.println("Username da ton tai: " + username);
            return false;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
        user.setFullname(fullname);
        user.setEmail(email);
        user.setRoleid(2);
        user.setEnabled(false);

        String otp = generateOTP();
        user.setCode(otp);

        userDao.insert(user);

        String subject = "Ma xac thuc kich hoat tai khoan";
        String content = "Xin chao " + fullname
                + ",\nMa OTP kich hoat tai khoan cua ban la: " + otp
                + "\nVui long khong chia se ma nay cho nguoi khac.";

        boolean sent = EmailUtils.sendEmail(email, subject, content);
        if (!sent) {
            System.out.println("Gui OTP that bai: " + email);
            return false;
        }

        return true;
    }

    @Override
    public boolean verifyAccount(String email, String otp) {
        User user = userDao.findByEmail(email.trim().toLowerCase());

        if (user != null
                && !user.isEnabled()
                && user.getCode() != null
                && user.getCode().equals(otp)) {

            user.setEnabled(true);
            user.setCode(null);
            userDao.update(user);
            return true;
        }

        return false;
    }

    @Override
    public boolean forgotPassword(String email) {
        User user = userDao.findByEmail(email.trim().toLowerCase());

        if (user != null && user.isEnabled()) {
            String otp = generateOTP();
            user.setCode(otp);
            userDao.update(user);

            String subject = "Khoi phuc mat khau - Ma OTP";
            String content = "Ma OTP de dat lai mat khau cua ban la: "
                    + otp
                    + "\nVui long khong chia se ma nay cho nguoi khac.";

            boolean sent = EmailUtils.sendEmail(email, subject, content);
            if (!sent) {
                System.out.println("Gui OTP khoi phuc that bai: " + email);
                return false;
            }
            return true;
        }

        return false;
    }

    @Override
    public boolean resetPassword(String email, String otp,
                                 String newPassword) {
        User user = userDao.findByEmail(email.trim().toLowerCase());

        if (user != null
                && user.isEnabled()
                && user.getCode() != null
                && user.getCode().equals(otp)) {

            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            user.setPassword(hashedPassword);
            user.setCode(null);
            userDao.update(user);
            return true;
        }

        return false;
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username.trim());
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.findByEmail(email.trim().toLowerCase()) != null;
    }
}
