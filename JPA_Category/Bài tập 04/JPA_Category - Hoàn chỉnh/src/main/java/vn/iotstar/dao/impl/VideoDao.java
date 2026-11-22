package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.IVideoDao;
import vn.iotstar.entity.Video;
import java.util.List;

public class VideoDao implements IVideoDao {

    @Override
    public void insert(Video video) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(video);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Video video) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(video);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(String videoId) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Video video = enma.find(Video.class, videoId);
            if (video != null) {
                enma.remove(video);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Video findById(String videoId) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            return enma.find(Video.class, videoId);
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Video> findTop10Newest() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.active = true ORDER BY v.videoId DESC";
            TypedQuery<Video> query = enma.createQuery(jpql, Video.class);
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Video> findAllPaginated(int page, int pageSize) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v ORDER BY v.videoId DESC";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countAll() {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(v) FROM Video v";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video> findByUserIdPaginated(int userId, int page, int pageSize) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.user.id = :userId ORDER BY v.videoId DESC";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setParameter("userId", userId);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countByUserId(int userId) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(v) FROM Video v WHERE v.user.id = :userId";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
