<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Thêm danh mục</title>
</head>
<body>
    <div class="card shadow-sm border-0 mx-auto" style="max-width: 550px; border-radius: 15px;">
        <div class="card-body p-4 p-sm-5">
            <h4 class="fw-bold text-center mb-4">
                <i class="bi bi-folder-plus text-success me-2"></i>Thêm Danh Mục Mới
            </h4>

            <c:if test="${not empty alert}">
                <div class="alert alert-danger py-2 text-center small">${alert}</div>
            </c:if>

            <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên danh mục:</label>
                    <input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" class="form-control" placeholder="Nhập tên danh mục" required minlength="3">
                    <div class="invalid-feedback">Tên danh mục không được để trống và phải có ít nhất 3 ký tự.</div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Link hình ảnh (hoặc để trống nếu upload):</label>
                    <input type="url" id="images" name="images" class="form-control" placeholder="https://...">
                    <div class="invalid-feedback">Vui lòng nhập đúng định dạng đường dẫn URL (bắt đầu bằng http:// hoặc https://).</div>
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
    </div>

    <script>
    (() => {
      'use strict'
      const forms = document.querySelectorAll('.needs-validation')
      Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
          if (!form.checkValidity()) {
            event.preventDefault()
            event.stopPropagation()
          }
          form.classList.add('was-validated')
        }, false)
      })
    })()
    </script>
</body>
</html>
