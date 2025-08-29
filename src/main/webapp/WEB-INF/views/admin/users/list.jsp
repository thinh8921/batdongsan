<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
    <title>Quản lý Người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/>
    <style>
        body { background-color: #f8f9fa; }
        .card { border-radius: 12px; }
        .table th, .table td { vertical-align: middle; }
        .table thead { background-color: #343a40; color: #fff; }
        .actions button, .actions a { margin-right: 5px; }
        .alert { border-radius: 8px; }
        .btn-create { background-color: #198754; color: #fff; }
        .btn-create:hover { background-color: #157347; }
    </style>
</head>
<body>
<div class="container my-5">
    <a class="btn btn-secondary mb-4" href="${pageContext.request.contextPath}/admin">⬅ Quay lại Dashboard</a>

    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">Danh sách Người dùng</h4>
            <a class="btn btn-create" href="${pageContext.request.contextPath}/admin/users/create">
                <i class="bi bi-plus-circle"></i> Tạo Người dùng mới
            </a>
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

            <div class="table-responsive">
                <table class="table table-striped table-hover align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Trạng thái</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.username}</td>
                                <td>${user.fullName}</td>
                                <td>${user.email}</td>
                                <td>${user.phone}</td>
                                <td>${user.role}</td>
                                <td>
                                    <span class="badge <c:choose>
                                        <c:when test='${user.isActive}'>bg-success</c:when>
                                        <c:otherwise>bg-secondary</c:otherwise>
                                    </c:choose>">
                                        <c:choose>
                                            <c:when test="${user.isActive}">Hoạt động</c:when>
                                            <c:otherwise>Không hoạt động</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td class="actions text-center">
<%--                                     <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/admin/users/edit/${user.id}">
                                        <i class="bi bi-pencil-square"></i> Sửa
                                    </a> --%>
                                    <form action="${pageContext.request.contextPath}/admin/users/delete/${user.id}" method="post" style="display:inline;">
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa?');">
                                            <i class="bi bi-trash"></i> Xóa
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty users}">
                            <tr>
                                <td colspan="8" class="text-center text-muted">Chưa có người dùng nào</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS & Icons -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
</body>
</html>
