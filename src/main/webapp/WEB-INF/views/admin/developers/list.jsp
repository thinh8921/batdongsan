<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
    <title>Quản lý Chủ đầu tư</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f8f9fa; }
        h2 { text-align: center; margin-bottom: 25px; color: #2c3e50; }
        .logo { width: 60px; height: 60px; object-fit: cover; border-radius: 8px; }
        .table-responsive { border-radius: 12px; overflow: hidden; box-shadow: 0 3px 10px rgba(0,0,0,0.1); }
        .btn-sm { min-width: 70px; }
        .alert { border-radius: 8px; }
        th, td { vertical-align: middle !important; text-align: center; }
        td.text-start { text-align: left; }
        tr:hover { background-color: #f1f1f1; }
        .actions { display: flex; justify-content: center; gap: 5px; }
    </style>
</head>
<body>
<div class="container my-5">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin">⬅ Quay lại Dashboard</a>
        <h2>Danh sách Chủ đầu tư</h2>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/developers/create">Tạo Chủ đầu tư mới</a>
    </div>

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

    <!-- Table developers -->
    <div class="table-responsive bg-white">
        <table class="table table-striped table-bordered mb-0 align-middle">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th class="text-start">Tên Chủ đầu tư</th>
                <th>Email</th>
                <th>Website</th>
                <th>Logo</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="dev" items="${developers}">
                <tr>
                    <td>${dev.id}</td>
                    <td class="text-start">${dev.name}</td>
                    <td>${dev.email}</td>
                    <td>
                        <c:if test="${not empty dev.website}">
                            <a href="${dev.website}" target="_blank">${dev.website}</a>
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty dev.logoUrl}">
                                <img class="logo" src="${pageContext.request.contextPath}${dev.logoUrl}" alt="Logo"/>
                            </c:when>
                            <c:otherwise>
                                <img class="logo" src="${pageContext.request.contextPath}/images/default-logo.png" alt="Logo"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${dev.isActive}">Hoạt động</c:when>
                            <c:otherwise>Không hoạt động</c:otherwise>
                        </c:choose>
                    </td>
                    <td class="actions">
<%--                         <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/admin/developers/edit/${dev.id}">Sửa</a> --%>
                        <form action="${pageContext.request.contextPath}/admin/developers/delete/${dev.id}" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                            <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
