package vn.edu.ute.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {
    private static EntityManagerFactory factory;

    public static synchronized EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            try {
                factory = Persistence.createEntityManagerFactory("GiuaKyPU");
            } catch (Exception ex) {
                System.err.println("EntityManagerFactory creation failed: " + ex.getMessage());
                ex.printStackTrace();
                throw new RuntimeException("Could not create EntityManagerFactory", ex);
            }
        }
        return factory.createEntityManager();
    }

    public static synchronized void close() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}
