package vn.iotstar.services.impl;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;

public class UserServiceImpl implements IUserService {
	private IUserDao userDao = new UserDao();

	@Override
	public User login(String username, String password) {
		User user = userDao.findByUsername(username);
		if (user != null && user.getPassword().equals(password)) {
			return user;
		}
		return null;
	}

	@Override
	public boolean register(String username, String password, String fullname, String email) {
		if (userDao.checkExistUsername(username)) {
			return false;
		}
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setFullname(fullname);
		user.setEmail(email);
		user.setRoleid(1); // Mặc định cấp quyền Admin để test luôn trang quản trị
		userDao.insert(user);
		return true;
	}

	@Override
	public boolean checkExistUsername(String username) {
		return userDao.checkExistUsername(username);
	}
}