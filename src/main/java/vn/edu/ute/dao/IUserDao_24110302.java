package vn.edu.ute.dao;

import vn.edu.ute.entity.User;

public interface IUserDao_24110302 extends IGenericDao_24110302<User, Long> {
    User findByUsername(String username);
    User findByEmail(String email);
}
