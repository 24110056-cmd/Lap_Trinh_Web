<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="64kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title" default="Trang chủ - IotStar"/></title>
    <link href="https://jsdelivr.net" rel="stylesheet">
    <link href="https://jsdelivr.net" rel="stylesheet">
    <sitemesh:write property="head"/>
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- HEADER / NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-play-btn-fill me-1"></i> IOTSTAR VIDEO
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/video">Danh sách Video</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <li class="nav-item">
                                <span class="nav-link text-white">Xin chào, <b>${sessionScope.account.username}</b></span>
                            </li>
                            <c:if test="${sessionScope.account.roleid == 1}">
                                <li class="nav-item">
                                    <a class="btn btn-warning btn-sm mt-1 me-2" href="${pageContext.request.contextPath}/admin/categories">Trang Quản Trị</a>
                                </li>
                            </c:if>
                            <li class="nav-item">
                                <a class="btn btn-outline-light btn-sm mt-1" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="btn btn-light btn-sm me-2" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/register">Đăng ký</a>
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
            <small>&copy; 2026 Bài tập Lập trình Web - Cấu hình SiteMesh Decorator 3 & Bootstrap 5</small>
        </div>
    </footer>

    <script src="https://jsdelivr.net"></script>
</body>
</html>
