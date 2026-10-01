package vn.edu.ute.service;

import vn.edu.ute.entity.Product;

import java.util.List;

public interface IProductService_24110302 {
    Product findById(Long id);
    List<Product> findAll();
    List<Product> findAll(int page, int pageSize);
    int count();
    List<Product> findBySellerId(Long sellerId);
    void insert(Product product);
    void update(Product product);
    void delete(Long id);
    List<Product> searchByName(String keyword);
}
