package vn.edu.ute.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import vn.edu.ute.dao.ICartItemDao_24110302;
import vn.edu.ute.entity.CartItem;
import vn.edu.ute.util.JPAUtil;

import java.util.List;

public class CartItemDaoImpl_24110302 implements ICartItemDao_24110302 {

    @Override
    public CartItem findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(CartItem.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<CartItem> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT ci FROM CartItem ci", CartItem.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<CartItem> findByCartId(Long cartId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<CartItem> query = em.createQuery(
                    "SELECT ci FROM CartItem ci LEFT JOIN FETCH ci.product WHERE ci.cart.cartId = :cartId", CartItem.class);
            query.setParameter("cartId", cartId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public CartItem findByCartIdAndProductId(Long cartId, Long productId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<CartItem> query = em.createQuery(
                    "SELECT ci FROM CartItem ci WHERE ci.cart.cartId = :cartId AND ci.product.productId = :productId", CartItem.class);
            query.setParameter("cartId", cartId);
            query.setParameter("productId", productId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public void deleteByCartId(Long cartId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.createQuery("DELETE FROM CartItem ci WHERE ci.cart.cartId = :cartId")
                    .setParameter("cartId", cartId)
                    .executeUpdate();
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(CartItem entity) {
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
    public void update(CartItem entity) {
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
            CartItem ci = em.find(CartItem.class, id);
            if (ci != null) {
                em.remove(ci);
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
