package vn.edu.ute.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.ute.entity.Category;
import vn.edu.ute.entity.Product;
import vn.edu.ute.entity.Seller;
import vn.edu.ute.service.ICategoryService_24110302;
import vn.edu.ute.service.IProductService_24110302;
import vn.edu.ute.service.ISellerService_24110302;
import vn.edu.ute.service.impl.CategoryServiceImpl_24110302;
import vn.edu.ute.service.impl.ProductServiceImpl_24110302;
import vn.edu.ute.service.impl.SellerServiceImpl_24110302;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/product", "/admin/product/add", "/admin/product/edit", "/admin/product/delete"})
public class ProductAdminController_24110302 extends HttpServlet {

    private final IProductService_24110302 productService = new ProductServiceImpl_24110302();
    private final ICategoryService_24110302 categoryService = new CategoryServiceImpl_24110302();
    private final ISellerService_24110302 sellerService = new SellerServiceImpl_24110302();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/admin/product/add")) {
            req.setAttribute("categories", categoryService.findAll());
            req.setAttribute("sellers", sellerService.findAll());
            req.getRequestDispatcher("/views/admin/product-form.jsp").forward(req, resp);
        } else if (uri.contains("/admin/product/edit")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                Long id = Long.parseLong(idStr);
                Product product = productService.findById(id);
                req.setAttribute("product", product);
            }
            req.setAttribute("categories", categoryService.findAll());
            req.setAttribute("sellers", sellerService.findAll());
            req.getRequestDispatcher("/views/admin/product-form.jsp").forward(req, resp);
        } else if (uri.contains("/admin/product/delete")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                Long id = Long.parseLong(idStr);
                productService.delete(id);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/product");
        } else {
            int page = 1;
            int pageSize = 5;
            String pageStr = req.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }

            int totalItems = productService.count();
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);

            List<Product> products = productService.findAll(page, pageSize);

            req.setAttribute("products", products);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);

            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("productId");
        String productName = req.getParameter("productName");
        String productCode = req.getParameter("productCode");
        String categoryIdStr = req.getParameter("categoryId");
        String sellerIdStr = req.getParameter("sellerId");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String amountStr = req.getParameter("amount");
        String stockStr = req.getParameter("stock");
        String images = req.getParameter("images");
        String statusStr = req.getParameter("status");

        Product product = new Product();
        if (idStr != null && !idStr.trim().isEmpty()) {
            product = productService.findById(Long.parseLong(idStr));
        }

        product.setProductName(productName);
        product.setProductCode(productCode);
        product.setDescription(description);
        product.setImages(images);

        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            Category cat = categoryService.findById(Long.parseLong(categoryIdStr));
            product.setCategory(cat);
        }

        if (sellerIdStr != null && !sellerIdStr.isEmpty()) {
            Seller seller = sellerService.findById(Long.parseLong(sellerIdStr));
            product.setSeller(seller);
        }

        if (priceStr != null && !priceStr.isEmpty()) {
            product.setPrice(new BigDecimal(priceStr));
        }

        if (amountStr != null && !amountStr.isEmpty()) {
            product.setAmount(Integer.parseInt(amountStr));
        }

        if (stockStr != null && !stockStr.isEmpty()) {
            product.setStock(Integer.parseInt(stockStr));
        }

        if (statusStr != null && !statusStr.isEmpty()) {
            product.setStatus(Integer.parseInt(statusStr));
        } else {
            product.setStatus(1);
        }

        if (idStr != null && !idStr.trim().isEmpty()) {
            productService.update(product);
        } else {
            product.setCreateDate(new Date());
            productService.insert(product);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }
}
