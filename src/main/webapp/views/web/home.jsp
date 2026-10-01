<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - ShopMark</title>

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
        .product-card { border: none; border-radius: 16px; background: #ffffff; transition: all 0.3s ease; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); overflow: hidden; }
        .product-card:hover { transform: translateY(-6px); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1); }
        .seller-header { background: linear-gradient(135deg, #475569 0%, #334155 100%); color: white; padding: 1rem 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 1rem; }
        .seller-avatar { width: 48px; height: 48px; border-radius: 50%; object-fit: cover; border: 2px solid #818cf8; }
    </style>
</head>
<body>

    <!-- Header Component -->
    <jsp:include page="/views/common/header.jsp" />

    <!-- Main Content Area -->
    <main class="main-content">
        <div class="container">
            <div class="mb-4">
                <h2 class="fw-bold text-dark mb-1">Cửa Hàng & Sản Phẩm Nổi Bật</h2>
                <p class="text-muted">Danh sách tất cả sản phẩm được gom nhóm theo từng cửa hàng (Seller)</p>
            </div>

            <c:forEach var="entry" items="${productsBySeller}">
                <c:set var="seller" value="${entry.key}" />
                <c:set var="productList" value="${entry.value}" />

                <div class="mb-5">
                    <!-- Seller Header Card -->
                    <div class="seller-header shadow-sm">
                        <img src="${seller.images != null ? seller.images : 'https://images.unsplash.com/photo-1534723452862-4c874018d66d?w=100'}" 
                             alt="${seller.sellerName}" class="seller-avatar">
                        <div>
                            <h4 class="mb-0 fw-bold text-white">${seller.sellerName}</h4>
                            <span class="badge bg-success mt-1">Cửa hàng xác thực</span>
                        </div>
                    </div>

                    <!-- Products List -->
                    <c:choose>
                        <c:when test="${not empty productList}">
                            <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                                <c:forEach var="p" items="${productList}">
                                    <div class="col">
                                        <div class="card h-100 product-card">
                                            <div class="position-relative">
                                                <img src="${p.images != null ? p.images : 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400'}" 
                                                     class="card-img-top" alt="${p.productName}" style="height: 200px; object-fit: cover;">
                                                <span class="position-absolute top-0 end-0 bg-primary text-white px-2 py-1 rounded-bl small m-2 badge">
                                                    ${p.category != null ? p.category.categoryName : 'Chưa phân loại'}
                                                </span>
                                            </div>
                                            <div class="card-body d-flex flex-column">
                                                <h6 class="card-subtitle text-muted mb-1 small">Mã SP: ${p.productCode}</h6>
                                                <h5 class="card-title fw-bold fs-6">
                                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.productId}" class="text-decoration-none text-dark">
                                                        ${p.productName}
                                                    </a>
                                                </h5>
                                                <div class="mt-auto pt-3 border-top d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <div class="text-danger fw-bold fs-5">${p.price} VNĐ</div>
                                                        <small class="text-muted">Còn lại: ${p.amount != null ? p.amount : 0}</small>
                                                    </div>
                                                    <div class="d-flex gap-1">
                                                        <form action="${pageContext.request.contextPath}/cart/add" method="post" class="d-inline">
                                                            <input type="hidden" name="productId" value="${p.productId}">
                                                            <input type="hidden" name="quantity" value="1">
                                                            <button type="submit" class="btn btn-sm btn-primary rounded-circle" style="background: #6366f1; border: none;" title="Thêm vào giỏ">
                                                                <i class="fa-solid fa-cart-plus"></i>
                                                            </button>
                                                        </form>
                                                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.productId}" class="btn btn-sm btn-outline-primary rounded-circle" title="Xem chi tiết">
                                                            <i class="fa-solid fa-arrow-right"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-light text-center py-4 border rounded">
                                <p class="mb-0 text-muted">Cửa hàng này hiện chưa đăng bán sản phẩm nào.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
        </div>
    </main>

    <!-- Footer Component -->
    <jsp:include page="/views/common/footer.jsp" />

</body>
</html>
