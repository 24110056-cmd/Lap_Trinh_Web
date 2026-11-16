<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo tài khoản mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .auth-card { width: 100%; max-width: 450px; background: #fff; border-radius: 18px; box-shadow: 0 20px 25px rgba(0,0,0,0.3); }
    </style>
</head>
<body>
    <div class="auth-card p-4 p-sm-5">
        <h4 class="fw-bold text-center mb-1"><i class="bi bi-person-plus-fill text-success me-2"></i>Tạo Tài Khoản</h4>
        <p class="text-muted text-center small mb-4">Đăng ký tài khoản nhận mã OTP kích hoạt</p>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger py-2 text-center small">${alert}</div>
        </c:if>

        <form action="<c:url value='/register'/>" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Họ và tên</label>
                <input type="text" name="fullname" value="${param.fullname}" class="form-control" placeholder="Nguyễn Văn A" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Email nhận OTP</label>
                <input type="email" name="email" value="${param.email}" class="form-control" placeholder="example@gmail.com" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Tên đăng nhập</label>
                <input type="text" name="username" value="${param.username}" class="form-control" placeholder="Nhập username" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Mật khẩu</label>
                <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold">Nhập lại mật khẩu</label>
                <input type="password" name="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu" required>
            </div>
            <button type="submit" class="btn btn-success w-100 fw-semibold py-2 mb-3">Đăng ký</button>
        </form>

        <div class="text-center small">
            Đã có tài khoản? <a href="<c:url value='/login'/>" class="fw-semibold text-decoration-none">Đăng nhập ngay</a>
        </div>
    </div>
</body>
</html>