<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="64kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title" default="Trang chủ - IotStar"/></title>
    <<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1f5f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .user-navbar {
            background-color: #0f172a !important;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .user-navbar .nav-link {
            color: rgba(255, 255, 255, 0.78);
            border-radius: 9px;
            padding: 0.45rem 0.8rem;
            font-size: 0.92rem;
            font-weight: 500;
            transition: background-color 0.18s ease, color 0.18s ease;
        }
        .user-navbar .nav-link:hover,
        .user-navbar .nav-link.active {
            color: #ffffff;
            background-color: rgba(255, 255, 255, 0.09);
        }
        .user-greeting-pill {
            background-color: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 999px;
            padding: 0.35rem 0.8rem;
            font-size: 0.85rem;
            color: #e2e8f0;
        }
        .btn-nav-action {
            border-radius: 9px;
            padding: 0.38rem 0.8rem;
            font-size: 0.85rem;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- HEADER / NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark user-navbar shadow-sm py-2 sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold d-flex align-items-center gap-2 py-1" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-play-circle-fill text-danger fs-4"></i>
                <span>IOTSTAR VIDEO</span>
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto gap-1 my-2 my-lg-0 ms-lg-3">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house-door me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/video">
                            <i class="bi bi-collection-play me-1"></i>Danh sách Video
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav align-items-lg-center gap-2">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <li class="nav-item">
                                <span class="user-greeting-pill d-inline-flex align-items-center">
                                    <i class="bi bi-person-circle text-info me-1"></i>
                                    Xin chào, <b class="ms-1 text-white">${sessionScope.account.username}</b>
                                </span>
                            </li>
                            <c:if test="${sessionScope.account.roleid == 1}">
                                <li class="nav-item">
                                    <a class="btn btn-warning btn-nav-action fw-semibold text-dark" href="${pageContext.request.contextPath}/admin/categories">
                                        <i class="bi bi-speedometer2 me-1"></i>Trang Quản Trị
                                    </a>
                                </li>
                            </c:if>
                            <li class="nav-item">
                                <a class="btn btn-outline-light btn-nav-action fw-medium" href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="btn btn-light btn-nav-action fw-semibold text-dark" href="${pageContext.request.contextPath}/login">
                                    Đăng nhập
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-outline-light btn-nav-action fw-medium" href="${pageContext.request.contextPath}/register">
                                    Đăng ký
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- NỘI DUNG CHÍNH -->
    <main class="container my-4 flex-grow-1">
        <sitemesh:write property="body"/>
    </main>

    <!-- FOOTER -->
    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <div class="container">
            <small class="text-muted">© 2026 Bài tập Lập trình Web - Cấu hình SiteMesh Decorator 3 & Bootstrap 5</small>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>