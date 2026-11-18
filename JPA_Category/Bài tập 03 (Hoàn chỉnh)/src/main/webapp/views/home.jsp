<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - IoTStar Video</title>
    <!-- Thêm đầy đủ Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Thêm Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .video-card {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
        .video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important;
        }
        .card-img-top {
            transition: opacity 0.2s;
        }
        .video-card:hover .card-img-top {
            opacity: 0.9;
        }
    </style>
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
                    <a href="<c:url value='/home'/>" class="btn btn-dark btn-sm me-2 fw-semibold px-3">Trang chủ</a>
                    <a href="<c:url value='/video'/>" class="btn btn-outline-light btn-sm me-3 px-3">Video của tôi</a>
                    
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
        <!-- Header Section -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <h3 class="fw-bold text-dark mb-0">
                <i class="bi bi-fire text-danger me-2"></i>10 Video Mới Nhất
            </h3>
            <a href="<c:url value='/admin/video/add'/>" class="btn btn-danger btn-sm px-3 shadow-sm">
                <i class="bi bi-plus-lg me-1"></i>Đăng Video Mới
            </a>
        </div>

        <!-- Video Grid -->
        <div class="row g-4">
            <c:forEach items="${videos}" var="v">
                <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="card video-card h-100 shadow-sm border-0 rounded-4 overflow-hidden">
                        <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="overflow-hidden">
                            <img src="<c:url value='/image?fname=${v.poster}'/>" class="card-img-top" style="height: 160px; object-fit: cover;" alt="${v.title}">
                        </a>
                        <div class="card-body d-flex flex-column p-3">
                            <h6 class="card-title mb-2">
                                <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="text-decoration-none text-dark fw-bold text-truncate-2" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; height: 2.4em;">
                                    ${v.title}
                                </a>
                            </h6>
                            <div class="mt-auto text-muted small d-flex justify-content-between pt-2 border-top">
                                <span><i class="bi bi-eye me-1 text-primary"></i>${v.views} xem</span>
                                <span class="text-truncate" style="max-width: 100px;"><i class="bi bi-person me-1 text-secondary"></i>${v.user.fullname}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <!-- Empty state -->
            <c:if test="${empty videos}">
                <div class="col-12 text-center py-5">
                    <i class="bi bi-film display-4 text-muted mb-3 d-block"></i>
                    <p class="text-muted fs-5">Chưa có video nào được đăng tải.</p>
                </div>
            </c:if>
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