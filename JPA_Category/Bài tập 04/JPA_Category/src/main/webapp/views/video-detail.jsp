<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video.title} - Chi tiết Video</title>
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
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <div class="d-flex align-items-center mt-3 mt-lg-0">
                    <a href="<c:url value='/home'/>" class="btn btn-outline-light btn-sm me-2 px-3">Trang chủ</a>
                    <a href="<c:url value='/video'/>" class="btn btn-outline-light btn-sm me-3 px-3">Danh sách Video</a>
                    
                    <c:if test="${not empty sessionScope.account}">
                        <div class="dropdown">
                            <button class="btn btn-secondary btn-sm dropdown-toggle text-white bg-transparent border-0" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i> Xin chào, <strong>${sessionScope.account.fullname}</strong>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-5 flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden bg-white">
                    <!-- Trình phát Video HTML5 -->
                    <div class="bg-black text-center overflow-hidden">
                        <video class="w-100" style="max-height: 480px; outline: none;" controls
                               poster="<c:url value='/image?fname=${video.poster}'/>">
                            <source src="<c:url value='/image?fname=${video.videoUrl}'/>" type="video/mp4">
                            Trình duyệt của bạn không hỗ trợ phát video.
                        </video>
                    </div>
                    
                    <div class="card-body p-4 p-md-5">
                        <h3 class="fw-bold text-dark mb-2">${video.title}</h3>
                        
                        <div class="d-flex justify-content-between align-items-center text-muted border-bottom pb-3 mb-4 small">
                            <span><i class="bi bi-eye text-primary me-1"></i><strong>${video.views}</strong> lượt xem</span>
                            <span><i class="bi bi-person-fill text-secondary me-1"></i>Đăng bởi: <strong>${video.user.fullname}</strong></span>
                        </div>

                        <h5 class="fw-bold mb-2 text-secondary">Mô tả video</h5>
                        <p class="text-secondary bg-light p-3 rounded-3" style="white-space: pre-line; line-height: 1.6;">
                            ${empty video.description ? 'Chưa có mô tả cho video này.' : video.description}
                        </p>

                        <div class="mt-4 pt-3 border-top d-flex justify-content-between align-items-center">
                            <a href="<c:url value='/video'/>" class="btn btn-secondary btn-sm px-3 fw-semibold">
                                <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
                            </a>
                            
                            <c:if test="${sessionScope.account.id == video.user.id || sessionScope.account.roleid == 1}">
                                <div>
                                    <a href="<c:url value='/admin/video/edit?id=${video.videoId}'/>" class="btn btn-warning btn-sm me-2 px-3 fw-semibold">
                                        <i class="bi bi-pencil-square me-1"></i>Sửa video
                                    </a>
                                    <a href="<c:url value='/admin/video/delete?id=${video.videoId}'/>" class="btn btn-outline-danger btn-sm px-3 fw-semibold" onclick="return confirm('Bạn có chắc muốn xóa video này?');">
                                        <i class="bi bi-trash me-1"></i>Xóa video
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>
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