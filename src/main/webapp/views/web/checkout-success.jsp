<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Hàng Thành Công - ShopMark</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar-custom { background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%) !important; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .navbar-brand { font-weight: 700; color: #ffffff !important; }
        .nav-link { font-weight: 500; color: #cbd5e1 !important; transition: all 0.2s ease; }
        .nav-link:hover, .nav-link.active { color: #ffffff !important; }
        .main-content { flex: 1; display: flex; align-items: center; justify-content: center; padding: 4rem 0; }
    </style>
</head>
<body>

    <!-- Header Component -->
    <jsp:include page="/views/common/header.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6 text-center">
                    <div class="card border-0 shadow-lg rounded-4 p-5">
                        <div class="mb-4">
                            <div class="d-inline-flex align-items-center justify-content-center bg-success text-white rounded-circle shadow" style="width: 80px; height: 80px;">
                                <i class="fa-solid fa-check fs-1"></i>
                            </div>
                        </div>

                        <h2 class="fw-bold text-dark mb-2">Đặt Hàng Thành Công!</h2>
                        <p class="text-muted mb-4">Cảm ơn bạn đã mua sắm tại <b>ShopMark</b>. Đơn hàng COD của bạn đã được tiếp nhận và hệ thống đã cập nhật trừ kho khả dụng.</p>

                        <div class="p-3 bg-light rounded-3 text-start mb-4">
                            <div class="small text-muted mb-1"><i class="fa-solid fa-truck me-2 text-primary"></i> Phương thức: <strong>Thanh toán khi nhận hàng (COD)</strong></div>
                            <div class="small text-muted"><i class="fa-solid fa-clock me-2 text-primary"></i> Trạng thái đơn hàng: <strong>Đang chuẩn bị hàng</strong></div>
                        </div>

                        <div class="d-flex justify-content-center gap-3">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary rounded-pill px-4" style="background: #6366f1; border: none;">
                                <i class="fa-solid fa-house me-2"></i> Quay Về Trang Chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer Component -->
    <jsp:include page="/views/common/footer.jsp" />

</body>
</html>
