<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - IoTStar Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1f5f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .profile-card {
            border-radius: 18px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            background-color: #ffffff;
            overflow: hidden;
        }
        .profile-banner {
            height: 92px;
            background: linear-gradient(135deg, #0d6efd 0%, #1d4ed8 100%);
        }
        .avatar-frame {
            width: 112px;
            height: 112px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #ffffff;
            background-color: #e2e8f0;
            box-shadow: 0 6px 16px rgba(15, 23, 42, 0.14);
        }
        .profile-card .form-control {
            border-color: #e2e8f0;
            border-radius: 10px;
            padding: 0.58rem 0.85rem;
            font-size: 0.94rem;
        }
        .profile-card .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.14);
        }
        .profile-card .form-control[readonly] {
            background-color: #f8fafc;
            color: #64748b;
        }
        .btn-back-profile {
            border-radius: 10px;
            padding: 0.58rem 1.2rem;
        }
        .btn-save-profile {
            border-radius: 10px;
            padding: 0.58rem 1.6rem;
        }
    </style>
</head>
<body>
    <c:set var="acc" value="${sessionScope.account}" />
    <div class="container py-4 py-md-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-9">
                <div class="card profile-card shadow-sm">
                    <div class="profile-banner"></div>

                    <form action="${pageContext.request.contextPath}/profile/update" method="post" enctype="multipart/form-data" class="p-4 p-md-5 pt-0">
                        <div class="row g-4 align-items-start">
                            <!-- Cột Avatar -->
                            <div class="col-md-4 text-center" style="margin-top: -56px;">
                                <div class="d-inline-block position-relative mb-3">
                                    <c:choose>
                                        <c:when test="${not empty acc.images}">
                                            <c:choose>
                                                <c:when test="${acc.images.startsWith('http')}">
                                                    <img src="${acc.images}"
                                                         alt="Avatar"
                                                         class="avatar-frame"
                                                         onerror="this.src='https://placehold.co/200x200/64748b/ffffff?text=Avatar'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/image?fname=${acc.images}"
                                                         alt="Avatar"
                                                         class="avatar-frame"
                                                         onerror="this.src='https://placehold.co/200x200/64748b/ffffff?text=Avatar'">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://placehold.co/200x200/64748b/ffffff?text=Avatar"
                                                 alt="Avatar"
                                                 class="avatar-frame">
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <h5 class="fw-bold text-dark mb-1">${acc.fullname}</h5>
                                <div class="text-muted small mb-3">@${acc.username}</div>

                                <div class="text-start">
                                    <label class="form-label small fw-semibold text-secondary mb-1">Đổi ảnh đại diện</label>
                                    <input type="file" name="image" class="form-control form-control-sm" accept="image/*">
                                    <div class="form-text mt-2" style="font-size: 0.78rem;">
                                        <i class="bi bi-info-circle me-1"></i>JPG, PNG, WEBP • Tối đa 10MB
                                    </div>
                                </div>
                            </div>

                            <!-- Cột Thông tin chi tiết -->
                            <div class="col-md-8 pt-md-3">
                                <h4 class="fw-bold text-dark mb-3">Thông tin cá nhân</h4>

                                <c:if test="${not empty success}">
                                    <div class="alert alert-success alert-dismissible fade show py-2 px-3 small rounded-3 mb-3" role="alert">
                                        <i class="bi bi-check-circle-fill me-1"></i>${success}
                                        <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <c:if test="${not empty alert}">
                                    <div class="alert alert-danger alert-dismissible fade show py-2 px-3 small rounded-3 mb-3" role="alert">
                                        <i class="bi bi-exclamation-triangle-fill me-1"></i>${alert}
                                        <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <div class="mb-3">
                                    <label class="form-label fw-semibold small text-secondary">Tên đăng nhập</label>
                                    <div class="input-group">
                                        <input type="text" value="${acc.username}" class="form-control" readonly>
                                        <span class="input-group-text bg-light text-muted small">Cố định</span>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-semibold small text-secondary">
                                        Họ và tên <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" name="fullname" value="${acc.fullname}" class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-semibold small text-secondary">Số điện thoại</label>
                                    <input type="text" name="phone" value="${acc.phone}" class="form-control" placeholder="0912345678">
                                    <div class="form-text small">10 chữ số, bắt đầu bằng số 0.</div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-semibold small text-secondary">
                                        Email <span class="text-danger">*</span>
                                    </label>
                                    <input type="email" name="email" value="${acc.email}" class="form-control" required>
                                    <div class="form-text small">
                                        <i class="bi bi-shield-check me-1 text-primary"></i>Nếu thay đổi sang Email mới, hệ thống sẽ gửi mã OTP về Email mới để xác nhận trước khi lưu.
                                    </div>
                                </div>

                                <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 pt-3 border-top">
                                    <a href="${pageContext.request.contextPath}/home" class="btn btn-light border btn-back-profile fw-semibold">
                                        <i class="bi bi-arrow-left me-1"></i>Quay lại
                                    </a>
                                    <button type="submit" class="btn btn-primary btn-save-profile fw-semibold shadow-sm">
                                        <i class="bi bi-check2-circle me-1"></i>Lưu thay đổi
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>