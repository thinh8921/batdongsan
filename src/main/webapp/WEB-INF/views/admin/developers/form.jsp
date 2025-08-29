<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
    <title>${developer.id != null ? "Sửa" : "Tạo"} Chủ đầu tư</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .container { max-width: 700px; }
        h2 { color: #2c3e50; margin-bottom: 30px; }
        .form-control, .form-select, textarea { border-radius: 8px; }
        .btn { min-width: 100px; }
        .logo-preview { width: 80px; height: 80px; object-fit: cover; border-radius: 8px; margin-top: 8px; }
        .alert { border-radius: 8px; }
    </style>
</head>
<body>
<div class="container my-5">

    <a class="btn btn-secondary mb-3" href="${pageContext.request.contextPath}/admin">⬅ Quay lại Dashboard</a>
    <h2 class="text-center">${developer.id != null ? "Sửa" : "Tạo"} Chủ đầu tư</h2>

    <!-- Flash messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Form -->
    <form action="${pageContext.request.contextPath}/admin/developers/${developer.id != null ? 'edit/' + developer.id : 'create'}" 
          method="post" enctype="multipart/form-data">

        <div class="mb-3">
            <label class="form-label">Tên Chủ đầu tư:</label>
            <input type="text" name="name" value="${developer.name}" class="form-control" required/>
        </div>

        <div class="mb-3">
            <label class="form-label">Logo:</label>
            <input type="file" name="logoFile" class="form-control"/>
            <c:if test="${not empty developer.logoUrl}">
                <img src="${pageContext.request.contextPath}${developer.logoUrl}" alt="Logo" class="logo-preview">
            </c:if>
        </div>

        <div class="mb-3">
            <label class="form-label">Mô tả:</label>
            <textarea name="description" class="form-control" rows="4">${developer.description}</textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Điện thoại:</label>
            <input type="text" name="phone" value="${developer.phone}" class="form-control"/>
        </div>

        <div class="mb-3">
            <label class="form-label">Email:</label>
            <input type="email" name="email" value="${developer.email}" class="form-control"/>
        </div>

        <div class="mb-3">
            <label class="form-label">Website:</label>
            <input type="text" name="website" value="${developer.website}" class="form-control"/>
        </div>

        <div class="form-check mb-3">
            <input type="checkbox" name="isActive" class="form-check-input" id="isActive" ${developer.isActive ? 'checked' : ''}/>
            <label class="form-check-label" for="isActive">Hoạt động</label>
        </div>

        <div class="d-flex justify-content-center gap-3">
            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${developer.id != null}">Cập nhật</c:when>
                    <c:otherwise>Tạo mới</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/admin/developers" class="btn btn-secondary">Hủy</a>
        </div>
    </form>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
