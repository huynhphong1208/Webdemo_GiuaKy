<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục (Category)</title>
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
            <a href="${pageContext.request.contextPath}/admin/category" class="nav-item-admin active"><i class="fa-solid fa-list"></i> Danh mục (Category)</a>
            <a href="${pageContext.request.contextPath}/admin/product" class="nav-item-admin"><i class="fa-solid fa-box"></i> Sản phẩm (Product)</a>
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
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold text-dark mb-1">Quản Lý Danh Mục</h3>
                    <p class="text-muted small mb-0">Danh sách các danh mục sản phẩm trong hệ thống</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary rounded-pill px-4">
                    <i class="fa-solid fa-plus me-2"></i> Thêm Danh Mục Mới
                </a>
            </div>

            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Hình Ảnh</th>
                                <th>Tên Danh Mục</th>
                                <th>Trạng Thái</th>
                                <th class="text-end pe-4">Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${categories}">
                                <tr>
                                    <td class="ps-4 fw-bold">#${c.categoryId}</td>
                                    <td>
                                        <img src="${c.images != null ? c.images : 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=100'}" 
                                             alt="${c.categoryName}" class="rounded-3" style="width: 50px; height: 50px; object-fit: cover;">
                                    </td>
                                    <td class="fw-semibold text-dark">${c.categoryName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.status == 1}">
                                                <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-3">Khóa</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end pe-4">
                                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${c.categoryId}" class="btn btn-sm btn-outline-warning me-1">
                                            <i class="fa-solid fa-pen-to-square me-1"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/category/delete?id=${c.categoryId}" 
                                           class="btn btn-sm btn-outline-danger" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                            <i class="fa-solid fa-trash me-1"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty categories}">
                                <tr>
                                    <td colspan="5" class="text-center py-4 text-muted">Chưa có danh mục nào trong cơ sở dữ liệu.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <c:if test="${totalPages > 1}">
                    <div class="card-footer bg-white py-3 border-0">
                        <nav>
                            <ul class="pagination justify-content-center mb-0">
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/category?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </nav>
                    </div>
                </c:if>
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
