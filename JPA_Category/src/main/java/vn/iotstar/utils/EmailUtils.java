
package vn.iotstar.utils;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtils {

    // Gmail CỦA BẠN dùng để gửi OTP cho mọi người
    private static final String SENDER_EMAIL = "gmailcuaban@gmail.com";

    // App Password của Gmail gửi
    private static final String APP_PASSWORD = "app_password_cua_ban";

    public static boolean sendEmail(String toEmail, String subject, String messageText) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
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

            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(toEmail)
            );
            message.setSubject(subject);
            message.setText(messageText);

            Transport.send(message);

            System.out.println("GUI OTP THANH CONG DEN: " + toEmail);
            return true;

        } catch (Exception e) {
            System.out.println("GUI OTP THAT BAI!");
            e.printStackTrace();
            return false;
        }
    }
}
