package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.ute.entity.Product;
import vn.edu.ute.entity.Seller;
import vn.edu.ute.service.IProductService_24110302;
import vn.edu.ute.service.ISellerService_24110302;
import vn.edu.ute.service.impl.ProductServiceImpl_24110302;
import vn.edu.ute.service.impl.SellerServiceImpl_24110302;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/products", "/product-detail"})
public class ProductWebController_24110302 extends HttpServlet {

    private final IProductService_24110302 productService = new ProductServiceImpl_24110302();
    private final ISellerService_24110302 sellerService = new SellerServiceImpl_24110302();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/product-detail")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                Long id = Long.parseLong(idStr);
                Product product = productService.findById(id);
                req.setAttribute("product", product);
            }
            req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
        } else {
            List<Seller> sellers = sellerService.findAll();
            Map<Seller, List<Product>> productsBySeller = new LinkedHashMap<>();

            for (Seller seller : sellers) {
                List<Product> products = productService.findBySellerId(seller.getSellerId());
                productsBySeller.put(seller, products);
            }

            req.setAttribute("productsBySeller", productsBySeller);
            req.getRequestDispatcher("/views/web/product-list.jsp").forward(req, resp);
        }
    }
}
