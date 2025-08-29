<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title><c:choose><c:when test="${project.id != null}">Sửa</c:when><c:otherwise>Tạo</c:otherwise></c:choose> Dự án</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">

<div class="container mt-4">
    <a class="btn btn-secondary mb-3" href="${pageContext.request.contextPath}/admin">⬅ Quay lại Dashboard</a>

    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white text-center">
            <h4 class="mb-0">
                <c:choose>
                    <c:when test="${project.id != null}">Sửa dự án</c:when>
                    <c:otherwise>Tạo dự án</c:otherwise>
                </c:choose>
            </h4>
        </div>

        <div class="card-body">
            <!-- Thông báo -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <!-- Form -->
<c:set var="formAction">
    ${pageContext.request.contextPath}/admin/projects/create
</c:set>

<form action="${formAction}" method="post" enctype="multipart/form-data">


                <!-- Tên dự án -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Tên dự án</label>
                    <input type="text" name="name" value="${project.name}" class="form-control" required>
                </div>

                <!-- Chủ đầu tư -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Chủ đầu tư</label>
                    <select name="developer.id" class="form-select" required>
                        <c:forEach var="dev" items="${developers}">
                            <option value="${dev.id}" <c:if test="${project.developer != null && project.developer.id == dev.id}">selected</c:if>>
                                ${dev.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Địa chỉ -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Địa chỉ</label>
                    <input type="text" name="address" value="${project.address}" class="form-control" required>
                </div>

                <!-- Tọa độ -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Latitude</label>
                        <input type="text" name="latitude" value="${project.latitude}" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Longitude</label>
                        <input type="text" name="longitude" value="${project.longitude}" class="form-control" required>
                    </div>
                </div>

                <!-- Loại dự án -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Loại dự án</label>
                    <select name="projectType" class="form-select" required>
                        <c:forEach var="type" items="${projectTypes}">
                            <option value="${type}" <c:if test="${project.projectType == type}">selected</c:if>>${type}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Giá -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Giá từ</label>
                        <input type="number" step="100000000" name="priceFrom" value="${project.priceFrom}" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Giá đến</label>
                        <input type="number" step="100000000" name="priceTo" value="${project.priceTo}" class="form-control">
                    </div>
                </div>

                <!-- Diện tích -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Diện tích từ (m²)</label>
                        <input type="text" name="areaFrom" value="${project.areaFrom}" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Diện tích đến (m²)</label>
                        <input type="text" name="areaTo" value="${project.areaTo}" class="form-control" required>
                    </div>
                </div>

                <!-- Trạng thái & Quận/Phường -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Trạng thái</label>
                        <select name="status" class="form-select" required>
                            <c:forEach var="st" items="${projectStatuses}">
                                <option value="${st}" <c:if test="${project.status == st}">selected</c:if>>${st}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Quận/Phường</label>
                        <select name="ward" class="form-select" required>
                            <c:forEach var="w" items="${wards}">
                                <option value="${w}" <c:if test="${project.ward == w}">selected</c:if>>${w}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Thumbnail -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Thumbnail</label>
                    <input type="file" name="thumbnailFile" class="form-control">
                    <c:if test="${not empty project.thumbnail}">
                        <div class="mt-2">
                            <img src="${pageContext.request.contextPath}${project.thumbnail}" alt="Thumbnail" class="img-thumbnail" style="width:120px;height:120px;object-fit:cover;">
                        </div>
                    </c:if>
                </div>

                <!-- Submit -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${project.id != null}">Cập nhật</c:when>
                            <c:otherwise>Tạo dự án</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/projects" class="btn btn-secondary ms-2">Hủy</a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
