<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
        .auth-card {
            width: 100%;
            max-width: 480px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }
    </style>
</head>
<body>

    <div class="auth-card">
        <div class="text-center mb-4">
            <div class="bg-primary text-white d-inline-flex align-items-center justify-content-center rounded-circle mb-3" style="width: 60px; height: 60px; background: #6366f1 !important;">
                <i class="fa-solid fa-user-plus fs-3"></i>
            </div>
            <h3 class="fw-bold text-dark">Đăng Ký Tài Khoản</h3>
            <p class="text-muted small">Hệ thống sẽ gửi mã OTP xác thực qua Email</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger small text-center py-2 mb-3">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="mb-3">
                <label class="form-label fw-medium text-secondary">Tên đăng nhập (Username)</label>
                <input type="text" name="username" class="form-control" required placeholder="nguyenvana">
            </div>

            <div class="mb-3">
                <label class="form-label fw-medium text-secondary">Địa chỉ Email (Nhận OTP)</label>
                <input type="email" name="email" class="form-control" required placeholder="user@domain.com">
            </div>

            <div class="mb-3">
                <label class="form-label fw-medium text-secondary">Họ và tên</label>
                <input type="text" name="fullname" class="form-control" required placeholder="Nguyễn Văn A">
            </div>

            <div class="mb-3">
                <label class="form-label fw-medium text-secondary">Số điện thoại</label>
                <input type="text" name="phone" class="form-control" placeholder="0901234567">
            </div>

            <div class="mb-4">
                <label class="form-label fw-medium text-secondary">Mật khẩu</label>
                <input type="password" name="password" class="form-control" required placeholder="••••••••">
            </div>

            <button type="submit" class="btn btn-primary w-100 rounded-pill py-2.5 fw-bold mb-3" style="background: #6366f1; border: none;">
                Đăng Ký & Nhận OTP
            </button>

            <div class="text-center text-muted small">
                Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-indigo fw-bold text-decoration-none" style="color: #6366f1;">Đăng nhập</a>
            </div>
        </form>
    </div>

</body>
</html>
