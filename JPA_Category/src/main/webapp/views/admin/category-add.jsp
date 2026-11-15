<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .form-card { width: 100%; max-width: 480px; background: #fff; border-radius: 18px; box-shadow: 0 20px 25px rgba(0,0,0,0.3); }
    </style>
</head>
<body>
    <div class="form-card p-4 p-sm-5">
        <h4 class="fw-bold text-center mb-4"><i class="bi bi-folder-plus text-success me-2"></i>Thêm Danh Mục Mới</h4>
        
        <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tên danh mục:</label>
                <input type="text" id="categoryname" name="categoryname" class="form-control" placeholder="Nhập tên danh mục" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Link hình ảnh (hoặc để trống nếu upload):</label>
                <input type="text" id="images" name="images" class="form-control" placeholder="https://...">
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Upload hình ảnh từ máy:</label>
                <input type="file" id="images1" name="images1" class="form-control" accept="image/*">
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold d-block">Trạng thái:</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="ston" name="status" value="1" checked>
                    <label class="form-check-label" for="ston">Hoạt động</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="stoff" name="status" value="0">
                    <label class="form-check-label" for="stoff">Khóa</label>
                </div>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success flex-grow-1 fw-semibold">Lưu lại</button>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-light border px-4">Quay lại</a>
            </div>
        </form>
    </div>
</body>
</html>