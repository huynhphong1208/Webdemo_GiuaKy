package vn.edu.ute.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.edu.ute.dao.ISellerDao_24110302;
import vn.edu.ute.entity.Seller;
import vn.edu.ute.util.JPAUtil;

import java.util.List;

public class SellerDaoImpl_24110302 implements ISellerDao_24110302 {

    @Override
    public Seller findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Seller.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Seller> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT s FROM Seller s", Seller.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Seller entity) {
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
    public void update(Seller entity) {
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
            Seller seller = em.find(Seller.class, id);
            if (seller != null) em.remove(seller);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
