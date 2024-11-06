<%@ page import="java.util.List" %>
<%@ page import="entity.Role" %>
<%@ page import="service.impl.RoleServiceImpl" %>
<%@ page import="entity.Staff" %>
<%@ page import="entity.Warehouse" %>
<%@ page import="service.impl.WarehouseServiceImpl" %>
<%@ page import="service.impl.DistrictServiceImpl" %>
<%@ page import="entity.District" %>
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
    Staff staff = (Staff) request.getAttribute("old_staff");
    List<Role> roleList = new RoleServiceImpl().selectAllRole();
    List<Warehouse> warehouseList = new WarehouseServiceImpl().selectAllWarehouse();
    List<District> districtList = new DistrictServiceImpl().selectAllDistrict();
%>


<div class="form-container">
    <div class="form-content">
        <h1>修改用户</h1>
        <p>请填写以下信息以修改用户</p>
        <form class="input-form" action="staff?flag=staff_edit" method="post">
            <input type="text" name="staff_id" value="<%= staff.getStaffID() %>" placeholder="ID" readonly>
            <input type="text" name="staff_name" value="<%= staff.getStaffName() %>" placeholder="姓名">
            <input type="text" name="staff_username" value="<%= staff.getUsername() %>" placeholder="用户名">
            <input type="password" name="staff_password" value="<%= staff.getPassword() %>" placeholder="密码">
            <select name="staff_roleId">
                <option value="<%= staff.getRoleID() %>"><%= new RoleServiceImpl().selectById(staff.getRoleID()).getRoleName() %>
                </option>
                <% for (Role role : roleList) {
                    if (role.getRoleID() != staff.getRoleID()) {%>
                <option value="<%= role.getRoleID() %>"><%= role.getRoleName() %>
                </option>
                <% }
                } %>
            </select>
            <select name="staff_warehouseID">
                <option value="<%= staff.getWarehouseID() %>"><%= new WarehouseServiceImpl().selectById(staff.getWarehouseID()).getWarehouseName() %>
                </option>
                <% for (Warehouse warehouse : warehouseList) {
                    if (warehouse.getWarehouseID() != staff.getWarehouseID()) {%>
                <option value="<%= warehouse.getWarehouseID() %>"><%= warehouse.getWarehouseName() %>
                </option>
                <% }
                } %>
            </select>
            <select name="staff_districtID">
                <option value="<%= staff.getDistrictID() %>"><%= new DistrictServiceImpl().selectById(staff.getDistrictID()).getDistrictName() %>
                </option>
                <% for (District district : districtList) {
                    if (district.getDistrictID() != staff.getDistrictID()) { %>
                <option value="<%= district.getDistrictID() %>"><%= district.getDistrictName() %>
                </option>
                <% }
                } %>
            </select>
            <textarea name="staff_description" id="description" placeholder="请输入描述"></textarea>
            <div class="button-group">
                <button type="submit">修改</button>
                <button type="button" onclick="confirmDelete('staff?flag=staff_delete&delete_staff_id=<%= staff.getStaffID() %>')">删除</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 获取 textarea 元素
    var textarea = document.getElementById('description');

    // 设置 textarea 的新值
    textarea.innerHTML = '<%= staff.getStaffRemark() %>';
</script>

</body>
</html>
