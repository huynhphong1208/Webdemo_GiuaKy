package vn.edu.ute.service.impl;

import vn.edu.ute.dao.IProductDao_24110302;
import vn.edu.ute.dao.impl.ProductDaoImpl_24110302;
import vn.edu.ute.entity.Product;
import vn.edu.ute.service.IProductService_24110302;

import java.util.List;

public class ProductServiceImpl_24110302 implements IProductService_24110302 {

    private final IProductDao_24110302 productDao = new ProductDaoImpl_24110302();

    @Override
    public Product findById(Long id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {
        return productDao.findAll(page, pageSize);
    }

    @Override
    public int count() {
        return productDao.count();
    }

    @Override
    public List<Product> findBySellerId(Long sellerId) {
        return productDao.findBySellerId(sellerId);
    }

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(Long id) {
        productDao.delete(id);
    }

    @Override
    public List<Product> searchByName(String keyword) {
        return productDao.searchByName(keyword);
    }
}
