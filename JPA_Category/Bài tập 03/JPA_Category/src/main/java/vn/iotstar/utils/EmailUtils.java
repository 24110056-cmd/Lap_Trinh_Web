package vn.iotstar.utils;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtils {

    // 1. Điền địa chỉ Gmail CỦA BẠN (đóng vai trò làm email hệ thống gửi thư)
    private static final String SENDER_EMAIL = "thaodao0809@gmail.com";

    // 2. Điền chuỗi 16 ký tự App Password của Gmail trên (viết liền không dấu cách)
    private static final String APP_PASSWORD = "xlmfoelboijmwsli";

    public static boolean sendEmail(String toEmail, String subject, String messageText) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "Hệ Thống Xác Thực", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject, "UTF-8");
            message.setText(messageText, "UTF-8");

            Transport.send(message);

            System.out.println("GỬI OTP THÀNH CÔNG ĐẾN: " + toEmail);
            return true;

        } catch (Exception e) {
            System.err.println("GỬI OTP THẤT BẠI: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
