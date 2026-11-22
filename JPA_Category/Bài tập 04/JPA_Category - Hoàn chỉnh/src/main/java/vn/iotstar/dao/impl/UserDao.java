
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
            String jpql = "SELECT u FROM User u WHERE LOWER(u.username) = LOWER(:username)";

            TypedQuery<User> query =
                    enma.createQuery(jpql, User.class);

            query.setParameter("username", username.trim());

            return query.getSingleResult();

        } catch (NoResultException e) {
            return null;

        } finally {
            enma.close();
        }
    }

    @Override
    public User findByEmail(String email) {

        EntityManager enma = JpaConfig.getEntityManager();

        try {
            String jpql = "SELECT u FROM User u WHERE LOWER(u.email) = LOWER(:email)";

            TypedQuery<User> query =
                    enma.createQuery(jpql, User.class);

            query.setParameter("email", email.trim());

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

            if (trans.isActive()) {
                trans.rollback();
            }

            throw e;

        } finally {
            enma.close();
        }
    }

    @Override
    public void update(User user) {

        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        try {
            trans.begin();

            // Lấy tài khoản hiện tại từ database
            User existingUser = enma.find(User.class, user.getId());

            if (existingUser == null) {
                throw new IllegalArgumentException(
                    "Không tìm thấy tài khoản cần cập nhật!"
                );
            }

            // Cập nhật thông tin cá nhân
            existingUser.setUsername(user.getUsername());
            existingUser.setFullname(user.getFullname());
            existingUser.setEmail(user.getEmail());
            existingUser.setPhone(user.getPhone());
            existingUser.setImages(user.getImages());
            existingUser.setRoleid(user.getRoleid());
            existingUser.setEnabled(user.isEnabled());
            existingUser.setCode(user.getCode());

            // Giữ mật khẩu cũ nếu không có mật khẩu hợp lệ
            if (user.getPassword() != null
                    && user.getPassword().length() >= 6) {

                existingUser.setPassword(user.getPassword());
            }

            trans.commit();

        } catch (Exception e) {

            e.printStackTrace();

            if (trans.isActive()) {
                trans.rollback();
            }

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
