<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
        body {
            background-color: #f1f5f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .my-video-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0 !important;
            border-radius: 16px !important;
            transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.2s ease;
        }
        .my-video-card:hover {
            transform: translateY(-4px);
            border-color: #cbd5e1 !important;
            box-shadow: 0 12px 24px rgba(15, 23, 42, 0.09) !important;
        }
        .my-video-thumb {
            border-radius: 12px;
            overflow: hidden;
            background-color: #e2e8f0;
        }
        .my-video-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.28s ease;
        }
        .my-video-card:hover .my-video-thumb img {
            transform: scale(1.04);
        }
        .my-video-title {
            color: #0f172a;
            font-size: 1rem;
            line-height: 1.4;
            transition: color 0.18s ease;
        }
        .my-video-card:hover .my-video-title {
            color: #0d6efd;
        }
        .my-video-desc {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            min-height: 2.8em;
            line-height: 1.4;
            color: #64748b;
            font-size: 0.86rem;
        }
        .btn-card-action {
            border-radius: 10px;
            padding: 0.42rem 0.75rem;
            font-size: 0.85rem;
        }
        .empty-my-video {
            border: 1.5px dashed #cbd5e1;
            background-color: #ffffff;
            border-radius: 18px;
        }
        .page-link {
            border-color: #e2e8f0;
            color: #334155;
            border-radius: 8px !important;
            margin: 0 2px;
        }
        .page-item.active .page-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
            color: #ffffff;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

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
                <div class="d-flex flex-wrap align-items-center gap-2 mt-3 mt-lg-0">
                    <a href="<c:url value='/home'/>" class="btn btn-outline-light btn-sm px-3 rounded-3">
                        <i class="bi bi-house-door me-1"></i>Trang chủ
                    </a>
                    <a href="<c:url value='/video'/>" class="btn btn-light btn-sm fw-semibold px-3 rounded-3">
                        <i class="bi bi-collection-play me-1"></i>Video của tôi
                    </a>

                    <c:if test="${not empty sessionScope.account}">
                        <div class="dropdown ms-lg-1">
                            <button class="btn btn-secondary btn-sm dropdown-toggle text-white bg-transparent border-0" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i> Xin chào, <strong>${sessionScope.account.fullname}</strong>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0 rounded-3">
                                <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-4 py-md-5 flex-grow-1">
        <!-- Header Section -->
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4 pb-3 border-bottom">
            <div class="d-flex align-items-center gap-3">
                <span class="bg-primary bg-opacity-10 text-primary rounded-3 p-2 d-inline-flex fs-4">
                    <i class="bi bi-collection-play"></i>
                </span>
                <div>
                    <h3 class="fw-bold text-dark mb-0">Danh Sách Video Của Tôi</h3>
                    <small class="text-muted">Quản lý video đã tải lên, trạng thái hoạt động và chỉnh sửa nội dung</small>
                </div>
            </div>
            <a href="<c:url value='/admin/video/add'/>" class="btn btn-success rounded-3 px-3 py-2 fw-semibold shadow-sm">
                <i class="bi bi-plus-circle me-1"></i>Thêm Video Mới
            </a>
        </div>

        <!-- Video Grid -->
        <div class="row g-4">
            <c:forEach items="${videos}" var="v">
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="card my-video-card h-100 shadow-none">
                        <div class="p-3 pb-0">
                            <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="my-video-thumb ratio ratio-16x9 d-block">
                                <img src="<c:url value='/image?fname=${v.poster}'/>"
                                     alt="${v.title}"
                                     onerror="this.src='https://placehold.co/640x360/e2e8f0/64748b?text=IoTStar+Video'">
                            </a>
                        </div>

                        <div class="card-body d-flex flex-column p-3 p-sm-4 pt-3">
                            <h5 class="card-title mb-2">
                                <a href="<c:url value='/video/detail?id=${v.videoId}'/>"
                                   class="text-decoration-none fw-bold text-truncate d-block my-video-title"
                                   title="${v.title}">
                                    ${v.title}
                                </a>
                            </h5>

                            <p class="card-text my-video-desc mb-3">
                                ${v.description}
                            </p>

                            <div class="mt-auto">
                                <div class="d-flex justify-content-between align-items-center text-muted small mb-3 pt-2 border-top">
                                    <span>
                                        <i class="bi bi-eye-fill me-1 text-primary"></i>
                                        <fmt:formatNumber value="${v.views}" type="number"/> lượt xem
                                    </span>
                                    <span class="badge rounded-pill px-3 py-1 fw-medium ${v.active ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-secondary-subtle text-secondary border border-secondary-subtle'}">
                                        <i class="bi ${v.active ? 'bi-check-circle-fill' : 'bi-lock-fill'} me-1"></i>
                                        ${v.active ? 'Hoạt động' : 'Đã khóa'}
                                    </span>
                                </div>

                                <div class="d-flex gap-2">
                                    <a href="<c:url value='/admin/video/edit?id=${v.videoId}'/>" class="btn btn-warning btn-card-action flex-fill fw-semibold text-dark">
                                        <i class="bi bi-pencil-square me-1"></i>Sửa
                                    </a>
                                    <a href="<c:url value='/admin/video/delete?id=${v.videoId}'/>" class="btn btn-outline-danger btn-card-action flex-fill fw-semibold"
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
                <div class="col-12">
                    <div class="empty-my-video text-center py-5 px-3 shadow-sm">
                        <div class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 76px; height: 76px;">
                            <i class="bi bi-folder2-open fs-1 text-secondary"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-1">Chưa có video nào trong danh sách</h5>
                        <p class="text-muted mb-4">Bạn chưa đăng tải video nào. Hãy bấm <strong>Thêm Video Mới</strong> để bắt đầu!</p>
                        <a href="<c:url value='/admin/video/add'/>" class="btn btn-success rounded-3 px-4 fw-semibold">
                            <i class="bi bi-plus-circle me-1"></i>Thêm Video Mới
                        </a>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Phân trang 6 video / trang -->
        <c:if test="${totalPages > 1}">
            <nav class="mt-5" aria-label="Phân trang video">
                <ul class="pagination justify-content-center mb-0">
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