package vn.edu.ute.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import vn.edu.ute.dao.IUserRoleDao_24110302;
import vn.edu.ute.entity.UserRole;
import vn.edu.ute.util.JPAUtil;

import java.util.List;

public class UserRoleDaoImpl_24110302 implements IUserRoleDao_24110302 {

    @Override
    public UserRole findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(UserRole.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<UserRole> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT r FROM UserRole r", UserRole.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(UserRole entity) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(entity);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(UserRole entity) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(entity);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            UserRole role = em.find(UserRole.class, id);
            if (role != null) em.remove(role);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public UserRole findByName(String roleName) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<UserRole> query = em.createQuery("SELECT r FROM UserRole r WHERE r.roleName = :roleName", UserRole.class);
            query.setParameter("roleName", roleName);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}
