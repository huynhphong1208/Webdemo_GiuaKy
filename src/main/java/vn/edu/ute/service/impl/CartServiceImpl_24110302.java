package vn.edu.ute.service.impl;

import vn.edu.ute.dao.ICartDao_24110302;
import vn.edu.ute.dao.ICartItemDao_24110302;
import vn.edu.ute.dao.IProductDao_24110302;
import vn.edu.ute.dao.IUserDao_24110302;
import vn.edu.ute.dao.impl.CartDaoImpl_24110302;
import vn.edu.ute.dao.impl.CartItemDaoImpl_24110302;
import vn.edu.ute.dao.impl.ProductDaoImpl_24110302;
import vn.edu.ute.dao.impl.UserDaoImpl_24110302;
import vn.edu.ute.entity.Cart;
import vn.edu.ute.entity.CartItem;
import vn.edu.ute.entity.Product;
import vn.edu.ute.entity.User;
import vn.edu.ute.service.ICartService_24110302;

import java.util.Collections;
import java.util.Date;
import java.util.List;

public class CartServiceImpl_24110302 implements ICartService_24110302 {

    private final ICartDao_24110302 cartDao = new CartDaoImpl_24110302();
    private final ICartItemDao_24110302 cartItemDao = new CartItemDaoImpl_24110302();
    private final IProductDao_24110302 productDao = new ProductDaoImpl_24110302();
    private final IUserDao_24110302 userDao = new UserDaoImpl_24110302();

    @Override
    public Cart getOrCreateActiveCart(Long userId) {
        Cart cart = cartDao.findByUserIdAndStatus(userId, 0); // status 0: active cart
        if (cart == null) {
            User user = userDao.findById(userId);
            if (user != null) {
                cart = new Cart();
                cart.setUser(user);
                cart.setBuyDate(new Date());
                cart.setStatus(0);
                cartDao.insert(cart);
            }
        }
        return cart;
    }

    @Override
    public List<CartItem> getCartItems(Long userId) {
        Cart cart = cartDao.findByUserIdAndStatus(userId, 0);
        if (cart != null) {
            return cartItemDao.findByCartId(cart.getCartId());
        }
        return Collections.emptyList();
    }

    @Override
    public int getCartTotalCount(Long userId) {
        List<CartItem> items = getCartItems(userId);
        int total = 0;
        for (CartItem item : items) {
            total += (item.getQuantity() != null ? item.getQuantity() : 0);
        }
        return total;
    }

    @Override
    public String addToCart(Long userId, Long productId, int quantity) {
        if (quantity <= 0) return "Số lượng thêm vào phải lớn hơn 0!";

        Product product = productDao.findById(productId);
        if (product == null) return "Sản phẩm không tồn tại!";

        int availableStock = (product.getAmount() != null) ? product.getAmount() : 0;
        if (availableStock <= 0) return "Sản phẩm đã hết hàng!";

        Cart cart = getOrCreateActiveCart(userId);
        if (cart == null) return "Không thể tạo giỏ hàng cho người dùng!";

        CartItem existingItem = cartItemDao.findByCartIdAndProductId(cart.getCartId(), productId);

        int newTotalQuantity = quantity;
        if (existingItem != null) {
            newTotalQuantity += (existingItem.getQuantity() != null ? existingItem.getQuantity() : 0);
        }

        if (newTotalQuantity > availableStock) {
            return "Rất tiếc! Số lượng yêu cầu (" + newTotalQuantity + ") vượt quá số lượng kho còn lại (" + availableStock + ")!";
        }

        if (existingItem != null) {
            existingItem.setQuantity(newTotalQuantity);
            existingItem.setUnitPrice(product.getPrice());
            cartItemDao.update(existingItem);
        } else {
            CartItem newItem = new CartItem();
            newItem.setCart(cart);
            newItem.setProduct(product);
            newItem.setQuantity(quantity);
            newItem.setUnitPrice(product.getPrice());
            cartItemDao.insert(newItem);
        }

        return "SUCCESS";
    }

    @Override
    public String updateQuantity(Long cartItemId, int newQuantity) {
        CartItem item = cartItemDao.findById(cartItemId);
        if (item == null) return "Mục giỏ hàng không tồn tại!";

        if (newQuantity <= 0) {
            cartItemDao.delete(cartItemId);
            return "SUCCESS_DELETED";
        }

        Product product = item.getProduct();
        int availableStock = (product != null && product.getAmount() != null) ? product.getAmount() : 0;

        if (newQuantity > availableStock) {
            return "Số lượng điều chỉnh (" + newQuantity + ") vượt quá số lượng kho khả dụng (" + availableStock + ")!";
        }

        item.setQuantity(newQuantity);
        cartItemDao.update(item);
        return "SUCCESS";
    }

    @Override
    public void removeCartItem(Long cartItemId) {
        cartItemDao.delete(cartItemId);
    }

    @Override
    public String checkoutCOD(Long userId) {
        Cart cart = cartDao.findByUserIdAndStatus(userId, 0);
        if (cart == null) return "Giỏ hàng trống!";

        List<CartItem> items = cartItemDao.findByCartId(cart.getCartId());
        if (items == null || items.isEmpty()) return "Giỏ hàng của bạn đang không có sản phẩm nào!";

        // Validate stock for all items before deduction
        for (CartItem item : items) {
            Product p = item.getProduct();
            int currentStock = (p != null && p.getAmount() != null) ? p.getAmount() : 0;
            if (item.getQuantity() > currentStock) {
                return "Sản phẩm '" + (p != null ? p.getProductName() : "") + "' không đủ số lượng trong kho (Còn: " + currentStock + ")!";
            }
        }

        // Deduct product stock & update status
        for (CartItem item : items) {
            Product p = item.getProduct();
            int currentAmount = (p.getAmount() != null) ? p.getAmount() : 0;
            int currentStock = (p.getStock() != null) ? p.getStock() : 0;

            p.setAmount(currentAmount - item.getQuantity());
            p.setStock(currentStock + item.getQuantity()); // Add to sold stock count
            productDao.update(p);
        }

        // Complete Cart
        cart.setStatus(1); // 1 = Completed / Paid COD
        cart.setBuyDate(new Date());
        cartDao.update(cart);

        return "SUCCESS";
    }
}
