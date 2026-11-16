package vn.iotstar.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = { "/login", "/register", "/logout" })
public class AuthController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IUserService userService = new UserServiceImpl();

	@Override
	public void init() throws ServletException {
		// Tự động tạo sẵn tài khoản mặc định admin / 123 nếu chưa có
		if (!userService.checkExistUsername("admin")) {
			userService.register("admin", "123", "Quản trị viên", "admin@gmail.com");
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getRequestURI();
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		if (url.contains("/login")) {
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
		} else if (url.contains("/register")) {
			req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
		} else if (url.contains("/logout")) {
			HttpSession session = req.getSession(false);
			if (session != null) {
				session.invalidate();
			}
			resp.sendRedirect(req.getContextPath() + "/login");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getRequestURI();
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		if (url.contains("/login")) {
			String username = req.getParameter("username");
			String password = req.getParameter("password");

			User user = userService.login(username, password);
			if (user != null) {
				HttpSession session = req.getSession();
				session.setAttribute("account", user);
				resp.sendRedirect(req.getContextPath() + "/admin/categories");
			} else {
				req.setAttribute("alert", "Tài khoản hoặc mật khẩu không chính xác!");
				req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
			}
		} else if (url.contains("/register")) {
			String username = req.getParameter("username");
			String password = req.getParameter("password");
			String confirmPassword = req.getParameter("confirmPassword");
			String fullname = req.getParameter("fullname");
			String email = req.getParameter("email");

			if (!password.equals(confirmPassword)) {
				req.setAttribute("alert", "Mật khẩu nhập lại không khớp!");
				req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
				return;
			}

			boolean isSuccess = userService.register(username, password, fullname, email);
			if (isSuccess) {
				req.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
				req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
			} else {
				req.setAttribute("alert", "Tên đăng nhập đã tồn tại!");
				req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
			}
		}
	}
}