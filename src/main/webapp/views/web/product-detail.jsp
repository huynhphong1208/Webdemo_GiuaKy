<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm - ${product.productName}</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar-custom { background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%); box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .navbar-brand { font-weight: 700; color: #6366f1 !important; }
        .nav-link { font-weight: 500; color: #cbd5e1 !important; transition: all 0.2s ease; }
        .nav-link:hover, .nav-link.active { color: #ffffff !important; }
        .main-content { flex: 1; padding-bottom: 3rem; }
        .footer-custom { background: #0f172a; color: #94a3b8; margin-top: auto; }
    </style>
</head>
<body>

    <!-- Header Component -->
    <jsp:include page="/views/common/header.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
                </ol>
            </nav>

            <c:choose>
                <c:when test="${product != null}">
                    <div class="card border-0 shadow-lg rounded-4 overflow-hidden mb-5">
                        <div class="row g-0">
                            <div class="col-md-5">
                                <img src="${product.images != null ? product.images : 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600'}" 
                                     class="img-fluid w-100 h-100" alt="${product.productName}" style="object-fit: cover; min-height: 380px;">
                            </div>
                            <div class="col-md-7 p-4 p-lg-5 d-flex flex-column justify-content-between">
                                <div>
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="badge bg-indigo text-white px-3 py-2 rounded-pill" style="background-color: #6366f1;">
                                            ${product.category != null ? product.category.categoryName : 'Danh mục N/A'}
                                        </span>
                                        <span class="text-muted small">Mã SP: <strong>${product.productCode}</strong></span>
                                    </div>

                                    <h2 class="fw-bold text-dark mb-3">${product.productName}</h2>
                                    <h3 class="text-danger fw-bold mb-4">${product.price} VNĐ</h3>

                                    <div class="mb-4">
                                        <h6 class="fw-bold text-secondary text-uppercase small">Cửa hàng cung cấp:</h6>
                                        <p class="fw-medium text-dark">
                                            <i class="fa-solid fa-store text-primary me-2"></i> ${product.seller != null ? product.seller.sellerName : 'N/A'}
                                        </p>
                                    </div>

                                    <div class="mb-4">
                                        <h6 class="fw-bold text-secondary text-uppercase small">Số lượng tồn kho / Đã bán:</h6>
                                        <p class="text-dark">
                                            Amount: <span class="badge bg-info text-dark me-2">${product.amount != null ? product.amount : 0}</span>
                                            Stock: <span class="badge bg-success">${product.stock != null ? product.stock : 0}</span>
                                        </p>
                                    </div>

                                    <div class="mb-4">
                                        <h6 class="fw-bold text-secondary text-uppercase small mb-2">Mô tả sản phẩm (Description):</h6>
                                        <div class="p-3 bg-light rounded-3 text-secondary" style="line-height: 1.6;">
                                            ${product.description != null ? product.description : 'Không có mô tả cho sản phẩm này.'}
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex gap-3 mt-4">
                                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary rounded-pill px-4">
                                        <i class="fa-solid fa-arrow-left me-2"></i> Quay lại
                                    </a>
                                    <form action="${pageContext.request.contextPath}/cart/add" method="post" class="d-inline">
                                        <input type="hidden" name="productId" value="${product.productId}">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn-primary rounded-pill px-4" style="background: #6366f1; border: none;">
                                            <i class="fa-solid fa-cart-plus me-2"></i> Thêm vào giỏ hàng
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-danger text-center my-5">
                        <h4>Sản phẩm không tồn tại!</h4>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary mt-3">Quay lại trang chủ</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- Footer Component -->
    <jsp:include page="/views/common/footer.jsp" />

</body>
</html>
