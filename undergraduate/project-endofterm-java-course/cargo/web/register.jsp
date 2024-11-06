<%@ page import="entity.Role" %>
<%@ page import="entity.Warehouse" %>
<%@ page import="entity.District" %>
<%@ page import="java.util.List" %>
<%@ page import="service.impl.RoleServiceImpl" %>
<%@ page import="service.impl.DistrictServiceImpl" %>
<%@ page import="service.impl.WarehouseServiceImpl" %>
<%@ page import="service.impl.CargoTypeServiceImpl" %>
<%@ page import="entity.CargoType" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="assets/js/style.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://kit.fontawesome.com/3b6cde5636.js"></script>
</head>
<body>

<%--<div class="register-container">--%>
<%--    <div class="register-content">--%>
<%--        <h1>注册</h1>--%>
<%--        <p>静候佳音...</p>--%>
<%--        <form class="login-form" action="main?register=true" method="post">--%>
<%--            <input type="text" name="username" placeholder="用户名">--%>
<%--            <input type="password" name="password" placeholder="密码">--%>
<%--            <button type="submit" class="btn">提交</button>--%>
<%--        </form>--%>
<%--    </div>--%>
<%--</div>--%>

<%
    List<Role> roleList = new RoleServiceImpl().selectAllRole();
    List<Warehouse> warehouseList = new WarehouseServiceImpl().selectAllWarehouse();
    List<District> districtList = new DistrictServiceImpl().selectAllDistrict();
%>


<div class="form-container">
    <div class="form-content">
        <h1>注册用户</h1>
        <p>请填写以下信息以注册新用户</p>
        <form class="input-form" action="main?register=true" method="post">
            <input type="text" placeholder="姓名">
            <input type="text" placeholder="用户名">
            <input type="password" placeholder="密码">
            <select name="staff_warehouseID">
                <option value="" disabled selected>所在仓库</option>
                <% for (Warehouse warehouse : warehouseList) { %>
                <option value="<%= warehouse.getWarehouseID() %>"><%= warehouse.getWarehouseName() %>
                </option>
                <% } %>
            </select>
            <textarea placeholder="请输入描述"></textarea>
            <button type="submit">注册</button>
        </form>
    </div>
</div>

</body>
</html>
