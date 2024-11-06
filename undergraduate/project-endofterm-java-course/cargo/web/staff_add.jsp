<%@ page import="java.util.List" %>
<%@ page import="entity.Role" %>
<%@ page import="service.impl.RoleServiceImpl" %>
<%@ page import="entity.Warehouse" %>
<%@ page import="service.impl.WarehouseServiceImpl" %>
<%@ page import="entity.District" %>
<%@ page import="service.impl.DistrictServiceImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户信息</title>
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
%>


<div class="form-container">
    <div class="form-content">
        <h1>新增用户</h1>
        <p>请填写以下信息以创建新用户</p>
        <form class="input-form" action="staff?flag=staff_add" method="post">
            <input type="text" name="staff_name" placeholder="姓名">
            <input type="text" name="staff_username" placeholder="用户名">
            <input type="password" name="staff_password" placeholder="密码">
            <select name="staff_roleId">
                <option value="" disabled selected>角色权限</option>
                <% for (Role role : roleList) { %>
                <option value="<%= role.getRoleID() %>"><%= role.getRoleName() %>
                </option>
                <% } %>
            </select>
            <select name="staff_warehouseID">
                <option value="" disabled selected>所在仓库</option>
                <% for (Warehouse warehouse : warehouseList) { %>
                <option value="<%= warehouse.getWarehouseID() %>"><%= warehouse.getWarehouseName() %>
                </option>
                <% } %>
            </select>
            <select name="staff_districtID">
                <option value="" disabled selected>所属片区</option>
                <% for (District district : districtList) { %>
                <option value="<%= district.getDistrictID() %>"><%= district.getDistrictName() %>
                </option>
                <% } %>
            </select>
            <textarea name="staff_description" placeholder="请输入描述"></textarea>
            <button type="submit">新增</button>
        </form>
    </div>
</div>


</body>
</html>
