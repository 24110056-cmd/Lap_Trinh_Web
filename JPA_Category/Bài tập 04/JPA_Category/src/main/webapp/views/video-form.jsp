<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>${empty video.videoId ? 'Thêm Video Mới' : 'Cập Nhật Video'}</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 rounded-4 p-4 p-md-5 bg-white">
                <h3 class="fw-bold mb-4 text-center text-primary">
                    <i class="bi bi-film me-2"></i>${empty video.videoId ? 'Thêm Video Mới' : 'Cập Nhật Video'}
                </h3>

                <!-- Hiển thị thông báo lỗi nếu có từ Controller -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show fw-semibold" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mã Video (Video ID)</label>
                        <input type="text" name="videoId" value="${video.videoId}" class="form-control"
                               placeholder="VD: v02, v03..." ${not empty video.videoId ? 'readonly' : 'required'} maxlength="50">
                        <div class="invalid-feedback">Vui lòng nhập Mã Video (tối đa 50 ký tự).</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tiêu đề Video</label>
                        <input type="text" name="title" value="${video.title}" class="form-control" placeholder="Nhập tiêu đề video" required minlength="3" maxlength="255">
                        <div class="invalid-feedback">Tiêu đề Video không được để trống (từ 3 đến 255 ký tự).</div>
                    </div>

                    <c:if test="${not empty categories}">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Danh mục (Category)</label>
                            <select name="categoryId" class="form-select" required>
                                <c:forEach items="${categories}" var="c">
                                    <option value="${c.categoryId}" ${video.category.categoryId == c.categoryId ? 'selected' : ''}>
                                        ${c.categoryname}
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">Vui lòng chọn danh mục cho video.</div>
                        </div>
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Ảnh Poster</label>
                        <input type="file" name="posterFile" class="form-control" accept="image/*" ${empty video.poster ? 'required' : ''}>
                        <div class="invalid-feedback">Vui lòng chọn ảnh Poster cho video.</div>
                        <c:if test="${not empty video.poster}">
                            <div class="mt-2 p-2 bg-light rounded border d-inline-block">
                                <small class="text-muted d-block mb-1">Poster hiện tại: <strong>${video.poster}</strong></small>
                                <img src="<c:url value='/image?fname=${video.poster}'/>" class="img-thumbnail rounded" style="height: 100px; object-fit: cover;" alt="Poster">
                            </div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">File Video (.mp4)</label>
                        <input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*" ${empty video.videoUrl ? 'required' : ''}>
                        <div class="invalid-feedback">Vui lòng chọn file Video để tải lên.</div>
                        <c:if test="${not empty video.videoUrl}">
                            <div class="mt-2">
                                <small class="text-success"><i class="bi bi-check-circle me-1"></i>Video hiện tại: <strong>${video.videoUrl}</strong></small>
                            </div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Trạng thái Active</label>
                        <select name="active" class="form-select">
                            <option value="true" ${video.active == true ? 'selected' : ''}>Hoạt động (Active)</option>
                            <option value="false" ${video.active == false ? 'selected' : ''}>Khóa (Inactive)</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Mô tả chi tiết</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Nhập nội dung mô tả video...">${video.description}</textarea>
                    </div>

                    <div class="d-flex justify-content-between pt-3 border-top">
                        <a href="<c:url value='/video'/>" class="btn btn-secondary px-4 fw-semibold">Hủy bỏ</a>
                        <button type="submit" class="btn btn-success px-5 fw-semibold shadow-sm">Lưu lại</button>
                    </div>
                </form>
            </div>
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
