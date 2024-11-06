<%@ page import="java.util.List" %>
<%@ page import="service.impl.RoleServiceImpl" %>
<%@ page import="service.impl.WarehouseServiceImpl" %>
<%@ page import="service.impl.DistrictServiceImpl" %>
<%@ page import="entity.*" %>
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
    Cargo cargo = (Cargo) request.getAttribute("old_cargo");
    List<Role> roleList = new RoleServiceImpl().selectAllRole();
    List<Warehouse> warehouseList = new WarehouseServiceImpl().selectAllWarehouse();
    List<District> districtList = new DistrictServiceImpl().selectAllDistrict();
    List<CargoType> cargoTypeList = new CargoTypeServiceImpl().selectAllCargoType();
%>


<div class="form-container">
    <div class="form-content">
        <h1>修改货物</h1>
        <p>请填写以下信息以修改货物</p>
        <form class="input-form" action="cargo?flag=cargo_edit" method="post">
            <input type="text" name="cargo_id" value="<%= cargo.getCargoID() %>" placeholder="ID" readonly>
            <input type="text" name="cargo_name" value="<%= cargo.getCargoName() %>" placeholder="货物名称">
            <input type="number" name="cargo_price" value="<%= cargo.getCargoPrice() %>" placeholder="货物价格">
            <select name="cargo_type">
                <option value="<%= cargo.getCargoTypeID() %>"><%= new CargoTypeServiceImpl().selectById(cargo.getCargoTypeID()).getCargoTypeName() %>
                </option>
                <% for (CargoType cargoType : cargoTypeList) {
                    if (cargoType.getCargoTypeID() != cargo.getCargoTypeID()) {%>
                <option value="<%= cargoType.getCargoTypeID() %>"><%= cargoType.getCargoTypeName() %>
                </option>
                <% }
                } %>
            </select>
            <select name="cargo_warehouseID">
                <option value="<%= cargo.getWarehouseID() %>"><%= new WarehouseServiceImpl().selectById(cargo.getWarehouseID()).getWarehouseName() %>
                </option>
                <% for (Warehouse warehouse : warehouseList) {
                    if (warehouse.getWarehouseID() != cargo.getWarehouseID()) {%>
                <option value="<%= warehouse.getWarehouseID() %>"><%= warehouse.getWarehouseName() %>
                </option>
                <% }
                } %>
            </select>
            <textarea name="cargo_description" id="description" placeholder="请输入描述"></textarea>
            <div class="button-group">
                <button type="submit">修改</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 获取 textarea 元素
    var textarea = document.getElementById('description');

    // 设置 textarea 的新值
    textarea.innerHTML = '<%= cargo.getCargoRemark() %>';
</script>

</body>
</html>
