<%@ page import="java.util.List" %>
<%@ page import="entity.*" %>
<%@ page import="service.impl.*" %>
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
    <script>
        function confirmDelete(src) {
            if (confirm("确定要删除吗？")) {
                location.href = src;
            }
        }
    </script>
</head>
<body>
<%
    Warehouse warehouse = (Warehouse) request.getAttribute("old_warehouse");
    List<Role> roleList = new RoleServiceImpl().selectAllRole();
    List<Warehouse> warehouseList = new WarehouseServiceImpl().selectAllWarehouse();
    List<District> districtList = new DistrictServiceImpl().selectAllDistrict();
    List<CargoType> cargoTypeList = new CargoTypeServiceImpl().selectAllCargoType();
    List<WarehouseType> warehouseTypeList = new WarehouseTypeServiceImpl().selectAllWarehouseType();
%>


<div class="form-container">
    <div class="form-content">
        <h1>修改仓库</h1>
        <p>请填写以下信息以修改仓库</p>
        <form class="input-form" action="warehouse?flag=warehouse_edit" method="post">
            <input type="text" name="warehouse_id" value="<%= warehouse.getWarehouseID() %>" placeholder="ID" readonly>
            <input type="text" name="warehouse_name" value="<%= warehouse.getWarehouseName() %>" placeholder="仓库名称">
            <input type="text" name="warehouse_location" value="<%= warehouse.getWarehouseLocation() %>" placeholder="仓库地址">
            <select name="warehouse_type">
                <option value="<%= warehouse.getWarehouseType() %>"><%= new WarehouseTypeServiceImpl().selectById(warehouse.getWarehouseType()).getWarehouseTypeName() %>
                </option>
                <% for (WarehouseType warehouseType : warehouseTypeList) {
                    if (warehouseType.getWarehouseTypeID() != warehouse.getWarehouseType()) {%>
                <option value="<%= warehouseType.getWarehouseTypeID() %>"><%= warehouseType.getWarehouseTypeName() %>
                </option>
                <% }
                } %>
            </select>
            <select name="warehouse_districtID">
                <option value="<%= warehouse.getDistrictID() %>"><%= new DistrictServiceImpl().selectById(warehouse.getDistrictID()).getDistrictName() %>
                </option>
                <% for (District district : districtList) {
                    if (district.getDistrictID() != warehouse.getDistrictID()) {%>
                <option value="<%= district.getDistrictID() %>"><%= district.getDistrictName() %>
                </option>
                <% }
                } %>
            </select>
            <textarea name="warehouse_description" id="description" placeholder="请输入描述"></textarea>
            <div class="button-group">
                <button type="submit">修改</button>
                <button type="button" onclick="confirmDelete('warehouse?flag=warehouse_delete&delete_warehouse_id=<%= warehouse.getWarehouseID() %>')">删除仓库</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 获取 textarea 元素
    var textarea = document.getElementById('description');

    // 设置 textarea 的新值
    textarea.innerHTML = '<%= warehouse.getWarehouseRemark() %>';
</script>

</body>
</html>
