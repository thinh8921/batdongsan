<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
    <title>Quản lý Dự án</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body { background-color: #f8f9fa; }
        .table-responsive { border-radius: 12px; overflow: hidden; box-shadow: 0 3px 8px rgba(0,0,0,0.1); }
        .btn-sm { min-width: 70px; }
        .img-thumbnail { border-radius: 8px; }
        .alert { border-radius: 8px; }
        th, td { vertical-align: middle !important; }
    </style>
</head>
<body>
<div class="container my-5">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin">⬅ Quay lại Dashboard</a>
        <h2 class="mb-0">Danh sách Dự án</h2>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/projects/create">Tạo Dự án mới</a>
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

    <!-- Bảng danh sách dự án -->
    <div class="table-responsive bg-white">
        <table class="table table-striped table-bordered mb-0 text-center">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th class="text-start">Tên</th>
                    <th>Chủ đầu tư</th>
                    <th>Loại</th>
                    <th>Giá từ</th>
                    <th>Giá đến</th>
                    <th>Diện tích từ (m2)</th>
                    <th>Diện tích đến (m2)</th>
                    <th>Trạng thái</th>
                    <th>Ảnh</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${projects}">
                    <tr>
                        <td>${p.id}</td>
                        <td class="text-start">${p.name}</td>
                        <td><c:if test="${p.developer != null}">${p.developer.name}</c:if></td>
                        <td>${p.projectType}</td>
                        <td>${p.priceFrom}</td>
                        <td>${p.priceTo}</td>
                        <td>${p.areaFrom}</td>
                        <td>${p.areaTo}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/projects/toggle-status/${p.id}" method="post">
                                <button type="submit" class="btn btn-sm ${p.isActive ? 'btn-success' : 'btn-secondary'}">
                                    ${p.isActive ? 'Hoạt động' : 'Không hoạt động'}
                                </button>
                            </form>
                        </td>
                        <td>
                            <c:if test="${not empty p.thumbnail}">
                                <img src="${p.thumbnail}" alt="Thumbnail" class="img-thumbnail" style="width:80px;height:80px;object-fit:cover;">
                            </c:if>
                        </td>
                        <td>
                            <div class="d-flex justify-content-center gap-1">
                                <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/admin/projects/edit/${p.id}">Sửa</a>
                                <form action="${pageContext.request.contextPath}/admin/projects/delete/${p.id}" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                                    <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                </form>
                            </div>
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
