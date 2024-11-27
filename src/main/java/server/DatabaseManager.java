package server;

import jakarta.annotation.PreDestroy;
import jakarta.ejb.Stateless;
import jakarta.persistence.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import server.models.Point;

import java.io.Serializable;
import java.util.List;

@Stateless
public class DatabaseManager implements Serializable {

    private final SessionFactory sessionFactory;

    public DatabaseManager() {
        final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
                .configure()
                .build();
        try {
            sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
        } catch (Exception e) {
            StandardServiceRegistryBuilder.destroy(registry);
            e.printStackTrace();
            throw e;
        }
    }

    public void addPoint(Point point) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.persist(point);
            session.getTransaction().commit();
        }
    }

    public List<Point> getPoints() {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            TypedQuery<Point> query = session.createQuery("from Point", Point.class);
            return query.getResultList();
        }
    }

    public void clearTable() {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.createQuery("delete from Point").executeUpdate();
            session.getTransaction().commit();
        }
    }

    @PreDestroy
    public void close() {
        sessionFactory.close();
    }
}
