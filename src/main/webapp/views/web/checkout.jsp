<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận Thanh Toán COD - ShopMark</title>

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
        .main-content { flex: 1; padding-bottom: 3rem; }
    </style>
</head>
<body>

    <!-- Header Component -->
    <jsp:include page="/views/common/header.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <h2 class="fw-bold text-dark mb-4">
                <i class="fa-solid fa-truck-fast text-success me-2"></i> Thanh Toán Đơn Hàng (COD)
            </h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show mb-4">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/checkout/process" method="post">
                <div class="row g-4">
                    <!-- Delivery Info Form -->
                    <div class="col-lg-7">
                        <div class="card border-0 shadow-sm rounded-4 p-4">
                            <h4 class="fw-bold text-dark mb-3"><i class="fa-solid fa-address-card text-primary me-2"></i> Thông Tin Nhận Hàng</h4>
                            <hr />

                            <div class="mb-3">
                                <label class="form-label fw-bold">Họ và tên người nhận</label>
                                <input type="text" class="form-control" value="${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Số điện thoại liên hệ</label>
                                <input type="text" class="form-control" value="${sessionScope.account.phone != null ? sessionScope.account.phone : '0901234567'}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Địa chỉ giao hàng</label>
                                <textarea class="form-control" rows="3" required placeholder="Nhập số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố...">Số 1 Võ Văn Nâng, Phường Linh Chiểu, TP. Thủ Đức, TP. Hồ Chí Minh</textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Phương thức thanh toán</label>
                                <div class="p-3 border rounded-3 bg-light d-flex align-items-center gap-3">
                                    <input type="radio" name="paymentMethod" value="COD" checked class="form-check-input fs-5">
                                    <div>
                                        <div class="fw-bold text-dark"><i class="fa-solid fa-hand-holding-dollar text-success me-1"></i> Thanh toán khi nhận hàng (COD)</div>
                                        <small class="text-muted">Bạn chỉ thanh toán khi đơn hàng được giao đến tận tay.</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Summary -->
                    <div class="col-lg-5">
                        <div class="card border-0 shadow-sm rounded-4 p-4">
                            <h4 class="fw-bold text-dark mb-3">Đơn Hàng Của Bạn</h4>
                            <hr />

                            <div class="vstack gap-3 mb-3" style="max-height: 250px; overflow-y: auto;">
                                <c:forEach var="item" items="${cartItems}">
                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                        <div class="d-flex align-items-center gap-2">
                                            <img src="${item.product.images != null ? item.product.images : 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=100'}" 
                                                 alt="${item.product.productName}" class="rounded-2" style="width: 45px; height: 45px; object-fit: cover;">
                                            <div>
                                                <h6 class="mb-0 small fw-bold text-dark">${item.product.productName}</h6>
                                                <small class="text-muted">x${item.quantity}</small>
                                            </div>
                                        </div>
                                        <span class="fw-bold text-danger small">${item.unitPrice * item.quantity} VNĐ</span>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-secondary">Phí vận chuyển (COD):</span>
                                <span class="fw-bold text-success">Miễn phí</span>
                            </div>

                            <div class="d-flex justify-content-between mb-3 fs-5">
                                <span class="fw-bold text-dark">Tổng cộng:</span>
                                <span class="fw-bold text-danger">${grandTotal} VNĐ</span>
                            </div>

                            <button type="submit" class="btn btn-success w-100 py-2.5 rounded-pill fw-bold fs-6 mt-3">
                                <i class="fa-solid fa-check-circle me-2"></i> XÁC NHẬN ĐẶT HÀNG COD
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer Component -->
    <jsp:include page="/views/common/footer.jsp" />

</body>
</html>
