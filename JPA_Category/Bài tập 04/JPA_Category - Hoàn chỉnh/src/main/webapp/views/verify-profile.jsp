<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận Email</title>
    <style>
        body {
            background-color: #f1f5f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .verify-email-card {
            max-width: 480px;
            border-radius: 18px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            background-color: #ffffff;
        }
        .verify-icon-box {
            width: 54px;
            height: 54px;
            border-radius: 14px;
            background-color: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.55rem;
        }
        .otp-code-input {
            border-color: #cbd5e1;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 1.35rem;
            font-weight: 700;
            letter-spacing: 0.45em;
            background-color: #f8fafc;
            transition: border-color 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease;
        }
        .otp-code-input:focus {
            background-color: #ffffff;
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.22rem rgba(13, 110, 253, 0.15);
        }
        .otp-code-input::placeholder {
            font-size: 0.95rem;
            font-weight: 500;
            letter-spacing: normal;
            color: #94a3b8;
        }
        .btn-verify-mail {
            border-radius: 10px;
            padding: 0.65rem 1rem;
        }
        .btn-back-profile {
            border-radius: 10px;
            padding: 0.6rem 1rem;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="card verify-email-card shadow-sm mx-auto">
            <div class="card-body p-4 p-sm-5">
                <div class="text-center mb-4">
                    <div class="verify-icon-box mb-3">
                        <i class="bi bi-envelope-check-fill"></i>
                    </div>
                    <h4 class="fw-bold text-dark mb-1">Xác nhận Email mới</h4>
                    <p class="text-muted small mb-0">
                        Hệ thống đã gửi mã OTP gồm 6 chữ số đến email mới của bạn. Vui lòng kiểm tra hộp thư và nhập mã để hoàn tất.
                    </p>
                </div>

                <c:if test="${not empty alert}">
                    <div class="alert alert-danger d-flex align-items-center py-2 px-3 small rounded-3 mb-3" role="alert">
                        <i class="bi bi-exclamation-circle-fill me-2 flex-shrink-0"></i>
                        <div><c:out value="${alert}"/></div>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success d-flex align-items-center py-2 px-3 small rounded-3 mb-3" role="alert">
                        <i class="bi bi-check-circle-fill me-2 flex-shrink-0"></i>
                        <div><c:out value="${success}"/></div>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/profile/verify-email"
                      method="post">

                    <div class="mb-4">
                        <label for="otp" class="form-label fw-semibold small text-secondary text-center d-block mb-2">
                            Mã OTP xác nhận (6 số)
                        </label>
                        <input type="text"
                               class="form-control otp-code-input text-center"
                               id="otp"
                               name="otp"
                               placeholder="Nhập mã OTP"
                               inputmode="numeric"
                               pattern="[0-9]{6}"
                               maxlength="6"
                               minlength="6"
                               autocomplete="one-time-code"
                               required>
                        <div class="form-text text-center small text-muted mt-2">
                            Mã OTP chỉ gồm 6 chữ số.
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary btn-verify-mail fw-semibold shadow-sm">
                            <i class="bi bi-shield-check me-1"></i>Xác nhận Email
                        </button>

                        <a href="${pageContext.request.contextPath}/profile"
                           class="btn btn-light btn-back-profile border fw-medium text-secondary">
                            <i class="bi bi-arrow-left me-1"></i>Quay lại hồ sơ
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>