package vn.edu.ute.dao;

import vn.edu.ute.entity.Cart;

public interface ICartDao_24110302 extends IGenericDao_24110302<Cart, Long> {
    Cart findByUserIdAndStatus(Long userId, Integer status);
}
