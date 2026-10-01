<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- Global Header Included Navbar -->
<style>
    .navbar-custom { background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%); box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
    .navbar-brand { font-weight: 700; color: #ffffff !important; }
    .nav-link { font-weight: 500; color: #cbd5e1 !important; transition: all 0.2s ease; }
    .nav-link:hover, .nav-link.active { color: #ffffff !important; }
</style>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom py-3 mb-4">
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
                    <a class="nav-link ${pageContext.request.requestURI.endsWith('/home') || pageContext.request.requestURI.endsWith('/') ? 'active fw-bold' : ''}" 
                       href="${pageContext.request.contextPath}/home">
                        <i class="fa-solid fa-house me-1"></i> Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('/product') && !pageContext.request.requestURI.contains('/admin/') ? 'active fw-bold' : ''}" 
                       href="${pageContext.request.contextPath}/products">
                        <i class="fa-solid fa-box-open me-1"></i> Sản phẩm
                    </a>
                </li>
                <c:if test="${sessionScope.account != null && sessionScope.account.role.roleName == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/admin/category">
                            <i class="fa-solid fa-user-shield me-1"></i> Trang quản trị
                        </a>
                    </li>
                </c:if>
            </ul>

            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light rounded-circle p-2 position-relative text-white" title="Giỏ hàng">
                    <i class="fa-solid fa-cart-shopping fs-5"></i>
                </a>

                <c:choose>
                    <c:when test="${sessionScope.account != null}">
                        <div class="dropdown">
                            <button class="btn btn-outline-light dropdown-toggle d-flex align-items-center gap-2 rounded-pill px-3" type="button" data-bs-toggle="dropdown">
                                <i class="fa-solid fa-circle-user fs-5 text-warning"></i>
                                <span>${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                                <li><span class="dropdown-item-text text-muted small">Vai trò: ${sessionScope.account.role.roleName}</span></li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light rounded-pill px-4 me-2">
                            <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập
                        </a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary rounded-pill px-4" style="background: #6366f1; border: none;">
                            Đăng ký
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>
