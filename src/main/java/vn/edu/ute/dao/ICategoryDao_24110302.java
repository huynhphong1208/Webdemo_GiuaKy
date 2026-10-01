package vn.edu.ute.dao;

import vn.edu.ute.entity.Category;

import java.util.List;

public interface ICategoryDao_24110302 extends IGenericDao_24110302<Category, Long> {
    List<Category> findAll(int page, int pageSize);
    int count();
    List<Category> searchByName(String keyword);
}
