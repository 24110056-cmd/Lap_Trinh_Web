package vn.iotstar.services;

import vn.iotstar.entity.User;

public interface IUserService {
	// Đăng nhập (kiểm tra username/password đã mã hóa BCrypt và tài khoản đã được enabled)
	User login(String username, String password);
	
	// Đăng ký tài khoản mới (đồng thời sinh mã OTP và gửi qua email)
	boolean register(String username, String password, String fullname, String email);
	
	// Xác thực mã OTP để kích hoạt tài khoản
	boolean verifyAccount(String email, String otp);
	
	// Gửi mã OTP xác nhận quên mật khẩu qua email
	boolean forgotPassword(String email);
	
	// Đặt lại mật khẩu mới sau khi xác thực OTP quên mật khẩu
	boolean resetPassword(String email, String otp, String newPassword);
	
	// Kiểm tra tên đăng nhập đã tồn tại chưa
	boolean checkExistUsername(String username);
	
	// Kiểm tra email đã tồn tại chưa
	boolean checkExistEmail(String email);
}