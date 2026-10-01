package vn.edu.ute.dao;

import java.util.List;

public interface IGenericDao_24110302<T, ID> {
    T findById(ID id);
    List<T> findAll();
    void insert(T entity);
    void update(T entity);
    void delete(ID id);
}
