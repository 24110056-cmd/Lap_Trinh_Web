<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Cập nhật danh mục</title>
    <style>
        .cate-edit-card {
            max-width: 560px;
            border-radius: 18px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            background-color: #ffffff;
        }
        .cate-edit-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background-color: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
        }
        .cate-edit-card .form-control {
            border-color: #e2e8f0;
            border-radius: 10px;
            padding: 0.58rem 0.8rem;
            font-size: 0.94rem;
        }
        .cate-edit-card .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.14);
        }
        .current-img-box {
            background-color: #f8fafc;
            border: 1px dashed #cbd5e1;
            border-radius: 12px;
            padding: 0.75rem 1rem;
        }
        .current-img-preview {
            width: 104px;
            height: 76px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            background-color: #ffffff;
        }
        .status-pill-group .form-check {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 0.45rem 0.9rem 0.45rem 2.2rem;
            margin-right: 0.6rem;
        }
        .btn-update-cate {
            border-radius: 10px;
            padding: 0.62rem 1rem;
        }
        .btn-back-cate {
            border-radius: 10px;
            padding: 0.62rem 1.2rem;
        }
    </style>
</head>
<body>
    <div class="card cate-edit-card shadow-sm mx-auto my-3">
        <div class="card-body p-4 p-sm-5">
            <div class="text-center mb-4">
                <div class="cate-edit-icon mb-2">
                    <i class="bi bi-pencil-square"></i>
                </div>
                <h4 class="fw-bold text-dark mb-1">Cập Nhật Danh Mục</h4>
                <p class="text-muted small mb-0">Chỉnh sửa thông tin, ảnh đại diện hoặc trạng thái danh mục</p>
            </div>

            <c:if test="${not empty alert}">
                <div class="alert alert-danger d-flex align-items-center py-2 px-3 small rounded-3 mb-3" role="alert">
                    <i class="bi bi-exclamation-circle-fill me-2 flex-shrink-0"></i>
                    <div>${alert}</div>
                </div>
            </c:if>

            <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="categoryid" value="${cate.categoryId}">

                <div class="mb-3">
                    <label for="categoryname" class="form-label fw-semibold small text-secondary">Tên danh mục <span class="text-danger">*</span></label>
                    <input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" class="form-control" placeholder="Nhập tên danh mục" required minlength="3">
                    <div class="invalid-feedback">Tên danh mục không được để trống và phải có ít nhất 3 ký tự.</div>
                </div>

                <div class="mb-3">
                    <label for="images" class="form-label fw-semibold small text-secondary">Link hình ảnh <span class="text-muted fw-normal">(hoặc tên file)</span></label>
                    <input type="text" id="images" name="images" value="${cate.images}" class="form-control" placeholder="https://... hoặc tên file">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold small text-secondary d-block">Ảnh hiện tại</label>
                    <c:choose>
                        <c:when test="${not empty cate.images && cate.images.startsWith('https')}">
                            <c:url value="${cate.images}" var="imgUrl"/>
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                        </c:otherwise>
                    </c:choose>
                    <div class="current-img-box d-flex align-items-center gap-3">
                        <img src="${imgUrl}" alt="${cate.categoryname}" class="current-img-preview"
                             onerror="this.src='https://placehold.co/120x80/e2e8f0/64748b?text=No+Image'">
                        <div class="small text-muted text-break">
                            <div class="fw-medium text-dark mb-1">Xem trước ảnh đang dùng</div>
                            <span class="d-inline-block">${not empty cate.images ? cate.images : 'Chưa có ảnh'}</span>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="images1" class="form-label fw-semibold small text-secondary">Đổi hình ảnh mới <span class="text-muted fw-normal">(upload)</span></label>
                    <input type="file" id="images1" name="images1" class="form-control" accept="image/*">
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold small text-secondary d-block mb-2">Trạng thái</label>
                    <div class="status-pill-group d-flex flex-wrap">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}>
                            <label class="form-check-label small fw-medium" for="ston">
                                <i class="bi bi-check-circle text-success me-1"></i>Hoạt động
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}>
                            <label class="form-check-label small fw-medium" for="stoff">
                                <i class="bi bi-lock text-secondary me-1"></i>Khóa
                            </label>
                        </div>
                    </div>
                </div>

                <div class="d-flex gap-2 pt-1">
                    <button type="submit" class="btn btn-primary btn-update-cate flex-grow-1 fw-semibold shadow-sm">
                        <i class="bi bi-check2-circle me-1"></i>Cập nhật
                    </button>
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-light btn-back-cate border fw-medium">
                        <i class="bi bi-arrow-left me-1"></i>Quay lại
                    </a>
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