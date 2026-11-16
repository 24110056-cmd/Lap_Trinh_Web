<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Video - Phân trang</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<c:url value='/home'/>"><i class="bi bi-play-circle-fill text-danger me-2"></i>IoTStar Video</a>
            <div class="d-flex align-items-center">
                <a href="<c:url value='/home'/>" class="btn btn-outline-light btn-sm me-2">Trang chủ</a>
                <c:if test="${not empty sessionScope.account}">
                    <span class="text-white me-3 small">Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                    <a href="<c:url value='/logout'/>" class="btn btn-danger btn-sm">Đăng xuất</a>
                </c:if>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
            <h3 class="fw-bold m-0"><i class="bi bi-collection-play text-primary me-2"></i>Kho Video (Phân trang)</h3>
            <c:if test="${sessionScope.account.roleid == 1}">
                <a href="<c:url value='/admin/video/add'/>" class="btn btn-success btn-sm"><i class="bi bi-plus-lg me-1"></i>Thêm Video mới</a>
            </c:if>
        </div>

        <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
            <c:forEach var="v" items="${videos}">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <img src="<c:url value='/images?fname=${v.poster}'/>" class="card-img-top object-fit-cover" style="height: 180px;" alt="Poster">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-semibold text-truncate" title="${v.title}">
                                <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="text-decoration-none text-dark">${v.title}</a>
                            </h5>
                            <p class="card-text text-muted small flex-grow-1">${v.description}</p>
                            <div class="d-flex justify-content-between align-items-center mt-3 pt-2 border-top">
                                <span class="badge bg-secondary"><i class="bi bi-eye me-1"></i>${v.views} lượt xem</span>
                                <div>
                                    <a href="<c:url value='/video/detail?id=${v.videoId}'/>" class="btn btn-sm btn-primary">Xem</a>
                                    <c:if test="${sessionScope.account.roleid == 1}">
                                        <a href="<c:url value='/admin/video/delete?id=${v.videoId}'/>" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa video này?');">Xóa</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Pagination (Phân trang) -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/video?page=${i}'/>">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
</body>
</html>