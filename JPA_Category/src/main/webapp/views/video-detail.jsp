<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video.title} - Chi tiết Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<c:url value='/home'/>"><i class="bi bi-play-circle-fill text-danger me-2"></i>IoTStar Video</a>
            <div class="d-flex align-items-center">
                <a href="<c:url value='/video'/>" class="btn btn-outline-light btn-sm me-2">Danh sách Video</a>
                <c:if test="${not empty sessionScope.account}">
                    <span class="text-white me-3 small">Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                    <a href="<c:url value='/logout'/>" class="btn btn-danger btn-sm">Đăng xuất</a>
                </c:if>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="card shadow-sm border-0">
                    <!-- Khu vực hiển thị Poster / Trình phát Video -->
                    <div class="bg-black text-center p-3 rounded-top">
                        <img src="<c:url value='/images?fname=${video.poster}'/>" class="img-fluid rounded" style="max-height: 450px; object-fit: contain;" alt="Video Poster">
                    </div>
                    
                    <div class="card-body p-4">
                        <h3 class="fw-bold text-dark mb-2">${video.title}</h3>
                        
                        <div class="d-flex justify-content-between align-items-center text-muted border-bottom pb-3 mb-3 small">
                            <span><i class="bi bi-eye text-primary me-1"></i><strong>${video.views}</strong> lượt xem</span>
                            <span><i class="bi bi-person-fill text-secondary me-1"></i>Đăng bởi: <strong>${video.user.fullname}</strong></span>
                        </div>

                        <h5 class="fw-semibold mb-2">Mô tả video</h5>
                        <p class="text-secondary" style="white-space: pre-line; line-height: 1.6;">
                            ${video.description}
                        </p>

                        <div class="mt-4 pt-3 border-top d-flex justify-content-between">
                            <a href="<c:url value='/video'/>" class="btn btn-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i>Quay lại danh sách</a>
                            <c:if test="${sessionScope.account.roleid == 1}">
                                <a href="<c:url value='/admin/video/delete?id=${video.videoId}'/>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa video này?');"><i class="bi bi-trash me-1"></i>Xóa video</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>