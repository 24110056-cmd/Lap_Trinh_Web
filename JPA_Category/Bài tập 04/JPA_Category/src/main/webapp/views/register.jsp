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

        <form action="<c:url value='/register'/>" method="post" class="needs-validation" novalidate>
            <div class="mb-3">
                <label class="form-label fw-semibold">Họ và tên</label>
                <input type="text" name="fullname" value="${param.fullname}" class="form-control" placeholder="Nguyễn Văn A" required minlength="2">
                <div class="invalid-feedback">Vui lòng nhập họ và tên (tối thiểu 2 ký tự).</div>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Email nhận OTP</label>
                <input type="email" name="email" value="${param.email}" class="form-control" placeholder="example@gmail.com" required>
                <div class="invalid-feedback">Vui lòng nhập đúng định dạng email (vd: ten@gmail.com).</div>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Tên đăng nhập</label>
                <input type="text" name="username" value="${param.username}" class="form-control" placeholder="Nhập username" required minlength="4">
                <div class="invalid-feedback">Tên đăng nhập phải có ít nhất 4 ký tự.</div>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Mật khẩu</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required minlength="6">
                <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự.</div>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold">Nhập lại mật khẩu</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu" required minlength="6">
                <div class="invalid-feedback">Mật khẩu nhập lại chưa khớp hoặc còn trống.</div>
            </div>
            <button type="submit" class="btn btn-success w-100 fw-semibold py-2 mb-3">Đăng ký</button>
        </form>

        <div class="text-center small">
            Đã có tài khoản? <a href="<c:url value='/login'/>" class="fw-semibold text-decoration-none">Đăng nhập ngay</a>
        </div>
    </div>

    <script>
    (() => {
      'use strict'
      const form = document.querySelector('.needs-validation');
      const password = document.getElementById('password');
      const confirmPassword = document.getElementById('confirmPassword');

      const validateConfirmPassword = () => {
        if (confirmPassword.value !== password.value) {
          confirmPassword.setCustomValidity('Mật khẩu nhập lại không khớp');
        } else {
          confirmPassword.setCustomValidity('');
        }
      };

      password.addEventListener('input', validateConfirmPassword);
      confirmPassword.addEventListener('input', validateConfirmPassword);

      form.addEventListener('submit', event => {
        validateConfirmPassword();
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    })()
    </script>
</body>
</html>
