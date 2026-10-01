<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product != null ? 'Cập Nhật Sản Phẩm' : 'Thêm Sản Phẩm Mới'}</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f1f5f9; color: #0f172a; min-height: 100vh; display: flex; flex-direction: column; }
        .admin-sidebar { width: 260px; background: #0f172a; color: #94a3b8; min-height: 100vh; position: fixed; top: 0; left: 0; z-index: 1000; }
        .admin-main { margin-left: 260px; flex: 1; display: flex; flex-direction: column; }
        .admin-header { background: #ffffff; border-bottom: 1px solid #e2e8f0; padding: 1rem 2rem; }
        .nav-item-admin { padding: 0.75rem 1.5rem; color: #94a3b8; display: flex; align-items: center; gap: 0.75rem; text-decoration: none; font-weight: 500; border-radius: 8px; margin: 0.25rem 1rem; transition: all 0.2s ease; }
        .nav-item-admin:hover, .nav-item-admin.active { background: #1e293b; color: #38bdf8; }
        .footer-admin { background: #ffffff; border-top: 1px solid #e2e8f0; padding: 1.5rem 0; margin-top: auto; }
        .badge-exam-admin { background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); font-size: 0.85rem; padding: 0.4em 0.8em; border-radius: 20px; }
    </style>
</head>
<body>

    <!-- Admin Sidebar -->
    <aside class="admin-sidebar d-flex flex-column py-4">
        <div class="px-4 mb-4">
            <h4 class="text-white fw-bold mb-0"><i class="fa-solid fa-shield-halved text-info me-2"></i>Admin Dashboard</h4>
            <span class="small text-muted">Hệ thống quản lý</span>
        </div>
        <nav class="flex-1">
            <a href="${pageContext.request.contextPath}/home" class="nav-item-admin"><i class="fa-solid fa-store"></i> Xem Cửa hàng</a>
            <div class="text-uppercase px-4 mt-3 mb-2 small fw-bold text-slate-500" style="font-size: 0.75rem;">Quản lý dữ liệu</div>
            <a href="${pageContext.request.contextPath}/admin/category" class="nav-item-admin"><i class="fa-solid fa-list"></i> Danh mục (Category)</a>
            <a href="${pageContext.request.contextPath}/admin/product" class="nav-item-admin active"><i class="fa-solid fa-box"></i> Sản phẩm (Product)</a>
        </nav>
        <div class="px-3 mt-auto">
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger w-100 rounded-pill"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a>
        </div>
    </aside>

    <!-- Main Admin Container -->
    <div class="admin-main">
        <header class="admin-header d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0 text-slate-800">Trang Quản Trị Hệ Thống</h5>
            <div class="d-flex align-items-center gap-3">
                <span class="fw-medium text-slate-700"><i class="fa-solid fa-user-circle me-1 text-primary"></i> ${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}</span>
            </div>
        </header>

        <div class="p-4 flex-1">
            <div class="row justify-content-center mb-5">
                <div class="col-md-10 col-lg-8">
                    <div class="card border-0 shadow-lg rounded-4">
                        <div class="card-header bg-dark text-white p-4 rounded-top-4">
                            <h4 class="mb-0 fw-bold">
                                <i class="fa-solid fa-box text-info me-2"></i>
                                ${product != null ? 'Cập Nhật Sản Phẩm' : 'Thêm Sản Phẩm Mới'}
                            </h4>
                        </div>
                        <div class="card-body p-4">
                            <form action="${pageContext.request.contextPath}/admin/product" method="post">
                                <input type="hidden" name="productId" value="${product != null ? product.productId : ''}">

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Tên Sản Phẩm</label>
                                        <input type="text" name="productName" class="form-control" required 
                                               value="${product != null ? product.productName : ''}" placeholder="Nhập tên sản phẩm">
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Mã Sản Phẩm (Code)</label>
                                        <input type="text" name="productCode" class="form-control" required 
                                               value="${product != null ? product.productCode : ''}" placeholder="SP001">
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Danh Mục (Category)</label>
                                        <select name="categoryId" class="form-select" required>
                                            <option value="">-- Chọn danh mục --</option>
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.categoryId}" ${product != null && product.category != null && product.category.categoryId == cat.categoryId ? 'selected' : ''}>
                                                    ${cat.categoryName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Cửa Hàng (Seller)</label>
                                        <select name="sellerId" class="form-select" required>
                                            <option value="">-- Chọn cửa hàng --</option>
                                            <c:forEach var="s" items="${sellers}">
                                                <option value="${s.sellerId}" ${product != null && product.seller != null && product.seller.sellerId == s.sellerId ? 'selected' : ''}>
                                                    ${s.sellerName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label fw-bold">Giá Bán (VNĐ)</label>
                                        <input type="number" step="0.01" name="price" class="form-control" required 
                                               value="${product != null ? product.price : ''}" placeholder="1500000">
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label fw-bold">Amount</label>
                                        <input type="number" name="amount" class="form-control" required 
                                               value="${product != null ? product.amount : '10'}" placeholder="10">
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label fw-bold">Stock</label>
                                        <input type="number" name="stock" class="form-control" required 
                                               value="${product != null ? product.stock : '100'}" placeholder="100">
                                    </div>

                                    <div class="col-md-8">
                                        <label class="form-label fw-bold">Link Hình Ảnh (URL)</label>
                                        <input type="text" name="images" class="form-control" 
                                               value="${product != null ? product.images : ''}" placeholder="https://example.com/product.jpg">
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label fw-bold">Trạng Thái</label>
                                        <select name="status" class="form-select">
                                            <option value="1" ${product != null && product.status == 1 ? 'selected' : ''}>Hoạt động</option>
                                            <option value="0" ${product != null && product.status == 0 ? 'selected' : ''}>Khóa / Ngừng bán</option>
                                        </select>
                                    </div>

                                    <div class="col-12">
                                        <label class="form-label fw-bold">Mô Tả Sản Phẩm (Description)</label>
                                        <textarea name="description" class="form-control" rows="4" placeholder="Nhập mô tả chi tiết sản phẩm...">${product != null ? product.description : ''}</textarea>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end gap-2 mt-4">
                                    <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-outline-secondary px-4 rounded-pill">Hủy</a>
                                    <button type="submit" class="btn btn-primary px-4 rounded-pill">Lưu Sản Phẩm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer-admin">
            <div class="container-fluid px-4 text-center">
                <span class="badge-exam-admin text-white d-inline-block shadow-sm">
                    <i class="fa-solid fa-user-graduate me-1"></i> Họ tên: Lê Huỳnh Phong | MSSV: 24110302 | Mã đề 05
                </span>
            </div>
        </footer>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
