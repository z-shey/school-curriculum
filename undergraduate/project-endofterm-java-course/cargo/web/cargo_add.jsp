<%@ page import="java.util.List" %>
<%@ page import="entity.Role" %>
<%@ page import="service.impl.RoleServiceImpl" %>
<%@ page import="entity.Warehouse" %>
<%@ page import="service.impl.WarehouseServiceImpl" %>
<%@ page import="entity.District" %>
<%@ page import="service.impl.DistrictServiceImpl" %>
<%@ page import="entity.CargoType" %>
<%@ page import="service.impl.CargoTypeServiceImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>货物信息</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://kit.fontawesome.com/3b6cde5636.js"></script>
    <script src="assets/js/style.js"></script>
</head>
<body>
<%
    List<Role> roleList = new RoleServiceImpl().selectAllRole();
    List<Warehouse> warehouseList = new WarehouseServiceImpl().selectAllWarehouse();
    List<District> districtList = new DistrictServiceImpl().selectAllDistrict();
    List<CargoType> cargoTypeList = new CargoTypeServiceImpl().selectAllCargoType();
%>


<div class="form-container">
    <div class="form-content">
        <h1>新增货物</h1>
        <p>请填写以下信息以创建新用户</p>
        <form class="input-form" action="cargo?flag=cargo_add" method="post">
            <input type="text" name="cargo_name" placeholder="货物名称">
            <input type="number" name="cargo_price" placeholder="货物价格">
            <select name="cargo_type">
                <option value="" disabled selected>货物类型</option>
                <% for (CargoType cargoType : cargoTypeList) { %>
                <option value="<%= cargoType.getCargoTypeID() %>"><%= cargoType.getCargoTypeName() %>
                </option>
                <% } %>
            </select>
            <select name="cargo_warehouseID">
                <option value="" disabled selected>所在仓库</option>
                <% for (Warehouse warehouse : warehouseList) { %>
                <option value="<%= warehouse.getWarehouseID() %>"><%= warehouse.getWarehouseName() %>
                </option>
                <% } %>
            </select>
            <textarea name="cargo_description" placeholder="请输入描述"></textarea>
            <button type="submit">新增</button>
        </form>
    </div>
</div>


</body>
</html>
