<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa Hàng Trực Tuyến</title>
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
        .nav-link:hover { color: #ffffff !important; }
        .main-content { flex: 1; padding: 2.5rem 0; }
        .footer-custom { background: #0f172a; color: #94a3b8; padding: 2rem 0; margin-top: auto; border-top: 1px solid #1e293b; }
        .badge-exam { background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%); font-size: 0.85rem; padding: 0.4em 0.8em; border-radius: 20px; }
        .product-card { border: none; border-radius: 16px; background: #ffffff; transition: all 0.3s ease; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); overflow: hidden; }
        .product-card:hover { transform: translateY(-6px); box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1); }
        .seller-header { background: linear-gradient(135deg, #475569 0%, #334155 100%); color: white; padding: 1rem 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 1rem; }
        .seller-avatar { width: 48px; height: 48px; border-radius: 50%; object-fit: cover; border: 2px solid #818cf8; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom py-3">
        <div class="container">
            <a class="navbar-brand text-white d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-store text-warning"></i>
                <span class="fs-4">ShopMark</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarWeb">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarWeb">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house me-1"></i> Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products"><i class="fa-solid fa-box-open me-1"></i> Sản phẩm</a>
                    </li>
                    <c:if test="${sessionScope.account != null && sessionScope.account.role.roleName == 'ADMIN'}">
                        <li class="nav-item">
                            <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/admin/category"><i class="fa-solid fa-user-shield me-1"></i> Trang quản trị</a>
                        </li>
                    </c:if>
                </ul>
                <div class="d-flex align-items-center gap-3">
                    <c:choose>
                        <c:when test="${sessionScope.account != null}">
                            <div class="dropdown">
                                <button class="btn btn-outline-light dropdown-toggle rounded-pill px-3" type="button" data-bs-toggle="dropdown">
                                    <i class="fa-solid fa-circle-user fs-5 text-warning me-1"></i>
                                    <span>${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}</span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                                    <li><span class="dropdown-item-text text-muted small">Vai trò: ${sessionScope.account.role.roleName}</span></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light rounded-pill px-4 me-2"><i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary rounded-pill px-4" style="background: #6366f1; border: none;">Đăng ký</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
    <main class="main-content">
        <div class="container">
            <jsp:include page="/WEB-INF/views/includes/header.jsp" false />
            <jsp:include page="${param.bodyPage != null ? param.bodyPage : ''}" />
        </div>
    </main>
</body>
</html>
