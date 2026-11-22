<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
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
            max-width: 420px;
            background: #ffffff;
            border-radius: 20px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            box-shadow: 0 24px 48px rgba(0, 0, 0, 0.35);
        }
        .brand-badge {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            background: rgba(245, 158, 11, 0.14);
            color: #d97706;
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
            padding: 0.62rem 0.85rem;
            font-size: 0.95rem;
        }
        .form-control:focus {
            border-color: #f59e0b;
            box-shadow: 0 0 0 0.2rem rgba(245, 158, 11, 0.18);
        }
        .btn-otp {
            padding: 0.68rem 1rem;
            border-radius: 10px;
            font-size: 0.96rem;
            background-color: #f59e0b;
            border-color: #f59e0b;
            color: #ffffff;
            transition: transform 0.15s ease, box-shadow 0.2s ease, background-color 0.2s ease;
        }
        .btn-otp:hover {
            background-color: #d97706;
            border-color: #d97706;
            color: #ffffff;
            transform: translateY(-1px);
            box-shadow: 0 8px 18px rgba(217, 119, 6, 0.3);
        }
    </style>
</head>
<body>
    <div class="auth-card p-4 p-sm-5">
        <div class="text-center mb-4">
            <div class="brand-badge mb-3">
                <i class="bi bi-key-fill"></i>
            </div>
            <h4 class="fw-bold text-dark mb-1">Quên Mật Khẩu</h4>
            <p class="text-muted small mb-0">Nhập email để nhận mã OTP khôi phục</p>
        </div>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger d-flex align-items-center py-2 px-3 small rounded-3 mb-3" role="alert">
                <i class="bi bi-exclamation-circle-fill me-2 flex-shrink-0"></i>
                <div>${alert}</div>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success d-flex align-items-center py-2 px-3 small rounded-3 mb-3" role="alert">
                <i class="bi bi-check-circle-fill me-2 flex-shrink-0"></i>
                <div>${success}</div>
            </div>
        </c:if>

        <form action="<c:url value='/forgot'/>" method="post" class="needs-validation" novalidate>
            <div class="mb-4">
                <label class="form-label fw-semibold small text-secondary">Email đăng ký</label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                    <input type="email" name="email" value="${param.email}" class="form-control" placeholder="example@gmail.com" required>
                    <div class="invalid-feedback">Vui lòng nhập đúng định dạng email đã đăng ký (vd: ten@gmail.com).</div>
                </div>
            </div>

            <button type="submit" class="btn btn-otp w-100 fw-semibold mb-3">
                <i class="bi bi-send-check me-1"></i>Gửi mã OTP
            </button>
        </form>

        <hr class="my-3 text-muted opacity-25">

        <div class="text-center small text-muted">
            Nhớ lại mật khẩu?
            <a href="<c:url value='/login'/>" class="fw-semibold text-primary text-decoration-none ms-1">Đăng nhập ngay</a>
        </div>
    </div>

    <script>
    (() => {
      'use strict'
      const forms = document.querySelectorAll('.needs-validation')
      Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
          if (!form.checkValidity()) {
            event.preventDefault()
            event.stopPropagation()
          }
          form.classList.add('was-validated')
        }, false)
      })
    })()
    </script>
</body>
</html>