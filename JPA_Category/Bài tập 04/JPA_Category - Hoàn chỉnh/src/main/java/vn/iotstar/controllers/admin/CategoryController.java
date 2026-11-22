package vn.iotstar.controllers.admin;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.utils.Constant;
import vn.iotstar.utils.ValidationUtils;

@MultipartConfig()
@WebServlet(urlPatterns = { "/admin/categories", "/admin/category/add", "/admin/category/insert",
		"/admin/category/edit", "/admin/category/update", "/admin/category/delete" })
public class CategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public ICategoryService cateService = new CategoryServiceImpl();
	private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList("jpg", "jpeg", "png", "gif", "webp");

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getRequestURI();
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		if (url.contains("/admin/categories")) {
			List<Category> list = cateService.findAll();
			req.setAttribute("listcate", list);
			req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
		} else if (url.contains("/admin/category/add")) {
			req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
		} else if (url.contains("/admin/category/edit")) {
			int id = Integer.parseInt(req.getParameter("id"));
			Category category = cateService.findById(id);
			req.setAttribute("cate", category);
			req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
		} else if (url.contains("/admin/category/delete")) {
			int id = Integer.parseInt(req.getParameter("id"));
			try {
				cateService.delete(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			resp.sendRedirect(req.getContextPath() + "/admin/categories");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getRequestURI();
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		if (url.contains("/admin/category/insert")) {
			String categoryname = req.getParameter("categoryname");
			String statusParam = req.getParameter("status");
			int status = (statusParam != null && !statusParam.isEmpty()) ? Integer.parseInt(statusParam) : 1;
			String images = req.getParameter("images");

			Category category = new Category();
			category.setCategoryname(categoryname != null ? categoryname.trim() : "");
			category.setStatus(status);

			// 1. Validate Entity Category
			String errorMsg = ValidationUtils.validate(category);
			if (errorMsg != null) {
				req.setAttribute("alert", errorMsg);
				req.setAttribute("cate", category);
				req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
				return;
			}

			String fname = "";
			String uploadPath = Constant.DIR;
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists())
				uploadDir.mkdirs();

			try {
				Part part = req.getPart("images1");
				if (part != null && part.getSize() > 0) {
					String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
					int index = filename.lastIndexOf(".");
					String ext = (index > 0) ? filename.substring(index + 1).toLowerCase() : "";

					// 2. Validate định dạng file ảnh
					if (!ALLOWED_EXTENSIONS.contains(ext)) {
						req.setAttribute("alert", "Chỉ chấp nhận file ảnh định dạng: jpg, jpeg, png, gif, webp!");
						req.setAttribute("cate", category);
						req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
						return;
					}

					fname = System.currentTimeMillis() + "." + ext;
					part.write(uploadPath + File.separator + fname);
					category.setImages(fname);
				} else if (images != null && !images.trim().isEmpty()) {
					category.setImages(images.trim());
				} else {
					category.setImages("avatar.png");
				}
			} catch (FileNotFoundException fne) {
				fne.printStackTrace();
			}

			cateService.insert(category);
			resp.sendRedirect(req.getContextPath() + "/admin/categories");

		} else if (url.contains("/admin/category/update")) {
			int categoryid = Integer.parseInt(req.getParameter("categoryid"));
			String categoryname = req.getParameter("categoryname");
			String statusParam = req.getParameter("status");
			int status = (statusParam != null && !statusParam.isEmpty()) ? Integer.parseInt(statusParam) : 1;
			String images = req.getParameter("images");

			Category category = cateService.findById(categoryid);
			String fileold = category.getImages();
			category.setCategoryname(categoryname != null ? categoryname.trim() : "");
			category.setStatus(status);

			// 1. Validate Entity Category khi cập nhật
			String errorMsg = ValidationUtils.validate(category);
			if (errorMsg != null) {
				category.setImages(fileold); // Giữ lại ảnh cũ để hiển thị lại trên form
				req.setAttribute("alert", errorMsg);
				req.setAttribute("cate", category);
				req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
				return;
			}

			String fname = "";
			String uploadPath = Constant.DIR;
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists())
				uploadDir.mkdirs();

			try {
				Part part = req.getPart("images1");
				if (part != null && part.getSize() > 0) {
					String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
					int index = filename.lastIndexOf(".");
					String ext = (index > 0) ? filename.substring(index + 1).toLowerCase() : "";

					// 2. Validate định dạng file ảnh
					if (!ALLOWED_EXTENSIONS.contains(ext)) {
						category.setImages(fileold);
						req.setAttribute("alert", "Chỉ chấp nhận file ảnh định dạng: jpg, jpeg, png, gif, webp!");
						req.setAttribute("cate", category);
						req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
						return;
					}

					if (fileold != null && !fileold.startsWith("https") && !fileold.equals("avatar.png")) {
						deleteFile(uploadPath + File.separator + fileold);
					}
					fname = System.currentTimeMillis() + "." + ext;
					part.write(uploadPath + File.separator + fname);
					category.setImages(fname);
				} else if (images != null && !images.trim().isEmpty()) {
					category.setImages(images.trim());
				} else {
					category.setImages(fileold);
				}
			} catch (FileNotFoundException fne) {
				fne.printStackTrace();
			}

			cateService.update(category);
			resp.sendRedirect(req.getContextPath() + "/admin/categories");
		}
	}

	public static void deleteFile(String filePath) {
		try {
			Path path = Paths.get(filePath);
			Files.deleteIfExists(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
