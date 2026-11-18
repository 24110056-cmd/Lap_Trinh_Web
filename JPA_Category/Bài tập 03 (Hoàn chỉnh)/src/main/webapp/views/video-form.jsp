<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Video - Thêm/Sửa</title>
    <!-- Thêm đầy đủ Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Thêm Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm py-3">
        <div class="container">
            <a class="navbar-brand fw-bold fs-4" href="<c:url value='/home'/>">
                <i class="bi bi-play-circle-fill text-danger me-2"></i>IoTStar Video
            </a>
            <div class="d-flex align-items-center">
                <a href="<c:url value='/video'/>" class="btn btn-outline-light btn-sm me-2 px-3">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
                </a>
                <a href="<c:url value='/logout'/>" class="btn btn-danger btn-sm px-3">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-5 flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-sm border-0 rounded-4 p-4 p-md-5 bg-white">
                    <h3 class="fw-bold mb-4 text-center text-primary">
                        <i class="bi bi-film me-2"></i>${empty video ? 'Thêm Video Mới' : 'Cập Nhật Video'}
                    </h3>

                    <!-- Hiển thị thông báo lỗi nếu có từ Controller -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show fw-semibold" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mã Video (Video ID)</label>
                            <input type="text" name="videoId" value="${video.videoId}" class="form-control"
                                   placeholder="VD: v02, v03..." ${not empty video ? 'readonly' : 'required'}>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tiêu đề Video</label>
                            <input type="text" name="title" value="${video.title}" class="form-control" placeholder="Nhập tiêu đề video" required>
                        </div>

                        <c:if test="${not empty categories}">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Danh mục (Category)</label>
                                <select name="categoryId" class="form-select">
                                    <c:forEach items="${categories}" var="c">
                                        <option value="${c.categoryId}" ${video.category.categoryId == c.categoryId ? 'selected' : ''}>
                                            ${c.categoryname}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:if>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Ảnh Poster</label>
                            <input type="file" name="posterFile" class="form-control" accept="image/*" ${empty video ? 'required' : ''}>
                            <c:if test="${not empty video.poster}">
                                <div class="mt-2 p-2 bg-light rounded border d-inline-block">
                                    <small class="text-muted d-block mb-1">Poster hiện tại: <strong>${video.poster}</strong></small>
                                    <img src="<c:url value='/image?fname=${video.poster}'/>" class="img-thumbnail rounded" style="height: 100px; object-fit: cover;" alt="Poster">
                                </div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">File Video (.mp4)</label>
                            <input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*" ${empty video ? 'required' : ''}>
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
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <div class="container">
            <p class="mb-0 small text-muted">© 2026 IoTStar Video. All rights reserved.</p>
        </div>
    </footer>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>