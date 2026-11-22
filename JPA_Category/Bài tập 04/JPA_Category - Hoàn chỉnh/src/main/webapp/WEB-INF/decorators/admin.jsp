<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="64kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title" default="Quản trị hệ thống"/></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1f5f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .admin-topbar {
            background-color: #0f172a !important;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .admin-brand-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            background-color: rgba(13, 110, 253, 0.16);
            color: #60a5fa;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
        }
        .admin-sidebar {
            background-color: #ffffff;
            border-right: 1px solid #e2e8f0 !important;
        }
        .admin-sidebar .nav-link {
            color: #334155;
            border-radius: 10px;
            padding: 0.6rem 0.85rem;
            font-size: 0.92rem;
            transition: background-color 0.18s ease, color 0.18s ease;
        }
        .admin-sidebar .nav-link:hover {
            background-color: #f1f5f9;
            color: #0d6efd;
        }
        .admin-sidebar .nav-link i {
            color: #64748b;
            transition: color 0.18s ease;
        }
        .admin-sidebar .nav-link:hover i {
            color: #0d6efd;
        }
        .btn-top-action {
            border-radius: 9px;
            padding: 0.38rem 0.75rem;
            font-size: 0.84rem;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <!-- TOP NAVBAR ADMIN -->
    <nav class="navbar navbar-dark admin-topbar px-3 px-md-4 py-2 shadow-sm sticky-top">
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2 m-0" href="${pageContext.request.contextPath}/admin/categories">
            <span class="admin-brand-icon">
                <i class="bi bi-speedometer2"></i>
            </span>
            <span class="fs-6 fs-sm-5">ADMIN DASHBOARD</span>
        </a>
        <div class="d-flex align-items-center gap-2">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-top-action fw-medium">
                <i class="bi bi-box-arrow-up-right me-1"></i>Về trang User
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-top-action fw-semibold">
                <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
            </a>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- SIDEBAR BÊN TRÁI -->
            <nav class="col-md-3 col-lg-2 d-md-block admin-sidebar min-vh-100 p-3">
                <div class="text-uppercase text-muted fw-bold mb-3 px-2" style="font-size: 0.72rem; letter-spacing: 0.06em;">
                    Quản lý nội dung
                </div>
                <ul class="nav flex-column gap-1">
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/admin/categories">
                            <i class="bi bi-folder2-open me-2"></i>Quản lý Danh mục
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/video">
                            <i class="bi bi-film me-2"></i>Quản lý Video
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- NỘI DUNG CHÍNH CỦA ADMIN -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-3 px-md-4 py-4">
                <sitemesh:write property="body"/>
            </main>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>