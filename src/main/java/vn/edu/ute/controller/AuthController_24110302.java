package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.ute.entity.User;
import vn.edu.ute.service.IUserService_24110302;
import vn.edu.ute.service.impl.UserServiceImpl_24110302;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/register", "/verify-otp", "/logout"})
public class AuthController_24110302 extends HttpServlet {

    private final IUserService_24110302 userService = new UserServiceImpl_24110302();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/logout")) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (uri.contains("/register")) {
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        } else if (uri.contains("/verify-otp")) {
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        if (uri.contains("/login")) {
            handleLogin(req, resp);
        } else if (uri.contains("/register")) {
            handleRegister(req, resp);
        } else if (uri.contains("/verify-otp")) {
            handleVerifyOTP(req, resp);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userService.login(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("account", user);

            String roleName = (user.getRole() != null) ? user.getRole().getRoleName() : "USER";

            if ("ADMIN".equalsIgnoreCase(roleName)) {
                resp.sendRedirect(req.getContextPath() + "/admin/category");
            } else if ("SELLER".equalsIgnoreCase(roleName)) {
                resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng hoặc tài khoản chưa được kích hoạt!");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setFullname(fullname);
        user.setPassword(password);
        user.setPhone(phone);

        boolean success = userService.register(user);

        if (success) {
            req.getSession().setAttribute("verifyEmail", email);
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            req.setAttribute("error", "Đăng ký thất bại! Username hoặc Email đã tồn tại trong hệ thống.");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        }
    }

    private void handleVerifyOTP(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String otpCode = req.getParameter("otpCode");

        boolean verified = userService.verifyOTP(email, otpCode);

        if (verified) {
            req.setAttribute("message", "Xác thực OTP thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Mã OTP không đúng. Vui lòng kiểm tra lại!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
        }
    }
}
