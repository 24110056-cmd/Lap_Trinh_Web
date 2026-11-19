<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="64kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title" default="Quản trị hệ thống"/></title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://jsdelivr.net" rel="stylesheet">
    <link href="https://jsdelivr.net" rel="stylesheet">
    <sitemesh:write property="head"/>
</head>
<body>

    <!-- TOP NAVBAR ADMIN -->
    <nav class="navbar navbar-dark bg-dark px-3 shadow">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/categories">
            <i class="bi bi-speedometer2 me-2"></i>ADMIN DASHBOARD
        </a>
        <div class="d-flex align-items-center">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-info btn-sm me-2">Về trang User</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">Đăng xuất</a>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- SIDEBAR BÊN TRÁI -->
            <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar border-end min-vh-100 p-3">
                <h6 class="text-uppercase text-muted fw-bold mb-3">Quản lý nội dung</h6>
                <ul class="nav flex-column gap-2">
                    <li class="nav-item">
                        <a class="nav-link text-dark fw-semibold" href="${pageContext.request.contextPath}/admin/categories">
                            <i class="bi bi-folder2-open me-2"></i>Quản lý Danh mục
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark fw-semibold" href="${pageContext.request.contextPath}/video">
                            <i class="bi bi-film me-2"></i>Quản lý Video
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- NỘI DUNG CHÍNH CỦA ADMIN -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <sitemesh:write property="body"/>
            </main>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://jsdelivr.net"></script>
</body>
</html>
