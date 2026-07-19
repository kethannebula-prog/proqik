package com.proqik.util;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;

public class OtpService {

    private static final Map<String, OtpData> OTP_STORE = new HashMap<>();
    private static final int OTP_EXPIRY_MINUTES = 10;
    private static final int OTP_LENGTH = 6;
    private static final String APP_NAME = "ProQik";
    private static final String SMTP_HOST = System.getenv("SMTP_HOST") != null ? System.getenv("SMTP_HOST") : "email-smtp.ap-southeast-2.amazonaws.com";
    private static final String SMTP_PORT = System.getenv("SMTP_PORT") != null ? System.getenv("SMTP_PORT") : "587";
    private static final String SMTP_USER = System.getenv("SMTP_USER") != null ? System.getenv("SMTP_USER") : "";
    private static final String SMTP_PASSWORD = System.getenv("SMTP_PASSWORD") != null ? System.getenv("SMTP_PASSWORD") : "";

    public static class OtpData {
        public final String otp;
        public final long createdAt;
        public OtpData(String otp) {
            this.otp = otp;
            this.createdAt = System.currentTimeMillis();
        }
        public boolean isExpired() {
            return System.currentTimeMillis() - createdAt > OTP_EXPIRY_MINUTES * 60 * 1000;
        }
    }

    public static String generateOtp() {
        Random rand = new Random();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < OTP_LENGTH; i++) {
            otp.append(rand.nextInt(10));
        }
        return otp.toString();
    }

    public static void sendOtp(String email) {
        String otp = generateOtp();
        OTP_STORE.put(email, new OtpData(otp));
        System.out.println("=== PROQIK OTP === To: " + email + " | OTP: " + otp);
        sendEmail(email, "Verify your " + APP_NAME + " Email",
                "<!DOCTYPE html><html><head><meta charset='UTF-8'>" +
                "<style>body{font-family:'Segoe UI',Arial,sans-serif;background:#f5f5f5;margin:0;padding:32px 16px}" +
                ".card{max-width:480px;margin:0 auto;background:#fff;border-radius:16px;overflow:hidden;box-shadow:0 8px 40px rgba(0,0,0,.08)}" +
                ".header{background:#0a1628;padding:28px 24px;text-align:center}" +
                ".header h1{color:#D4A574;font-size:22px;margin:0;letter-spacing:2px}" +
                ".body{padding:32px 24px;text-align:center}" +
                ".body h2{font-size:18px;color:#1a1a2e;margin:0 0 8px}" +
                ".body p{font-size:14px;color:#666;margin:0 0 24px;line-height:1.6}" +
                ".otp{display:inline-block;background:#f8f7f4;border:2px dashed #D4A574;border-radius:12px;padding:16px 40px;font-size:32px;font-weight:700;letter-spacing:8px;color:#0a1628;margin:16px 0}" +
                ".footer{background:#f8f7f4;padding:20px 24px;text-align:center;font-size:12px;color:#999}" +
                "</style></head><body>" +
                "<div class='card'><div class='header'><h1>PROQIK</h1></div><div class='body'>" +
                "<h2>Verify your email address</h2>" +
                "<p>Use the OTP below to complete your ProQik account verification. This code expires in " + OTP_EXPIRY_MINUTES + " minutes.</p>" +
                "<div class='otp'>" + otp + "</div>" +
                "<p style='margin-top:24px;font-size:13px;color:#999'>If you didn't request this, you can safely ignore this email.</p>" +
                "</div><div class='footer'>&copy; " + java.time.Year.now() + " ProQik. All rights reserved.</div></div></body></html>");
    }

    public static boolean sendStatusNotification(String toEmail, String name, String status) {
        System.out.println("DEBUG: Sending status email to " + toEmail + " [" + status + "]");
        String actionLabel = "approved".equals(status) ? "Approved" : "Rejected";
        String msgColor = "approved".equals(status) ? "#10b981" : "#ef4444";
        String msgBg = "approved".equals(status) ? "#ecfdf5" : "#fef2f2";
        String msgText = "approved".equals(status)
                ? "Congratulations! Your vendor application has been <strong>approved</strong>. You can now log in and start accepting bookings on ProQik."
                : "We regret to inform you that your vendor application has been <strong>rejected</strong>. Please contact our support team if you have any questions.";

        return sendEmail(toEmail, "ProQik - Application " + actionLabel,
                "<!DOCTYPE html><html><head><meta charset='UTF-8'>" +
                "<style>body{font-family:'Segoe UI',Arial,sans-serif;background:#f5f5f5;margin:0;padding:32px 16px}" +
                ".card{max-width:480px;margin:0 auto;background:#fff;border-radius:16px;overflow:hidden;box-shadow:0 8px 40px rgba(0,0,0,.08)}" +
                ".header{background:#0a1628;padding:28px 24px;text-align:center}" +
                ".header h1{color:#D4A574;font-size:22px;margin:0;letter-spacing:2px}" +
                ".body{padding:32px 24px;text-align:center}" +
                ".body h2{font-size:18px;color:#1a1a2e;margin:0 0 8px}" +
                ".body p{font-size:14px;color:#666;margin:0 0 24px;line-height:1.6}" +
                ".status-box{display:inline-block;background:" + msgBg + ";color:" + msgColor + ";border:2px solid " + msgColor + ";border-radius:12px;padding:12px 32px;font-size:18px;font-weight:700;margin:16px 0}" +
                ".footer{background:#f8f7f4;padding:20px 24px;text-align:center;font-size:12px;color:#999}" +
                "</style></head><body>" +
                "<div class='card'><div class='header'><h1>PROQIK</h1></div><div class='body'>" +
                "<h2>Vendor Application " + actionLabel + "</h2>" +
                "<p>Dear " + (name != null ? name : "Vendor") + ",</p>" +
                "<p>" + msgText + "</p>" +
                "<div class='status-box'>" + actionLabel + "</div>" +
                "<p style='margin-top:24px;font-size:13px;color:#999'>If you have questions, contact support@proqik.com</p>" +
                "</div><div class='footer'>&copy; " + java.time.Year.now() + " ProQik. All rights reserved.</div></div></body></html>");
    }

    private static boolean sendEmail(String toEmail, String subject, String htmlBody) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.ssl.trust", SMTP_HOST);
            props.put("mail.smtp.connectiontimeout", "10000");
            props.put("mail.smtp.timeout", "10000");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SMTP_USER, SMTP_PASSWORD);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USER, APP_NAME, "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject, "UTF-8");
            message.setContent(htmlBody, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("DEBUG: Email sent successfully to " + toEmail);
            return true;
        } catch (Exception e) {
            System.out.println("DEBUG: Email failed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static boolean verifyOtp(String email, String inputOtp) {
        if (email == null || inputOtp == null) return false;
        OtpData data = OTP_STORE.get(email);
        if (data == null) return false;
        if (data.isExpired()) { OTP_STORE.remove(email); return false; }
        if (data.otp.equals(inputOtp)) { OTP_STORE.remove(email); return true; }
        return false;
    }

    public static void main(String[] args) {
        // Test email - provide a recipient address
        if (args.length > 0) {
            sendStatusNotification(args[0], "Test User", "Approved");
        } else {
            System.out.println("Usage: java OtpService.java <recipient-email>");
        }
    }
}