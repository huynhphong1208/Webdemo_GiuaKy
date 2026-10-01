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

@WebServlet(urlPatterns = {"/checkout", "/checkout/process"})
public class CheckoutController_24110302 extends HttpServlet {

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

        if (uri.contains("/checkout/success")) {
            req.getRequestDispatcher("/views/web/checkout-success.jsp").forward(req, resp);
            return;
        }

        List<CartItem> cartItems = cartService.getCartItems(user.getUserId());
        if (cartItems.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

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
        req.getRequestDispatcher("/views/web/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String result = cartService.checkoutCOD(user.getUserId());

        if ("SUCCESS".equals(result)) {
            req.getRequestDispatcher("/views/web/checkout-success.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", result);
            doGet(req, resp);
        }
    }
}
