<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân</title>
    <style>
        body {
            background-color: #f1f5f9;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .profile-card {
            max-width: 680px;
            border-radius: 18px;
            border: 1px solid rgba(15, 23, 42, 0.08);
            background-color: #ffffff;
            overflow: hidden;
        }
        .profile-banner {
            height: 96px;
            background: linear-gradient(135deg, #0d6efd 0%, #1e293b 100%);
        }
        .avatar-wrapper {
            position: relative;
            display: inline-block;
            margin-top: -68px;
        }
        .avatar-preview {
            width: 132px;
            height: 132px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #ffffff;
            background-color: #f8fafc;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.14);
        }
        .avatar-camera-btn {
            position: absolute;
            bottom: 4px;
            right: 4px;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background-color: #0d6efd;
            color: #ffffff;
            border: 2px solid #ffffff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(13, 110, 253, 0.35);
            transition: transform 0.15s ease, background-color 0.2s ease;
        }
        .avatar-camera-btn:hover {
            background-color: #0b5ed7;
            transform: scale(1.06);
        }
        .profile-card .input-group-text {
            background-color: #f8fafc;
            border-color: #e2e8f0;
            color: #64748b;
        }
        .profile-card .form-control {
            border-color: #e2e8f0;
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
        .otp-note-box {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 0.55rem 0.8rem;
            font-size: 0.82rem;
            color: #475569;
        }
    </style>
</head>
<body>
    <div class="container py-4 py-md-5">
        <div class="card profile-card shadow-sm mx-auto">
            <!-- Banner đầu trang -->
            <div class="profile-banner"></div>

            <div class="card-body px-4 px-sm-5 pb-4 pb-sm-5 pt-0">
                <!-- THÔNG BÁO THÀNH CÔNG -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show d-flex align-items-center py-2 px-3 small rounded-3 mt-3 mb-0" role="alert">
                        <i class="bi bi-check-circle-fill me-2 flex-shrink-0"></i>
                        <div><c:out value="${success}"/></div>
                        <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- THÔNG BÁO LỖI -->
                <c:if test="${not empty alert}">
                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center py-2 px-3 small rounded-3 mt-3 mb-0" role="alert">
                        <i class="bi bi-exclamation-circle-fill me-2 flex-shrink-0"></i>
                        <div><c:out value="${alert}"/></div>
                        <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/profile/update"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- ẢNH ĐẠI DIỆN -->
                    <div class="text-center mb-4">
                        <div class="avatar-wrapper">
                            <c:choose>
                                <c:when test="${not empty sessionScope.account.images}">
                                    <img id="previewImg"
                                         src="<c:out value='${sessionScope.account.images}'/>"
                                         alt="Avatar"
                                         class="avatar-preview"
                                         onerror="this.src='https://placehold.co/150x150/e2e8f0/64748b?text=Avatar'">
                                </c:when>
                                <c:otherwise>
                                    <img id="previewImg"
                                         src="https://placehold.co/150x150/e2e8f0/64748b?text=Avatar"
                                         alt="Default Avatar"
                                         class="avatar-preview">
                                </c:otherwise>
                            </c:choose>

                            <label for="imageInput" class="avatar-camera-btn" title="Chọn ảnh đại diện mới">
                                <i class="bi bi-camera-fill"></i>
                            </label>
                            <input type="file"
                                   id="imageInput"
                                   name="image"
                                   accept=".jpg,.jpeg,.png,.webp"
                                   class="d-none"
                                   onchange="previewFile(this)">
                        </div>

                        <h5 class="fw-bold text-dark mt-3 mb-0"><c:out value="${sessionScope.account.fullname}"/></h5>
                        <div class="text-muted small">@<c:out value="${sessionScope.account.username}"/></div>
                        <small class="text-muted d-block mt-1" style="font-size: 0.78rem;">
                            Nhấn biểu tượng máy ảnh để đổi avatar (JPG, PNG, WEBP • tối đa 10MB)
                        </small>
                    </div>

                    <hr class="my-4 text-muted opacity-25">

                    <!-- TÊN ĐĂNG NHẬP -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold small text-secondary">Tên đăng nhập</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-at"></i></span>
                            <input type="text"
                                   class="form-control"
                                   value="<c:out value='${sessionScope.account.username}'/>"
                                   readonly>
                            <span class="input-group-text small text-muted"><i class="bi bi-lock-fill me-1"></i>Cố định</span>
                        </div>
                    </div>

                    <!-- HỌ VÀ TÊN -->
                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-semibold small text-secondary">
                            Họ và tên <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                            <input type="text"
                                   class="form-control"
                                   id="fullname"
                                   name="fullname"
                                   value="<c:out value='${sessionScope.account.fullname}'/>"
                                   minlength="2"
                                   maxlength="255"
                                   required>
                        </div>
                    </div>

                    <!-- SỐ ĐIỆN THOẠI & EMAIL -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-5">
                            <label for="phone" class="form-label fw-semibold small text-secondary">Số điện thoại</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                <input type="tel"
                                       class="form-control"
                                       id="phone"
                                       name="phone"
                                       value="<c:out value='${sessionScope.account.phone}'/>"
                                       pattern="(0[0-9]{9})?"
                                       maxlength="10"
                                       placeholder="Ví dụ: 0912345678">
                            </div>
                            <div class="form-text small">Có thể để trống. Nếu nhập, gồm 10 số và bắt đầu bằng 0.</div>
                        </div>

                        <div class="col-md-7">
                            <label for="email" class="form-label fw-semibold small text-secondary">
                                Email <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email"
                                       class="form-control"
                                       id="email"
                                       name="email"
                                       value="<c:out value='${sessionScope.account.email}'/>"
                                       maxlength="150"
                                       required>
                            </div>
                        </div>
                    </div>

                    <div class="otp-note-box d-flex align-items-start gap-2 mb-4">
                        <i class="bi bi-shield-check text-primary mt-1"></i>
                        <span>Nếu thay đổi sang Email mới, hệ thống sẽ gửi mã <strong>OTP</strong> về Email mới để xác nhận trước khi lưu.</span>
                    </div>

                    <!-- BUTTON -->
                    <div class="d-flex flex-wrap justify-content-end gap-2 pt-2 border-top">
                        <a href="${pageContext.request.contextPath}/home"
                           class="btn btn-light border rounded-3 px-4 py-2 fw-medium">
                            <i class="bi bi-arrow-left me-1"></i>Quay lại
                        </a>
                        <button type="submit" class="btn btn-primary rounded-3 px-4 py-2 fw-semibold shadow-sm">
                            <i class="bi bi-check2-circle me-1"></i>Lưu thay đổi
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- XEM TRƯỚC ẢNH -->
    <script>
    function previewFile(input) {
        if (!input.files || !input.files[0]) {
            return;
        }

        var file = input.files[0];

        var allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/webp"
        ];

        if (!allowedTypes.includes(file.type)) {
            alert("Vui lòng chọn ảnh JPG, PNG hoặc WEBP!");
            input.value = "";
            return;
        }

        if (file.size > 10 * 1024 * 1024) {
            alert("Ảnh không được vượt quá 10MB!");
            input.value = "";
            return;
        }

        var reader = new FileReader();

        reader.onload = function(e) {
            document.getElementById("previewImg").src = e.target.result;
        };

        reader.readAsDataURL(file);
    }
    </script>
</body>
</html>