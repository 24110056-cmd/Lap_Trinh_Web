<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .form-card { width: 100%; max-width: 480px; background: #fff; border-radius: 18px; box-shadow: 0 20px 25px rgba(0,0,0,0.3); }
    </style>
</head>
<body>
    <div class="form-card p-4 p-sm-5">
        <h4 class="fw-bold text-center mb-4"><i class="bi bi-pencil-square text-primary me-2"></i>Cập Nhật Danh Mục</h4>

        <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="categoryid" value="${cate.categoryId}">

            <div class="mb-3">
                <label class="form-label fw-semibold">Tên danh mục:</label>
                <input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Link hình ảnh:</label>
                <input type="text" id="images" name="images" value="${cate.images}" class="form-control">
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold d-block">Ảnh hiện tại:</label>
                <c:choose>
                    <c:when test="${not empty cate.images && cate.images.startsWith('https')}">
                        <c:url value="${cate.images}" var="imgUrl"/>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                    </c:otherwise>
                </c:choose>
                <img src="${imgUrl}" height="80" width="100" style="object-fit: cover; border-radius: 8px; border: 1px solid #ddd;"/>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Đổi hình ảnh mới (upload):</label>
                <input type="file" id="images1" name="images1" class="form-control" accept="image/*">
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold d-block">Trạng thái:</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}>
                    <label class="form-check-label" for="ston">Hoạt động</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}>
                    <label class="form-check-label" for="stoff">Khóa</label>
                </div>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary flex-grow-1 fw-semibold">Cập nhật</button>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-light border px-4">Quay lại</a>
            </div>
        </form>
    </div>
</body>
</html>