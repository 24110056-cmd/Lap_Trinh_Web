package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.entity.User;

public class UserDao implements IUserDao {

	@Override
	public User findByUsername(String username) {
		EntityManager enma = JpaConfig.getEntityManager();
		try {
			String jpql = "SELECT u FROM User u WHERE u.username = :username";
			TypedQuery<User> query = enma.createQuery(jpql, User.class);
			query.setParameter("username", username);
			return query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		} finally {
			enma.close();
		}
	}

	@Override
	public void insert(User user) {
		EntityManager enma = JpaConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			enma.persist(user);
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
	public boolean checkExistUsername(String username) {
		return findByUsername(username) != null;
	}
}