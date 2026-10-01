package vn.edu.ute.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import vn.edu.ute.dao.ICartDao_24110302;
import vn.edu.ute.entity.Cart;
import vn.edu.ute.util.JPAUtil;

import java.util.List;

public class CartDaoImpl_24110302 implements ICartDao_24110302 {

    @Override
    public Cart findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Cart.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Cart> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Cart c", Cart.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Cart findByUserIdAndStatus(Long userId, Integer status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Cart> query = em.createQuery(
                    "SELECT c FROM Cart c WHERE c.user.userId = :userId AND c.status = :status", Cart.class);
            query.setParameter("userId", userId);
            query.setParameter("status", status);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Cart entity) {
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
    public void update(Cart entity) {
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
            Cart cart = em.find(Cart.class, id);
            if (cart != null) {
                em.remove(cart);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
