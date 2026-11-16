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
        body { background-color: #f1f5f9; font-family: 'Segoe UI', sans-serif; padding: 30px 15px; }
        .main-card { max-width: 1050px; margin: 0 auto; border-radius: 16px; border: 1px solid #e2e8f0; background: #fff; box-shadow: 0 4px 12px rgba(0,0,0,0.05); overflow: hidden; }
        .cate-img { width: 65px; height: 50px; object-fit: cover; border-radius: 8px; border: 1px solid #e2e8f0; }
    </style>
</head>
<body>
    <div class="main-card">
        <div class="p-4 border-bottom d-flex justify-content-between align-items-center">
            <div>
                <h4 class="fw-bold m-0"><i class="bi bi-grid-fill text-primary me-2"></i>Danh Sách Danh Mục (JPA)</h4>
                <small class="text-muted">Quản lý CRUD Category với JPA 3.0 & Jakarta EE 6.0</small>
            </div>
            <div class="d-flex align-items-center gap-2">
                <span class="text-muted small me-2">Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                <a href="<c:url value='/admin/category/add'/>" class="btn btn-success fw-semibold">
                    <i class="bi bi-plus-lg me-1"></i> Thêm danh mục
                </a>
                <a href="<c:url value='/logout'/>" class="btn btn-outline-danger fw-semibold">
                    <i class="bi bi-box-arrow-right"></i> Thoát
                </a>
            </div>
        </div>

        <div class="p-4">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center" style="width: 70px;">STT</th>
                            <th style="width: 110px;">Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th class="text-center">Trạng thái</th>
                            <th class="text-center" style="width: 180px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listcate}" var="cate" varStatus="STT">
                            <tr>
                                <td class="text-center fw-semibold">${STT.index + 1}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty cate.images && cate.images.startsWith('https')}">
                                            <c:url value="${cate.images}" var="imgUrl"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${imgUrl}" class="cate-img" alt="Icon" onerror="this.src='https://placehold.co/65x50?text=No+Img'"/>
                                </td>
                                <td class="fw-semibold text-dark">${cate.categoryname}</td>
                                <td class="text-center">
                                    <c:if test="${cate.status == 1}">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1 rounded-pill">Hoạt động</span>
                                    </c:if>
                                    <c:if test="${cate.status != 1}">
                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-1 rounded-pill">Khóa</span>
                                    </c:if>
                                </td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>" class="btn btn-sm btn-outline-primary me-1">
                                        <i class="bi bi-pencil-square"></i> Sửa
                                    </a>
                                    <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>" class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Bạn có chắc muốn xóa danh mục này không?');">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>