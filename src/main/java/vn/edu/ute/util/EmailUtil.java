package vn.edu.ute.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;
import java.util.Random;

public class EmailUtil {
    
    // Cấu hình Gmail SMTP với App Password
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587"; // Cổng TLS 587
    
    // NHẬP GMAIL VÀ APP PASSWORD CỦA BẠN VÀO 2 DÒNG DƯỚI ĐÂY:
    private static final String SENDER_EMAIL = "lephongle475@gmail.com";     // Ví dụ: phong24110302@gmail.com
    private static final String SENDER_PASSWORD = "bztdhbfomsvkgobf"; // Mã App Password 16 ký tự của Gmail

    public static String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    public static boolean sendOTPEmail(String toEmail, String otpCode) {
        System.out.println("==================================================");
        System.out.println("[EMAIL SYSTEM] Gửi OTP thực tế đến: " + toEmail);
        System.out.println("[EMAIL SYSTEM] Mã OTP sinh ra là: " + otpCode);
        System.out.println("==================================================");

        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "Hệ Thống Web Giữa Kỳ - Lê Huỳnh Phong"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã OTP Xác Thực Tài Khoản - Lê Huỳnh Phong 24110302");
            
            String htmlContent = "<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px; max-width: 500px;'>"
                    + "<h2 style='color: #6366f1; text-align: center;'>Xác Thực Tài Khoản</h2>"
                    + "<p>Xin chào,</p>"
                    + "<p>Mã OTP kích hoạt tài khoản của bạn trên hệ thống <b>ShopMark</b> là:</p>"
                    + "<div style='background: #f1f5f9; padding: 15px; font-size: 24px; font-weight: bold; color: #0f172a; text-align: center; border-radius: 8px; letter-spacing: 4px;'>"
                    + otpCode
                    + "</div>"
                    + "<p style='color: #64748b; font-size: 13px; margin-top: 15px;'>Mã có hiệu lực trong 5 phút. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>"
                    + "<hr style='border: none; border-top: 1px solid #eee;' />"
                    + "<p style='font-size: 12px; color: #94a3b8; text-align: center;'>Họ tên: Lê Huỳnh Phong | MSSV: 24110302 | Mã đề 05</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            // Thực hiện gửi Mail thực tế qua SMTP
            Transport.send(message);
            System.out.println("[EMAIL SYSTEM] -> ĐÃ GỬI EMAIL THÀNH CÔNG ĐẾN: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("[EMAIL SYSTEM ERROR] Lỗi gửi Email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
