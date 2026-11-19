<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="64kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Trang chủ - IoTStar Video</title>
    <style>
        .video-card {
            transition: all 0.25s cubic-bezier(0.25, 0.8, 0.25, 1);
            background-color: #fff;
        }
        .video-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1) !important;
        }
        .thumbnail-wrapper {
            position: relative;
            overflow: hidden;
            background-color: #000;
        }
        .thumbnail-wrapper img {
            transition: transform 0.35s ease, opacity 0.35s ease;
            object-fit: cover;
        }
        .video-card:hover .thumbnail-wrapper img {
            transform: scale(1.06);
            opacity: 0.85;
        }
        /* Nút Play hiện ra khi hover */
        .play-overlay {
            position: absolute;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(0, 0, 0, 0.2);
            opacity: 0;
            transition: opacity 0.25s ease;
        }
        .video-card:hover .play-overlay {
            opacity: 1;
        }
        .play-icon-circle {
            width: 48px;
            height: 48px;
            background: rgba(220, 53, 69, 0.92);
            color: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            transform: scale(0.85);
            transition: transform 0.25s ease;
        }
        .video-card:hover .play-icon-circle {
            transform: scale(1);
        }
        .video-title {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.4;
            height: 2.8em;
            transition: color 0.2s;
        }
        .video-card:hover .video-title {
            color: #dc3545 !important;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-4">
        <!-- Header Section -->
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4 pb-3 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1 d-flex align-items-center">
                    <span class="bg-danger bg-opacity-10 text-danger rounded-3 p-2 me-2 d-inline-flex">
                        <i class="bi bi-fire"></i>
                    </span>
                    10 Video Mới Nhất
                </h3>
                <p class="text-muted small mb-0">Khám phá những nội dung mới được cập nhật trên IoTStar</p>
            </div>
            <a href="<c:url value='/admin/video/add'/>" class="btn btn-danger rounded-pill px-4 py-2 fw-semibold shadow-sm">
                <i class="bi bi-cloud-arrow-up me-2"></i>Đăng Video Mới
            </a>
        </div>

        <!-- Video Grid -->
        <div class="row g-4">
            <c:forEach items="${videos}" var="v">
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="card video-card h-100 border-0 rounded-4 shadow-sm overflow-hidden">
                        <!-- Thumbnail tỷ lệ chuẩn 16:9 -->
                        <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="thumbnail-wrapper ratio ratio-16x9">
                            <img src="<c:url value='/image?fname=${v.poster}'/>" 
                                 alt="${v.title}"
                                 onerror="this.src='https://placehold.co/600x400/212529/FFF?text=IoTStar+Video'">
                            <div class="play-overlay">
                                <div class="play-icon-circle">
                                    <i class="bi bi-play-fill ms-1"></i>
                                </div>
                            </div>
                        </a>

                        <!-- Nội dung Card -->
                        <div class="card-body d-flex flex-column p-3">
                            <h6 class="card-title mb-2">
                                <a href="<c:url value='/video/detail?id=${v.videoId}'/>" 
                                   class="text-decoration-none text-dark fw-bold video-title" 
                                   title="${v.title}">
                                    ${v.title}
                                </a>
                            </h6>

                            <!-- Thông tin tác giả & Lượt xem -->
                            <div class="mt-auto pt-2 border-top border-light-subtle d-flex align-items-center justify-content-between text-muted small">
                                <span class="d-flex align-items-center text-truncate me-2" style="max-width: 55%;" title="${v.user.fullname}">
                                    <i class="bi bi-person-circle text-secondary me-1 fs-6"></i>
                                    <span class="text-truncate">${v.user.fullname}</span>
                                </span>
                                <span class="badge bg-light text-secondary border fw-normal rounded-pill px-2 py-1">
                                    <i class="bi bi-eye-fill text-primary me-1"></i>
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
                    <div class="text-center py-5 my-4 bg-white rounded-4 shadow-sm border border-dashed">
                        <div class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 80px; height: 80px;">
                            <i class="bi bi-camera-reels display-5 text-secondary"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Chưa có video nào được đăng tải</h5>
                        <p class="text-muted mb-4">Hãy là người đầu tiên chia sẻ video lên hệ thống IoTStar!</p>
                        <a href="<c:url value='/admin/video/add'/>" class="btn btn-outline-danger rounded-pill px-4">
                            <i class="bi bi-plus-lg me-1"></i>Tải video lên ngay
                        </a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>