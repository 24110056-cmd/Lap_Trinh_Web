<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
    <style>
        body {
            background-color: #f1f5f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .detail-card {
            border-radius: 18px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            background-color: #ffffff;
            overflow: hidden;
        }
        .player-stage {
            background-color: #090d16;
        }
        .player-stage video {
            width: 100%;
            max-height: 500px;
            display: block;
            outline: none;
        }
        .meta-pill {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 999px;
            padding: 0.35rem 0.8rem;
            font-size: 0.84rem;
            color: #334155;
        }
        .desc-box {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 1rem 1.15rem;
            color: #334155;
            white-space: pre-line;
            line-height: 1.65;
            font-size: 0.95rem;
        }
        .btn-action-item {
            border-radius: 10px;
            padding: 0.45rem 0.9rem;
            font-size: 0.86rem;
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
                    <a href="<c:url value='/video'/>" class="btn btn-outline-light btn-sm px-3 rounded-3">
                        <i class="bi bi-collection-play me-1"></i>Danh sách Video
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
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="card detail-card shadow-sm">
                    <!-- Trình phát Video HTML5 -->
                    <div class="player-stage">
                        <video controls
                               poster="<c:url value='/image?fname=${video.poster}'/>">
                            <source src="<c:url value='/image?fname=${video.videoUrl}'/>" type="video/mp4">
                            Trình duyệt của bạn không hỗ trợ phát video.
                        </video>
                    </div>

                    <div class="card-body p-4 p-md-5">
                        <h3 class="fw-bold text-dark mb-3">${video.title}</h3>

                        <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 pb-3 mb-4 border-bottom">
                            <div class="d-flex flex-wrap align-items-center gap-2">
                                <span class="meta-pill">
                                    <i class="bi bi-eye-fill text-primary me-1"></i>
                                    <strong><fmt:formatNumber value="${video.views}" type="number"/></strong> lượt xem
                                </span>
                                <span class="meta-pill">
                                    <i class="bi bi-person-fill text-secondary me-1"></i>
                                    Đăng bởi: <strong>${video.user.fullname}</strong>
                                </span>
                            </div>
                        </div>

                        <h6 class="fw-bold text-secondary mb-2">
                            <i class="bi bi-card-text me-1"></i>Mô tả video
                        </h6>
                        <div class="desc-box">
                            ${empty video.description ? 'Chưa có mô tả cho video này.' : video.description}
                        </div>

                        <div class="mt-4 pt-3 border-top d-flex flex-wrap justify-content-between align-items-center gap-2">
                            <a href="<c:url value='/video'/>" class="btn btn-light border btn-action-item fw-semibold">
                                <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
                            </a>

                            <c:if test="${sessionScope.account.id == video.user.id || sessionScope.account.roleid == 1}">
                                <div class="d-flex flex-wrap gap-2">
                                    <a href="<c:url value='/admin/video/edit?id=${video.videoId}'/>" class="btn btn-warning btn-action-item fw-semibold text-dark">
                                        <i class="bi bi-pencil-square me-1"></i>Sửa video
                                    </a>
                                    <a href="<c:url value='/admin/video/delete?id=${video.videoId}'/>" class="btn btn-outline-danger btn-action-item fw-semibold" onclick="return confirm('Bạn có chắc muốn xóa video này?');">
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