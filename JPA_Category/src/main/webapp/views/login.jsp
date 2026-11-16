<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập hệ thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .auth-card { width: 100%; max-width: 420px; background: #fff; border-radius: 18px; box-shadow: 0 20px 25px rgba(0,0,0,0.3); }
    </style>
</head>
<body>
    <div class="auth-card p-4 p-sm-5">
        <h4 class="fw-bold text-center mb-1"><i class="bi bi-shield-lock-fill text-primary me-2"></i>Đăng Nhập</h4>
        <p class="text-muted text-center small mb-4">Hệ thống Quản lý Video & Đăng nhập OTP</p>

        <!-- Hiển thị thông báo lỗi (khớp với biến ${alert} trong Controller) -->
        <c:if test="${not empty alert}">
            <div class="alert alert-danger py-2 text-center small">${alert}</div>
        </c:if>
        
        <!-- Hiển thị thông báo thành công (ví dụ: sau khi đăng ký hoặc kích hoạt OTP thành công) -->
        <c:if test="${not empty success}">
            <div class="alert alert-success py-2 text-center small">${success}</div>
        </c:if>

        <form action="<c:url value='/login'/>" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tên đăng nhập</label>
                <input type="text" name="username" class="form-control" placeholder="Nhập username của bạn" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Mật khẩu</label>
                <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
            </div>
            
            <div class="d-flex justify-content-between align-items-center mb-4 small">
                <a href="<c:url value='/forgot'/>" class="text-decoration-none">Quên mật khẩu?</a>
            </div>

            <button type="submit" class="btn btn-primary w-100 fw-semibold py-2 mb-3">Đăng nhập</button>
        </form>

        <div class="text-center small">
            Chưa có tài khoản? <a href="<c:url value='/register'/>" class="fw-semibold text-decoration-none">Tạo tài khoản mới</a>
        </div>
    </div>
</body>
</html>