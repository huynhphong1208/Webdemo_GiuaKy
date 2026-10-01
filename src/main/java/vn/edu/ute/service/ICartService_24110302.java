package vn.edu.ute.service;

import vn.edu.ute.entity.Cart;
import vn.edu.ute.entity.CartItem;

import java.util.List;

public interface ICartService_24110302 {
    Cart getOrCreateActiveCart(Long userId);
    List<CartItem> getCartItems(Long userId);
    int getCartTotalCount(Long userId);
    
    // Add to cart with stock validation
    String addToCart(Long userId, Long productId, int quantity);
    
    // Update quantity with stock validation
    String updateQuantity(Long cartItemId, int newQuantity);
    
    // Delete item
    void removeCartItem(Long cartItemId);
    
    // Checkout COD
    String checkoutCOD(Long userId);
}
