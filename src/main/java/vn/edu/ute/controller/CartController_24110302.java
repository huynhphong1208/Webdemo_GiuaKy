package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.ute.entity.CartItem;
import vn.edu.ute.entity.User;
import vn.edu.ute.service.ICartService_24110302;
import vn.edu.ute.service.impl.CartServiceImpl_24110302;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(urlPatterns = {"/cart", "/cart/add", "/cart/update", "/cart/delete"})
public class CartController_24110302 extends HttpServlet {

    private final ICartService_24110302 cartService = new CartServiceImpl_24110302();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String uri = req.getRequestURI();

        if (uri.contains("/cart/delete")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                cartService.removeCartItem(Long.parseLong(idStr));
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else {
            List<CartItem> cartItems = cartService.getCartItems(user.getUserId());
            BigDecimal grandTotal = BigDecimal.ZERO;
            int totalItemCount = 0;

            for (CartItem item : cartItems) {
                if (item.getUnitPrice() != null && item.getQuantity() != null) {
                    BigDecimal totalItem = item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
                    grandTotal = grandTotal.add(totalItem);
                    totalItemCount += item.getQuantity();
                }
            }

            req.setAttribute("cartItems", cartItems);
            req.setAttribute("grandTotal", grandTotal);
            req.setAttribute("totalItemCount", totalItemCount);
            req.getRequestDispatcher("/views/web/cart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String uri = req.getRequestURI();

        if (uri.contains("/cart/add")) {
            String productIdStr = req.getParameter("productId");
            String quantityStr = req.getParameter("quantity");

            Long productId = Long.parseLong(productIdStr);
            int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;

            String result = cartService.addToCart(user.getUserId(), productId, quantity);

            if ("SUCCESS".equals(result)) {
                req.getSession().setAttribute("msgSuccess", "Đã thêm sản phẩm vào giỏ hàng thành công!");
                resp.sendRedirect(req.getContextPath() + "/cart");
            } else {
                req.getSession().setAttribute("msgError", result);
                resp.sendRedirect(req.getContextPath() + "/product-detail?id=" + productId);
            }
        } else if (uri.contains("/cart/update")) {
            String cartItemIdStr = req.getParameter("cartItemId");
            String quantityStr = req.getParameter("quantity");

            Long cartItemId = Long.parseLong(cartItemIdStr);
            int quantity = Integer.parseInt(quantityStr);

            String result = cartService.updateQuantity(cartItemId, quantity);

            if (!"SUCCESS".equals(result) && !"SUCCESS_DELETED".equals(result)) {
                req.getSession().setAttribute("msgError", result);
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}
