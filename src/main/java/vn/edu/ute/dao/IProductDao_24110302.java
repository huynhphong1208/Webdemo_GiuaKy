package vn.edu.ute.dao;

import vn.edu.ute.entity.Product;

import java.util.List;

public interface IProductDao_24110302 extends IGenericDao_24110302<Product, Long> {
    List<Product> findAll(int page, int pageSize);
    int count();
    List<Product> findBySellerId(Long sellerId);
    List<Product> searchByName(String keyword);
}
