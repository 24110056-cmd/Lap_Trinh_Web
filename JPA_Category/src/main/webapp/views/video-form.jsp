<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Video - Thêm/Sửa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<c:url value='/home'/>"><i class="bi bi-play-circle-fill text-danger me-2"></i>IoTStar Video - Admin</a>
            <div class="d-flex align-items-center">
                <a href="<c:url value='/video'/>" class="btn btn-outline-light btn-sm me-2">Quay lại danh sách</a>
                <a href="<c:url value='/logout'/>" class="btn btn-danger btn-sm">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <!-- Main Form Content -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="card shadow-sm border-0 rounded-4 p-4">
                    <h3 class="fw-bold mb-4 text-center text-primary">
                        <i class="bi bi-film me-2"></i>Thông Tin Video
                    </h3>

                    <!-- Form hỗ trợ enctype="multipart/form-data" để upload file poster -->
                    <form action="" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mã Video (Video ID)</label>
                            <input type="text" name="videoId" value="${video.videoId}" class="form-control" placeholder="VD: v01, v02..." required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tiêu đề Video</label>
                            <input type="text" name="title" value="${video.title}" class="form-control" placeholder="Nhập tiêu đề video" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Ảnh Poster</label>
                            <input type="file" name="posterFile" class="form-control" accept="image/*">
                            <c:if test="${not empty video.poster}">
                                <div class="mt-2">
                                    <small class="text-muted">Poster hiện tại: ${video.poster}</small><br>
                                    <img src="<c:url value='/images?fname=${video.poster}'/>" class="img-thumbnail mt-1" style="height: 80px;" alt="Poster">
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

                        <div class="d-flex justify-content-between">
                            <a href="<c:url value='/video'/>" class="btn btn-secondary px-4">Hủy bỏ</a>
                            <button type="submit" class="btn btn-success px-5 fw-semibold">Lưu lại</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>