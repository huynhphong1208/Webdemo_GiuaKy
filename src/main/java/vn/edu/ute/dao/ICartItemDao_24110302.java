package vn.edu.ute.dao;

import vn.edu.ute.entity.CartItem;

import java.util.List;

public interface ICartItemDao_24110302 extends IGenericDao_24110302<CartItem, Long> {
    List<CartItem> findByCartId(Long cartId);
    CartItem findByCartIdAndProductId(Long cartId, Long productId);
    void deleteByCartId(Long cartId);
}
