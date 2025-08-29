<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
    <title>${user.id != null ? "Sửa" : "Tạo"} Người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/>
    <style>
        body { background-color: #f8f9fa; }
        .card { border-radius: 12px; }
        .alert { border-radius: 8px; }
        .btn-submit { width: 150px; }
    </style>
</head>
<body>
<div class="container my-5">
    <a class="btn btn-secondary mb-4" href="${pageContext.request.contextPath}/admin">⬅ Quay lại Dashboard</a>

    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white text-center">
            <h4 class="mb-0">${user.id != null ? "Sửa" : "Tạo"} Người dùng</h4>
        </div>

        <div class="card-body">
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

            <!-- Form tạo/sửa user -->
            <form action="${pageContext.request.contextPath}/admin/users/${user.id != null ? 'edit/' + user.id : 'create'}" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold">Username</label>
                    <input type="text" name="username" value="${user.username}" class="form-control" required/>
                </div>

                <c:if test="${user.id == null}">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Password</label>
                        <input type="password" name="password" class="form-control" required/>
                    </div>
                </c:if>

                <div class="mb-3">
                    <label class="form-label fw-bold">Full Name</label>
                    <input type="text" name="fullName" value="${user.fullName}" class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Email</label>
                    <input type="email" name="email" value="${user.email}" class="form-control"/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Phone</label>
                    <input type="text" name="phone" value="${user.phone}" class="form-control"/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Role</label>
                    <select name="role" class="form-select">
                        <c:forEach var="r" items="${userRoles}">
                            <option value="${r}" ${user.role == r ? 'selected' : ''}>${r}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-check mb-4">
                    <input type="checkbox" name="isActive" class="form-check-input" id="isActive" ${user.isActive ? 'checked' : ''}/>
                    <label class="form-check-label fw-bold" for="isActive">Hoạt động</label>
                </div>

                <div class="d-flex justify-content-center gap-3">
                    <button type="submit" class="btn btn-primary btn-submit">
                        <c:choose>
                            <c:when test="${user.id != null}">Cập nhật</c:when>
                            <c:otherwise>Tạo mới</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary btn-submit">Hủy</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
