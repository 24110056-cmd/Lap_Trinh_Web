<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Top 10 Video Mới Nhất</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<c:url value='/home'/>"><i class="bi bi-play-circle-fill text-danger me-2"></i>IoTStar Video</a>
            <div class="d-flex align-items-center">
                <a href="<c:url value='/video'/>" class="btn btn-outline-light btn-sm me-2">Danh sách Video (Phân trang)</a>
                <c:if test="${not empty sessionScope.account}">
                    <span class="text-white me-3 small">Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                    <a href="<c:url value='/logout'/>" class="btn btn-danger btn-sm">Đăng xuất</a>
                </c:if>
                <c:if test="${empty sessionScope.account}">
                    <a href="<c:url value='/login'/>" class="btn btn-primary btn-sm">Đăng nhập</a>
                </c:if>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-4">
        <h3 class="fw-bold mb-4 border-bottom pb-2"><i class="bi bi-fire text-danger me-2"></i>10 Video Mới Nhất</h3>
        
        <div class="row row-cols-1 row-cols-md-3 row-cols-lg-5 g-4">
            <c:forEach var="v" items="${videos}">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <img src="<c:url value='/images?fname=${v.poster}'/>" class="card-img-top object-fit-cover" style="height: 140px;" alt="Poster">
                        <div class="card-body d-flex flex-column p-3">
                            <h6 class="card-title text-truncate fw-semibold mb-2" title="${v.title}">
                                <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="text-decoration-none text-dark">${v.title}</a>
                            </h6>
                            <p class="card-text text-muted small mb-3 flex-grow-1" style="font-size: 0.85rem;">
                                ${v.description}
                            </p>
                            <div class="d-flex justify-content-between align-items-center text-muted small mt-auto">
                                <span><i class="bi bi-eye me-1"></i>${v.views}</span>
                                <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="btn btn-sm btn-outline-primary py-0 px-2">Xem ngay</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>