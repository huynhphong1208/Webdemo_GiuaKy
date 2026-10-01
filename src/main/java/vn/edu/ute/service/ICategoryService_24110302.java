package vn.edu.ute.service;

import vn.edu.ute.entity.Category;

import java.util.List;

public interface ICategoryService_24110302 {
    Category findById(Long id);
    List<Category> findAll();
    List<Category> findAll(int page, int pageSize);
    int count();
    void insert(Category category);
    void update(Category category);
    void delete(Long id);
    List<Category> searchByName(String keyword);
}
