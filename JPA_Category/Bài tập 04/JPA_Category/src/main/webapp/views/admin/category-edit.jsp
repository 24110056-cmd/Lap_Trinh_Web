<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Cập nhật danh mục</title>
</head>
<body>
    <div class="card shadow-sm border-0 mx-auto" style="max-width: 550px; border-radius: 15px;">
        <div class="card-body p-4 p-sm-5">
            <h4 class="fw-bold text-center mb-4">
                <i class="bi bi-pencil-square text-primary me-2"></i>Cập Nhật Danh Mục
            </h4>

            <c:if test="${not empty alert}">
                <div class="alert alert-danger py-2 text-center small">${alert}</div>
            </c:if>

            <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="categoryid" value="${cate.categoryId}">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên danh mục:</label>
                    <input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" class="form-control" placeholder="Nhập tên danh mục" required minlength="3">
                    <div class="invalid-feedback">Tên danh mục không được để trống và phải có ít nhất 3 ký tự.</div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Link hình ảnh (hoặc tên file):</label>
                    <input type="text" id="images" name="images" value="${cate.images}" class="form-control" placeholder="https://... hoặc tên file">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold d-block">Ảnh hiện tại:</label>
                    <c:choose>
                        <c:when test="${not empty cate.images && cate.images.startsWith('https')}">
                            <c:url value="${cate.images}" var="imgUrl"/>
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                        </c:otherwise>
                    </c:choose>
                    <img src="${imgUrl}" height="80" width="100" style="object-fit: cover; border-radius: 8px; border: 1px solid #ddd;"/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Đổi hình ảnh mới (upload):</label>
                    <input type="file" id="images1" name="images1" class="form-control" accept="image/*">
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold d-block">Trạng thái:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}>
                        <label class="form-check-label" for="ston">Hoạt động</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}>
                        <label class="form-check-label" for="stoff">Khóa</label>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary flex-grow-1 fw-semibold">Cập nhật</button>
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
