<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>${empty video.videoId ? 'Thêm Video Mới' : 'Cập Nhật Video'}</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1f5f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .video-form-card {
            border-radius: 18px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            background-color: #ffffff;
        }
        .video-form-icon {
            width: 50px;
            height: 50px;
            border-radius: 14px;
            background-color: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
        }
        .video-form-card .form-control,
        .video-form-card .form-select {
            border-color: #e2e8f0;
            border-radius: 10px;
            padding: 0.58rem 0.85rem;
            font-size: 0.94rem;
        }
        .video-form-card .form-control:focus,
        .video-form-card .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.14);
        }
        .video-form-card .form-control[readonly] {
            background-color: #f8fafc;
            color: #64748b;
        }
        .media-preview-box {
            background-color: #f8fafc;
            border: 1px dashed #cbd5e1;
            border-radius: 12px;
            padding: 0.75rem 1rem;
        }
        .poster-thumb-preview {
            width: 144px;
            height: 86px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            background-color: #ffffff;
        }
        .btn-cancel-video {
            border-radius: 10px;
            padding: 0.6rem 1.25rem;
        }
        .btn-save-video {
            border-radius: 10px;
            padding: 0.6rem 1.75rem;
        }
    </style>
</head>
<body>
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card video-form-card shadow-sm p-4 p-md-5">
                    <div class="text-center mb-4">
                        <div class="video-form-icon mb-2">
                            <i class="bi bi-film"></i>
                        </div>
                        <h3 class="fw-bold text-dark mb-1">
                            ${empty video.videoId ? 'Thêm Video Mới' : 'Cập Nhật Video'}
                        </h3>
                        <p class="text-muted small mb-0">
                            ${empty video.videoId ? 'Tải lên video, ảnh poster và thông tin chi tiết' : 'Chỉnh sửa nội dung, poster hoặc tệp video đã đăng'}
                        </p>
                    </div>

                    <!-- Hiển thị thông báo lỗi nếu có từ Controller -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center py-2 px-3 small rounded-3 mb-4" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2 flex-shrink-0"></i>
                            <div class="fw-semibold">${error}</div>
                            <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <div class="row g-3 mb-3">
                            <div class="col-md-5">
                                <label class="form-label fw-semibold small text-secondary">
                                    Mã Video (Video ID) <c:if test="${empty video.videoId}"><span class="text-danger">*</span></c:if>
                                </label>
                                <input type="text" name="videoId" value="${video.videoId}" class="form-control"
                                       placeholder="VD: v02, v03..." ${not empty video.videoId ? 'readonly' : 'required'} maxlength="50">
                                <div class="invalid-feedback">Vui lòng nhập Mã Video (tối đa 50 ký tự).</div>
                            </div>

                            <div class="col-md-7">
                                <label class="form-label fw-semibold small text-secondary">
                                    Tiêu đề Video <span class="text-danger">*</span>
                                </label>
                                <input type="text" name="title" value="${video.title}" class="form-control" placeholder="Nhập tiêu đề video" required minlength="3" maxlength="255">
                                <div class="invalid-feedback">Tiêu đề Video không được để trống (từ 3 đến 255 ký tự).</div>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <c:if test="${not empty categories}">
                                <div class="${not empty categories ? 'col-md-7' : 'col-12'}">
                                    <label class="form-label fw-semibold small text-secondary">
                                        Danh mục (Category) <span class="text-danger">*</span>
                                    </label>
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

                            <div class="${not empty categories ? 'col-md-5' : 'col-12'}">
                                <label class="form-label fw-semibold small text-secondary">Trạng thái Active</label>
                                <select name="active" class="form-select">
                                    <option value="true" ${video.active == true ? 'selected' : ''}>Hoạt động (Active)</option>
                                    <option value="false" ${video.active == false ? 'selected' : ''}>Khóa (Inactive)</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-secondary">
                                Ảnh Poster <c:if test="${empty video.poster}"><span class="text-danger">*</span></c:if>
                            </label>
                            <input type="file" name="posterFile" class="form-control" accept="image/*" ${empty video.poster ? 'required' : ''}>
                            <div class="invalid-feedback">Vui lòng chọn ảnh Poster cho video.</div>
                            <c:if test="${not empty video.poster}">
                                <div class="media-preview-box d-flex align-items-center gap-3 mt-2">
                                    <img src="<c:url value='/image?fname=${video.poster}'/>" class="poster-thumb-preview" alt="Poster"
                                         onerror="this.src='https://placehold.co/160x90/e2e8f0/64748b?text=Poster'">
                                    <div class="small text-muted text-break">
                                        <div class="fw-semibold text-dark mb-1">Poster hiện tại</div>
                                        <span>${video.poster}</span>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-secondary">
                                File Video (.mp4) <c:if test="${empty video.videoUrl}"><span class="text-danger">*</span></c:if>
                            </label>
                            <input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*" ${empty video.videoUrl ? 'required' : ''}>
                            <div class="invalid-feedback">Vui lòng chọn file Video để tải lên.</div>
                            <c:if test="${not empty video.videoUrl}">
                                <div class="media-preview-box d-flex align-items-center gap-2 mt-2 small text-success">
                                    <i class="bi bi-check-circle-fill flex-shrink-0"></i>
                                    <span class="text-break">Video hiện tại: <strong>${video.videoUrl}</strong></span>
                                </div>
                            </c:if>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold small text-secondary">Mô tả chi tiết</label>
                            <textarea name="description" class="form-control" rows="4" placeholder="Nhập nội dung mô tả video...">${video.description}</textarea>
                        </div>

                        <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 pt-3 border-top">
                            <a href="<c:url value='/video'/>" class="btn btn-light border btn-cancel-video fw-semibold">
                                <i class="bi bi-arrow-left me-1"></i>Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-success btn-save-video fw-semibold shadow-sm">
                                <i class="bi bi-check2-circle me-1"></i>Lưu lại
                            </button>
                        </div>
                    </form>
                </div>
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