package vn.edu.ute.dao;

import vn.edu.ute.entity.UserRole;

public interface IUserRoleDao_24110302 extends IGenericDao_24110302<UserRole, Long> {
    UserRole findByName(String roleName);
}
