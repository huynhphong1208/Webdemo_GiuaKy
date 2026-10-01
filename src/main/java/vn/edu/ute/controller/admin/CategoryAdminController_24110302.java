package vn.edu.ute.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.ute.entity.Category;
import vn.edu.ute.service.ICategoryService_24110302;
import vn.edu.ute.service.impl.CategoryServiceImpl_24110302;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/category", "/admin/category/add", "/admin/category/edit", "/admin/category/delete"})
public class CategoryAdminController_24110302 extends HttpServlet {

    private final ICategoryService_24110302 categoryService = new CategoryServiceImpl_24110302();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-form.jsp").forward(req, resp);
        } else if (uri.contains("/admin/category/edit")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                Long id = Long.parseLong(idStr);
                Category category = categoryService.findById(id);
                req.setAttribute("category", category);
            }
            req.getRequestDispatcher("/views/admin/category-form.jsp").forward(req, resp);
        } else if (uri.contains("/admin/category/delete")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                Long id = Long.parseLong(idStr);
                categoryService.delete(id);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        } else {
            int page = 1;
            int pageSize = 5;
            String pageStr = req.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }

            int totalItems = categoryService.count();
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);

            List<Category> categories = categoryService.findAll(page, pageSize);

            req.setAttribute("categories", categories);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);

            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("categoryId");
        String categoryName = req.getParameter("categoryName");
        String images = req.getParameter("images");
        String statusStr = req.getParameter("status");

        int status = (statusStr != null && !statusStr.isEmpty()) ? Integer.parseInt(statusStr) : 1;

        Category category = new Category();
        category.setCategoryName(categoryName);
        category.setImages(images);
        category.setStatus(status);

        if (idStr != null && !idStr.trim().isEmpty()) {
            category.setCategoryId(Long.parseLong(idStr));
            categoryService.update(category);
        } else {
            categoryService.insert(category);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }
}
