<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video của tôi - IoTStar Video</title>
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
                    <a href="<c:url value='/home'/>" class="btn btn-outline-light btn-sm me-2 px-3">Trang chủ</a>
                    <a href="<c:url value='/video'/>" class="btn btn-light btn-sm me-3 fw-semibold px-3">Video của tôi</a>
                    
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
                <i class="bi bi-collection-play text-primary me-2"></i>Danh Sách Video Của Tôi
            </h3>
            <a href="<c:url value='/admin/video/add'/>" class="btn btn-success btn-sm px-3 shadow-sm">
                <i class="bi bi-plus-circle me-1"></i>Thêm Video Mới
            </a>
        </div>

        <!-- Video Grid -->
        <div class="row g-4">
            <c:forEach items="${videos}" var="v">
                <div class="col-md-4">
                    <div class="card video-card h-100 shadow-sm border-0 rounded-4 overflow-hidden">
                        <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="overflow-hidden">
                            <img src="<c:url value='/image?fname=${v.poster}'/>" class="card-img-top" style="height: 180px; object-fit: cover;" alt="${v.title}">
                        </a>
                        <div class="card-body d-flex flex-column p-4">
                            <h5 class="card-title mb-2">
                                <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="text-decoration-none text-dark fw-bold text-truncate" style="display: block;">
                                    ${v.title}
                                </a>
                            </h5>
                            <p class="card-text text-muted small text-truncate-2 mb-3" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; height: 2.6em;">
                                ${v.description}
                            </p>
                            <div class="mt-auto">
                                <div class="d-flex justify-content-between align-items-center text-muted small mb-3 pt-2 border-top">
                                    <span><i class="bi bi-eye me-1 text-primary"></i>${v.views} lượt xem</span>
                                    <span class="badge rounded-pill ${v.active ? 'bg-success' : 'bg-secondary'} px-3 py-1">
                                        ${v.active ? 'Hoạt động' : 'Đã khóa'}
                                    </span>
                                </div>
                                <div class="d-flex gap-2">
                                    <a href="<c:url value='/admin/video/edit?id=${v.videoId}'/>" class="btn btn-warning btn-sm flex-fill fw-semibold">
                                        <i class="bi bi-pencil-square me-1"></i>Sửa
                                    </a>
                                    <a href="<c:url value='/admin/video/delete?id=${v.videoId}'/>" class="btn btn-outline-danger btn-sm flex-fill fw-semibold"
                                       onclick="return confirm('Bạn có chắc muốn xóa video này?');">
                                        <i class="bi bi-trash me-1"></i>Xóa
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Empty state -->
            <c:if test="${empty videos}">
                <div class="col-12 text-center py-5">
                    <i class="bi bi-folder2-open display-4 text-muted mb-3 d-block"></i>
                    <p class="text-muted fs-5">Bạn chưa đăng tải video nào. Hãy bấm <strong>Thêm Video Mới</strong> để bắt đầu!</p>
                </div>
            </c:if>
        </div>

        <!-- Phân trang 6 video / trang -->
        <c:if test="${totalPages > 1}">
            <nav class="mt-5">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link shadow-none" href="<c:url value='/video?page=${currentPage - 1}'/>">Trước</a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link shadow-none" href="<c:url value='/video?page=${i}'/>">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link shadow-none" href="<c:url value='/video?page=${currentPage + 1}'/>">Sau</a>
                    </li>
                </ul>
            </nav>
        </c:if>
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