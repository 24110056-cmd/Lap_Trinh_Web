package vn.iotstar.services;

import vn.iotstar.entity.User;

public interface IUserService {
	User login(String username, String password);
	boolean register(String username, String password, String fullname, String email);
	boolean checkExistUsername(String username);
}