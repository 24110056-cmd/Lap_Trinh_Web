<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục (JPA)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f1f5f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
            padding: 32px 15px;
        }
        .main-card {
            max-width: 1080px;
            margin: 0 auto;
            border-radius: 20px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            background: #ffffff;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06);
            overflow: hidden;
        }
        .header-icon-box {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            background-color: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
        }
        .user-pill {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 999px;
            padding: 0.38rem 0.85rem;
            font-size: 0.85rem;
            color: #334155;
        }
        .cate-img {
            width: 72px;
            height: 50px;
            object-fit: cover;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            background-color: #f8fafc;
            transition: transform 0.2s ease;
        }
        .cate-img:hover {
            transform: scale(1.06);
        }
        .table thead th {
            background-color: #f8fafc;
            color: #475569;
            font-size: 0.82rem;
            text-transform: uppercase;
            letter-spacing: 0.03em;
            border-bottom-width: 1px;
            padding-top: 0.85rem;
            padding-bottom: 0.85rem;
        }
        .table tbody td {
            padding-top: 0.85rem;
            padding-bottom: 0.85rem;
            border-color: #f1f5f9;
        }
        .table-hover tbody tr:hover {
            background-color: #f8fafc;
        }
        .btn-action {
            border-radius: 8px;
            padding: 0.35rem 0.65rem;
            font-size: 0.82rem;
        }
    </style>
</head>
<body>
    <div class="main-card">
        <div class="p-4 border-bottom d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="header-icon-box">
                    <i class="bi bi-grid-fill"></i>
                </div>
                <div>
                    <h4 class="fw-bold text-dark m-0">Danh Sách Danh Mục (JPA)</h4>
                    <small class="text-muted">Quản lý CRUD Category với JPA 3.0 & Jakarta EE 6.0</small>
                </div>
            </div>

            <div class="d-flex flex-wrap align-items-center gap-2">
                <span class="user-pill">
                    <i class="bi bi-person-circle text-primary me-1"></i>
                    Xin chào, <strong>${sessionScope.account.fullname}</strong>
                </span>
                <a href="<c:url value='/admin/category/add'/>" class="btn btn-success rounded-3 px-3 py-2 fw-semibold shadow-sm">
                    <i class="bi bi-plus-lg me-1"></i> Thêm danh mục
                </a>
                <a href="<c:url value='/logout'/>" class="btn btn-outline-danger rounded-3 px-3 py-2 fw-semibold">
                    <i class="bi bi-box-arrow-right me-1"></i> Thoát
                </a>
            </div>
        </div>

        <div class="p-4">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="text-center" style="width: 72px;">STT</th>
                            <th style="width: 110px;">Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th class="text-center" style="width: 150px;">Trạng thái</th>
                            <th class="text-center" style="width: 185px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listcate}" var="cate" varStatus="STT">
                            <tr>
                                <td class="text-center fw-semibold text-secondary">${STT.index + 1}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty cate.images && cate.images.startsWith('https')}">
                                            <c:url value="${cate.images}" var="imgUrl"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${imgUrl}" class="cate-img" alt="${cate.categoryname}" onerror="this.src='https://placehold.co/72x50/e2e8f0/64748b?text=No+Img'"/>
                                </td>
                                <td class="fw-semibold text-dark">${cate.categoryname}</td>
                                <td class="text-center">
                                    <c:if test="${cate.status == 1}">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-2 rounded-pill fw-medium">
                                            <i class="bi bi-check-circle-fill me-1"></i>Hoạt động
                                        </span>
                                    </c:if>
                                    <c:if test="${cate.status != 1}">
                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-2 rounded-pill fw-medium">
                                            <i class="bi bi-lock-fill me-1"></i>Khóa
                                        </span>
                                    </c:if>
                                </td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>" class="btn btn-outline-primary btn-action me-1" title="Sửa danh mục">
                                        <i class="bi bi-pencil-square me-1"></i>Sửa
                                    </a>
                                    <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>" class="btn btn-outline-danger btn-action" title="Xóa danh mục"
                                       onclick="return confirm('Bạn có chắc muốn xóa danh mục này không?');">
                                        <i class="bi bi-trash me-1"></i>Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty listcate}">
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class="bi bi-folder-x fs-2 d-block mb-2"></i>
                                    Chưa có danh mục nào trong hệ thống.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>