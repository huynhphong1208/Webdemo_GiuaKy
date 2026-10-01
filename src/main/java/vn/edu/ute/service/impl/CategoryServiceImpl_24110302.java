package vn.edu.ute.service.impl;

import vn.edu.ute.dao.ICategoryDao_24110302;
import vn.edu.ute.dao.impl.CategoryDaoImpl_24110302;
import vn.edu.ute.entity.Category;
import vn.edu.ute.service.ICategoryService_24110302;

import java.util.List;

public class CategoryServiceImpl_24110302 implements ICategoryService_24110302 {

    private final ICategoryDao_24110302 categoryDao = new CategoryDaoImpl_24110302();

    @Override
    public Category findById(Long id) {
        return categoryDao.findById(id);
    }

    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category> findAll(int page, int pageSize) {
        return categoryDao.findAll(page, pageSize);
    }

    @Override
    public int count() {
        return categoryDao.count();
    }

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void update(Category category) {
        categoryDao.update(category);
    }

    @Override
    public void delete(Long id) {
        categoryDao.delete(id);
    }

    @Override
    public List<Category> searchByName(String keyword) {
        return categoryDao.searchByName(keyword);
    }
}
