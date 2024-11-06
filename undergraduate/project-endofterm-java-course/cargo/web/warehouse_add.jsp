<%@ page import="java.util.List" %>
<%@ page import="entity.Role" %>
<%@ page import="service.impl.RoleServiceImpl" %>
<%@ page import="entity.Warehouse" %>
<%@ page import="service.impl.WarehouseServiceImpl" %>
<%@ page import="entity.District" %>
<%@ page import="service.impl.DistrictServiceImpl" %>
<%@ page import="entity.WarehouseType" %>
<%@ page import="service.impl.WarehouseTypeServiceImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>仓库信息</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://kit.fontawesome.com/3b6cde5636.js"></script>
    <script src="assets/js/style.js"></script>
</head>
<body>
<%
    List<District> districtList = new DistrictServiceImpl().selectAllDistrict();
    List<WarehouseType> warehouseTypeList = new WarehouseTypeServiceImpl().selectAllWarehouseType();
%>


<div class="form-container">
    <div class="form-content">
        <h1>新增仓库</h1>
        <p>请填写以下信息以创建新仓库</p>
        <form class="input-form" action="warehouse?flag=warehouse_add" method="post">
            <input type="text" name="warehouse_name" placeholder="仓库名">
            <input type="text" name="warehouse_location" placeholder="仓库地址">
            <select name="warehouse_type">
                <option value="" disabled selected>仓库类型</option>
                <% for (WarehouseType warehouseType : warehouseTypeList) { %>
                <option value="<%= warehouseType.getWarehouseTypeID() %>"><%= warehouseType.getWarehouseTypeName() %>
                </option>
                <% } %>
            </select>
            <select name="warehouse_districtID">
                <option value="" disabled selected>所属片区</option>
                <% for (District district : districtList) { %>
                <option value="<%= district.getDistrictID() %>"><%= district.getDistrictName() %>
                </option>
                <% } %>
            </select>
            <textarea name="warehouse_description" placeholder="请输入描述"></textarea>
            <button type="submit">新增</button>
        </form>
    </div>
</div>


</body>
</html>
