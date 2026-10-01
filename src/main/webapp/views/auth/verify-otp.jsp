<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP qua Email</title>
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
            max-width: 440px;
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
            <div class="bg-warning text-dark d-inline-flex align-items-center justify-content-center rounded-circle mb-3" style="width: 60px; height: 60px;">
                <i class="fa-envelope-open-text fa-solid fs-3"></i>
            </div>
            <h3 class="fw-bold text-dark">Xác Thực OTP</h3>
            <p class="text-muted small">Vui lòng nhập mã OTP đã được gửi đến email của bạn</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger small text-center py-2 mb-3">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
            <div class="mb-3">
                <label class="form-label fw-medium text-secondary">Email nhận OTP</label>
                <input type="email" name="email" class="form-control bg-light" 
                       value="${sessionScope.verifyEmail != null ? sessionScope.verifyEmail : email}" required readonly>
            </div>

            <div class="mb-4">
                <label class="form-label fw-medium text-secondary">Mã OTP (6 chữ số)</label>
                <input type="text" name="otpCode" class="form-control text-center fs-4 fw-bold letter-spacing-2" required placeholder="123456" maxlength="6">
            </div>

            <button type="submit" class="btn btn-success w-100 rounded-pill py-2.5 fw-bold mb-3">
                Xác Nhận Kích Hoạt
            </button>
        </form>
    </div>

</body>
</html>
