<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="64kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<head>
    <title>Trang chủ - IoTStar Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1f5f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .home-topbar {
            background-color: #0f172a;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .home-topbar .nav-link {
            color: rgba(255, 255, 255, 0.78);
            border-radius: 9px;
            padding: 0.42rem 0.78rem;
            font-size: 0.9rem;
            font-weight: 500;
        }
        .home-topbar .nav-link:hover,
        .home-topbar .nav-link.active {
            color: #ffffff;
            background-color: rgba(255, 255, 255, 0.1);
        }
        .account-pill {
            background-color: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.14);
            border-radius: 999px;
            padding: 0.32rem 0.78rem;
            font-size: 0.85rem;
            color: #e2e8f0;
            text-decoration: none;
        }
        .account-pill:hover {
            background-color: rgba(255, 255, 255, 0.15);
            color: #ffffff;
        }
        .home-shell {
            background-color: #ffffff;
            border-radius: 20px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.05);
        }
        .home-icon-box {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
        }
        .video-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0 !important;
            border-radius: 16px !important;
            transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.2s ease;
        }
        .video-card:hover {
            transform: translateY(-4px);
            border-color: #cbd5e1 !important;
            box-shadow: 0 12px 24px rgba(15, 23, 42, 0.09) !important;
        }
        .video-thumb {
            border-radius: 12px;
            overflow: hidden;
            background-color: #e2e8f0;
        }
        .video-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.28s ease;
        }
        .video-card:hover .video-thumb img {
            transform: scale(1.04);
        }
        .video-title {
            color: #0f172a;
            font-size: 0.96rem;
            line-height: 1.42;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            min-height: 2.75em;
            transition: color 0.18s ease;
        }
        .video-card:hover .video-title {
            color: #dc3545;
        }
        .video-meta {
            font-size: 0.82rem;
            color: #64748b;
        }
        .empty-box {
            border: 1.5px dashed #cbd5e1;
            background-color: #f8fafc;
            border-radius: 16px;
        }
    </style>
</head>

<!-- TOP NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark home-topbar shadow-sm py-2 mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="<c:url value='/home'/>">
            <i class="bi bi-play-circle-fill text-danger fs-4"></i>
            <span>IOTSTAR VIDEO</span>
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#homeNavMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="homeNavMenu">
            <ul class="navbar-nav me-auto gap-1 my-2 my-lg-0 ms-lg-3">
                <li class="nav-item">
                    <a class="nav-link active" href="<c:url value='/home'/>">
                        <i class="bi bi-house-door me-1"></i>Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/video'/>">
                        <i class="bi bi-collection-play me-1"></i>Video của tôi
                    </a>
                </li>
                <c:if test="${not empty sessionScope.account}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/profile'/>">
                            <i class="bi bi-person-gear me-1"></i>Hồ sơ cá nhân
                        </a>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav align-items-lg-center gap-2">
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <li class="nav-item">
                            <a href="<c:url value='/profile'/>" class="account-pill d-inline-flex align-items-center" title="Xem thông tin cá nhân">
                                <i class="bi bi-person-circle text-info me-1"></i>
                                <span>Xin chào, <strong class="text-white">${sessionScope.account.fullname}</strong></span>
                            </a>
                        </li>
                        <c:if test="${sessionScope.account.roleid == 1}">
                            <li class="nav-item">
                                <a class="btn btn-warning btn-sm rounded-3 fw-semibold text-dark px-2 py-1" href="<c:url value='/admin/categories'/>">
                                    <i class="bi bi-speedometer2 me-1"></i>Quản trị
                                </a>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="btn btn-outline-light btn-sm rounded-3 fw-medium px-2 py-1" href="<c:url value='/logout'/>">
                                <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="btn btn-light btn-sm rounded-3 fw-semibold text-dark px-3 py-1" href="<c:url value='/login'/>">
                                Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-light btn-sm rounded-3 fw-medium px-3 py-1" href="<c:url value='/register'/>">
                                Đăng ký
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="container pb-5">
    <div class="home-shell p-4 p-md-5">
        <!-- Header Section -->
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4 pb-3 border-bottom">
            <div class="d-flex align-items-center gap-3">
                <div class="home-icon-box">
                    <i class="bi bi-fire"></i>
                </div>
                <div>
                    <h4 class="fw-bold text-dark mb-0">10 Video Mới Nhất</h4>
                    <small class="text-muted">Khám phá các video nổi bật trên IoTStar Video</small>
                </div>
            </div>
            <div class="d-flex flex-wrap gap-2">
                <a href="<c:url value='/video'/>" class="btn btn-outline-secondary rounded-3 px-3 py-2 fw-semibold">
                    <i class="bi bi-collection-play me-1"></i>Video của tôi
                </a>
                <a href="<c:url value='/admin/video/add'/>" class="btn btn-danger rounded-3 px-3 py-2 fw-semibold shadow-sm">
                    <i class="bi bi-plus-lg me-1"></i>Đăng Video Mới
                </a>
            </div>
        </div>

        <!-- Video Grid -->
        <div class="row g-4">
            <c:forEach items="${videos}" var="v">
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="card video-card h-100 shadow-none">
                        <div class="p-2 pb-0">
                            <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="video-thumb ratio ratio-16x9 d-block">
                                <img src="<c:url value='/image?fname=${v.poster}'/>"
                                     alt="${v.title}"
                                     onerror="this.src='https://placehold.co/640x360/e2e8f0/64748b?text=IoTStar+Video'">
                            </a>
                        </div>

                        <div class="card-body d-flex flex-column p-3">
                            <h6 class="card-title mb-3">
                                <a href="<c:url value='/video/detail?id=${v.videoId}'/>"
                                   class="text-decoration-none fw-semibold video-title"
                                   title="${v.title}">
                                    ${v.title}
                                </a>
                            </h6>

                            <div class="mt-auto pt-2 border-top d-flex align-items-center justify-content-between gap-2 video-meta">
                                <span class="d-flex align-items-center text-truncate" title="${v.user.fullname}">
                                    <i class="bi bi-person-circle me-1 text-secondary"></i>
                                    <span class="text-truncate">${v.user.fullname}</span>
                                </span>
                                <span class="badge bg-light text-secondary border fw-normal rounded-pill px-2 py-1 flex-shrink-0">
                                    <i class="bi bi-eye me-1 text-primary"></i>
                                    <fmt:formatNumber value="${v.views}" type="number"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Empty state -->
            <c:if test="${empty videos}">
                <div class="col-12">
                    <div class="empty-box text-center py-5 px-3">
                        <div class="bg-white rounded-circle border d-inline-flex align-items-center justify-content-center mb-3 shadow-sm" style="width: 72px; height: 72px;">
                            <i class="bi bi-film fs-2 text-secondary"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-1">Chưa có video nào được đăng tải</h5>
                        <p class="text-muted small mb-4">Hãy là người đầu tiên chia sẻ video lên hệ thống IoTStar.</p>
                        <a href="<c:url value='/admin/video/add'/>" class="btn btn-danger rounded-3 px-4 fw-semibold">
                            <i class="bi bi-plus-lg me-1"></i>Đăng Video Ngay
                        </a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>