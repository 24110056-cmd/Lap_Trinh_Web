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
        body {
            background: radial-gradient(circle at top, #1e293b 0%, #090d16 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .auth-card {
            width: 100%;
            max-width: 450px;
            background: #ffffff;
            border-radius: 20px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            box-shadow: 0 24px 48px rgba(0, 0, 0, 0.35);
        }
        .brand-badge {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            background: rgba(25, 135, 84, 0.12);
            color: #198754;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        .input-group-text {
            background-color: #f8fafc;
            border-color: #e2e8f0;
            color: #64748b;
        }
        .form-control {
            border-color: #e2e8f0;
            padding: 0.58rem 0.85rem;
            font-size: 0.94rem;
        }
        .form-control:focus {
            border-color: #198754;
            box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.15);
        }
        .btn-toggle-pass {
            border-color: #e2e8f0;
            background-color: #f8fafc;
            color: #64748b;
        }
        .btn-toggle-pass:hover {
            color: #0f172a;
            background-color: #f1f5f9;
        }
        .btn-register {
            padding: 0.68rem 1rem;
            border-radius: 10px;
            font-size: 0.96rem;
            transition: transform 0.15s ease, box-shadow 0.2s ease;
        }
        .btn-register:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 18px rgba(25, 135, 84, 0.28);
        }
    </style>
</head>
<body>
    <div class="auth-card p-4 p-sm-5">
        <div class="text-center mb-4">
            <div class="brand-badge mb-3">
                <i class="bi bi-person-plus-fill"></i>
            </div>
            <h4 class="fw-bold text-dark mb-1">Tạo Tài Khoản</h4>
            <p class="text-muted small mb-0">Đăng ký tài khoản nhận mã OTP kích hoạt</p>
        </div>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger d-flex align-items-center py-2 px-3 small rounded-3 mb-3" role="alert">
                <i class="bi bi-exclamation-circle-fill me-2 flex-shrink-0"></i>
                <div>${alert}</div>
            </div>
        </c:if>

        <form action="<c:url value='/register'/>" method="post" class="needs-validation" novalidate>
            <div class="mb-3">
                <label class="form-label fw-semibold small text-secondary">Họ và tên</label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <input type="text" name="fullname" value="${param.fullname}" class="form-control" placeholder="Nguyễn Văn A" required minlength="2">
                    <div class="invalid-feedback">Vui lòng nhập họ và tên (tối thiểu 2 ký tự).</div>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold small text-secondary">Email nhận OTP</label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                    <input type="email" name="email" value="${param.email}" class="form-control" placeholder="example@gmail.com" required>
                    <div class="invalid-feedback">Vui lòng nhập đúng định dạng email (vd: ten@gmail.com).</div>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold small text-secondary">Tên đăng nhập</label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-at"></i></span>
                    <input type="text" name="username" value="${param.username}" class="form-control" placeholder="Nhập username" required minlength="4">
                    <div class="invalid-feedback">Tên đăng nhập phải có ít nhất 4 ký tự.</div>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold small text-secondary">Mật khẩu</label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required minlength="6">
                    <button class="btn btn-toggle-pass toggle-pass-btn" type="button" data-target="password" aria-label="Hiện hoặc ẩn mật khẩu">
                        <i class="bi bi-eye"></i>
                    </button>
                    <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự.</div>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold small text-secondary">Nhập lại mật khẩu</label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-shield-check"></i></span>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu" required minlength="6">
                    <button class="btn btn-toggle-pass toggle-pass-btn" type="button" data-target="confirmPassword" aria-label="Hiện hoặc ẩn mật khẩu xác nhận">
                        <i class="bi bi-eye"></i>
                    </button>
                    <div class="invalid-feedback">Mật khẩu nhập lại chưa khớp hoặc còn trống.</div>
                </div>
            </div>

            <button type="submit" class="btn btn-success btn-register w-100 fw-semibold mb-3">
                <i class="bi bi-person-check me-1"></i>Đăng ký
            </button>
        </form>

        <hr class="my-3 text-muted opacity-25">

        <div class="text-center small text-muted">
            Đã có tài khoản?
            <a href="<c:url value='/login'/>" class="fw-semibold text-primary text-decoration-none ms-1">Đăng nhập ngay</a>
        </div>
    </div>

    <script>
    (() => {
      'use strict'
      const form = document.querySelector('.needs-validation');
      const password = document.getElementById('password');
      const confirmPassword = document.getElementById('confirmPassword');

      document.querySelectorAll('.toggle-pass-btn').forEach(btn => {
        btn.addEventListener('click', () => {
          const input = document.getElementById(btn.getAttribute('data-target'));
          const icon = btn.querySelector('i');
          if (!input || !icon) return;
          const isPass = input.type === 'password';
          input.type = isPass ? 'text' : 'password';
          icon.classList.toggle('bi-eye', !isPass);
          icon.classList.toggle('bi-eye-slash', isPass);
        });
      });

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