<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sản Phẩm - ShopMark</title>

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

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold text-dark mb-1">Tất Cả Sản Phẩm</h2>
                    <p class="text-muted">Khám phá các sản phẩm đa dạng gom nhóm theo nhà bán hàng</p>
                </div>
            </div>

            <c:forEach var="entry" items="${productsBySeller}">
                <c:set var="seller" value="${entry.key}" />
                <c:set var="productList" value="${entry.value}" />

                <div class="mb-5">
                    <div class="seller-header shadow-sm">
                        <img src="${seller.images != null ? seller.images : 'https://images.unsplash.com/photo-1534723452862-4c874018d66d?w=100'}" 
                             alt="${seller.sellerName}" class="seller-avatar">
                        <div>
                            <h5 class="mb-0 fw-bold text-white">${seller.sellerName}</h5>
                            <small class="text-light">Nhà cung cấp đối tác</small>
                        </div>
                    </div>

                    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                        <c:forEach var="p" items="${productList}">
                            <div class="col">
                                <div class="card h-100 product-card">
                                    <img src="${p.images != null ? p.images : 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400'}" 
                                         class="card-img-top" alt="${p.productName}" style="height: 200px; object-fit: cover;">
                                    <div class="card-body d-flex flex-column">
                                        <span class="badge bg-secondary mb-2 w-auto me-auto">${p.category.categoryName}</span>
                                        <h6 class="text-muted small mb-1">Mã: ${p.productCode}</h6>
                                        <h5 class="card-title fs-6 fw-bold">
                                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.productId}" class="text-decoration-none text-dark">
                                                ${p.productName}
                                            </a>
                                        </h5>
                                        <div class="mt-auto pt-3 border-top">
                                            <div class="text-danger fw-bold fs-5">${p.price} VNĐ</div>
                                            <small class="text-muted">Số lượng: ${p.amount}</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <!-- Footer Component -->
    <jsp:include page="/views/common/footer.jsp" />

</body>
</html>
