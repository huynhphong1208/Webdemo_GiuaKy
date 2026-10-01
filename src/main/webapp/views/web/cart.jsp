<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng Của Bạn - ShopMark</title>

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
        .qty-input { width: 65px; text-align: center; }
    </style>
</head>
<body>

    <!-- Header Component -->
    <jsp:include page="/views/common/header.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <h2 class="fw-bold text-dark mb-4">
                <i class="fa-solid fa-cart-shopping text-primary me-2"></i> Giỏ Hàng Của Bạn
            </h2>

            <!-- Message Notifications -->
            <c:if test="${not empty sessionScope.msgSuccess}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-circle-check me-2"></i> ${sessionScope.msgSuccess}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="msgSuccess" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.msgError}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i> ${sessionScope.msgError}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="msgError" scope="session"/>
            </c:if>

            <c:choose>
                <c:when test="${not empty cartItems}">
                    <div class="row g-4">
                        <!-- Table Cart Items -->
                        <div class="col-lg-8">
                            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-dark">
                                            <tr>
                                                <th class="ps-4">Sản Phẩm</th>
                                                <th>Đơn Giá</th>
                                                <th style="width: 160px;">Số Lượng</th>
                                                <th>Thành Tiền</th>
                                                <th class="text-end pe-4">Xóa</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${cartItems}">
                                                <tr>
                                                    <td class="ps-4">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <img src="${item.product.images != null ? item.product.images : 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=100'}" 
                                                                 alt="${item.product.productName}" class="rounded-3" style="width: 60px; height: 60px; object-fit: cover;">
                                                            <div>
                                                                <h6 class="mb-0 fw-bold text-dark">${item.product.productName}</h6>
                                                                <small class="text-muted">Mã: ${item.product.productCode} | Kho: <span class="badge bg-info text-dark">${item.product.amount}</span></small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="fw-semibold">${item.unitPrice} VNĐ</td>
                                                    <td>
                                                        <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-flex align-items-center gap-1">
                                                            <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                                            <button type="button" onclick="var input=this.form.quantity; var val=parseInt(input.value)-1; if(val>=1){input.value=val; this.form.submit();}" class="btn btn-sm btn-outline-secondary px-2" ${item.quantity <= 1 ? 'disabled' : ''}>-</button>
                                                            <input type="number" name="quantity" value="${item.quantity}" class="form-control form-control-sm qty-input" min="1" max="${item.product.amount}" onchange="if(this.value>=1 && this.value<=${item.product.amount}){this.form.submit();}">
                                                            <button type="button" onclick="var input=this.form.quantity; var val=parseInt(input.value)+1; if(val<=${item.product.amount}){input.value=val; this.form.submit();}" class="btn btn-sm btn-outline-secondary px-2" ${item.quantity >= item.product.amount ? 'disabled' : ''}>+</button>
                                                        </form>
                                                    </td>
                                                    <td class="fw-bold text-danger">${item.unitPrice * item.quantity} VNĐ</td>
                                                    <td class="text-end pe-4">
                                                        <a href="${pageContext.request.contextPath}/cart/delete?id=${item.cartItemId}" 
                                                           class="btn btn-sm btn-outline-danger" onclick="return confirm('Xóa sản phẩm này khỏi giỏ?');">
                                                            <i class="fa-solid fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Summary Card -->
                        <div class="col-lg-4">
                            <div class="card border-0 shadow-sm rounded-4 p-4">
                                <h4 class="fw-bold mb-3">Tóm Tắt Đơn Hàng</h4>
                                <hr />
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-secondary">Tổng số lượng sản phẩm:</span>
                                    <span class="fw-bold">${totalItemCount}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-3 fs-5">
                                    <span class="fw-bold text-dark">Tổng tiền thanh toán:</span>
                                    <span class="fw-bold text-danger">${grandTotal} VNĐ</span>
                                </div>

                                <div class="d-grid gap-2 mt-4">
                                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success py-2.5 rounded-pill fw-bold fs-6">
                                        <i class="fa-solid fa-credit-card me-2"></i> Tiến Hành Thanh Toán COD
                                    </a>
                                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary py-2 rounded-pill">
                                        <i class="fa-solid fa-arrow-left me-1"></i> Tiếp tục mua hàng
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5 bg-white shadow-sm rounded-4 my-4">
                        <i class="fa-solid fa-basket-shopping text-muted fs-1 mb-3"></i>
                        <h4 class="fw-bold text-secondary">Giỏ hàng của bạn đang trống!</h4>
                        <p class="text-muted">Hãy chọn thêm sản phẩm vào giỏ hàng để tiến hành mua sắm.</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary rounded-pill px-4 mt-2" style="background: #6366f1; border: none;">
                            Khám phá sản phẩm
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- Footer Component -->
    <jsp:include page="/views/common/footer.jsp" />

</body>
</html>
