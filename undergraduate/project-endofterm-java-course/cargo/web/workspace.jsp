<%@ page import="java.util.List" %>
<%@ page import="service.impl.*" %>
<%@ page import="entity.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://kit.fontawesome.com/3b6cde5636.js"></script>
    <script src="assets/js/style.js"></script>
    <script>
        function confirmDelete(src) {
            if (confirm("确定要出库吗？")) {
                location.href = src;
            }
        }
    </script>

</head>
<body>

<%
    // 获取登录信息
    HttpSession loginUserSession = request.getSession();
    Staff loginStaff = (Staff) loginUserSession.getAttribute("loginStaff");
    int role_id = loginStaff.getRoleID();

    if (loginStaff == null) {
        response.sendRedirect("login.jsp");
    } else {
        role_id = loginStaff.getRoleID();
    }
%>


<div class="wrapper">
    <div class="sidebar">
        <div class="bg_shadow">
        </div>
        <div class="sidebar_inner">
            <div class="close">
                <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="profile_info">
                <div class="profile_img">
                    <img src="https://img.zcool.cn/community/01cfd95d145660a8012051cdb52093.png@1280w_1l_2o_100sh.png"
                         alt="">
                </div>
                <div class="profile_data">
                    <p class="name"><%=loginStaff.getStaffName()%>
                    </p>
                    <span class="span-info"><%=loginStaff.getUsername()%></span>
                    <span class="span-info"><i
                            class="fa-solid fa-user"></i><%=new RoleServiceImpl().selectById(loginStaff.getRoleID()).getRoleName()%></span>
                </div>
            </div>

            <ul class="sidebar_menu">
                <li class="active">
                    <a onclick="changeContent('workArea')">
                        <div class="icon"><i class="fa-solid fa-table-columns"></i></div>
                        <div class="title">首页</div>
                    </a>
                </li>

                <% if (role_id == RoleEnum.NATIONAL_ADMIN
                        || role_id == RoleEnum.DISTRICT_ADMIN
                        || role_id == RoleEnum.WAREHOUSE_ADMIN
                        || role_id == RoleEnum.STAFF_ADMIN) {%>
                <li>
                    <a onclick="changeContent('userManagement')">
                        <div class="icon"><i class="fa-solid fa-users"></i></div>
                        <div class="title">用户管理</div>
                    </a>
                </li>
                <%}%>

                <% if (role_id == RoleEnum.NATIONAL_ADMIN
                        || role_id == RoleEnum.DISTRICT_ADMIN
                        || role_id == RoleEnum.WAREHOUSE_ADMIN
                        || role_id == RoleEnum.STAFF_ADMIN
                        || role_id == RoleEnum.REGULAR_STAFF) {%>
                <li>
                    <a onclick="changeContent('cargoManagement')">
                        <div class="icon"><i class="fa-solid fa-box-open"></i></div>
                        <div class="title">货物管理</div>
                    </a>
                </li>
                <%}%>
                <% if (role_id == RoleEnum.NATIONAL_ADMIN
                        || role_id == RoleEnum.DISTRICT_ADMIN
                        || role_id == RoleEnum.WAREHOUSE_ADMIN) {%>
                <li>
                    <a onclick="changeContent('warehouseManagement')">
                        <div class="icon"><i class="fa-solid fa-house-flag"></i></div>
                        <div class="title">仓库管理</div>
                    </a>
                </li>
                <%}%>

                <% if (role_id == RoleEnum.NATIONAL_ADMIN) {%>
                <li>
                    <a onclick="changeContent('districtManagement')">
                        <div class="icon"><i class="fa-solid fa-map"></i></div>
                        <div class="title">片区</div>
                    </a>
                </li>
                <%}%>

            </ul>

            <div class="logout_btn">
                <a href="logout">登出</a>
            </div>

        </div>
    </div>

    <div class="main_container">
        <div class="navbar">
            <div class="hamburger"><i class="fa-solid fa-bars"></i></div>
            <div class="logo">
                <a href="#">货物管理系统</a>
                <small class="version">Beta ver 1.0.0</small>
            </div>

        </div>


        <div class="content" id="workArea">
            <div class="info-container item">
                <div class="info-content">
                    <h2>你好</h2>
                    欢迎回来
                </div>
            </div>
        </div>

        <div class="content" id="userManagement" style="display: none;">
            <%
                List<Staff> staffList = new StaffServiceImpl().selectAllStaff();

                int staff_count = 0;
                for (Staff staff : staffList) {
                    staff_count++;
                }
            %>

            <div class="operation">
                <div class="count">
                    <div class="count-content">
                        <div class="count-line">
                            <label>数量</label>
                            <span>(<%= staff_count %>)</span>
                        </div>
                        <a type="button" class="btn" href='staff_add.jsp'>新增</a>
                    </div>
                </div>

                <p id="search_count" style="padding-left: 20px">0</p>

                <div class="search">
                    <input type="text" id="staffSearchInput" class="search-input" placeholder="搜索...">
                    <button type="button" class="btn" onclick="staffSearch()">搜索重置</button>
                </div>
            </div>

            <% for (Staff staff : staffList) {
                if (staff.getRoleID() > loginStaff.getRoleID()
                        || role_id == RoleEnum.NATIONAL_ADMIN
                        || staff.getWarehouseID() == loginStaff.getWarehouseID()) {
            %>

            <div class="info-container item">
                <div class="info-content">
                    <h2><%= staff.getStaffName() %>
                    </h2>

                    <div class="info-row">
                        <label>用户ID</label>
                        <span><%= staff.getStaffID() %></span>
                    </div>
                    <div class="info-row">
                        <label>用户名</label>
                        <span><%= staff.getUsername() %></span>
                    </div>
                    <div class="info-row">
                        <label>用户权限</label>
                        <span><%= new RoleServiceImpl().selectById(staff.getRoleID()).getRoleName() %></span>
                    </div>
                    <div class="info-row">
                        <label>所在仓库</label>
                        <span><%= new WarehouseServiceImpl().selectById(staff.getWarehouseID()).getWarehouseName() %></span>
                    </div>
                    <div class="info-row">
                        <label>所属片区</label>
                        <span><%= new DistrictServiceImpl().selectById(staff.getDistrictID()).getDistrictName() %></span>
                    </div>
                    <div class="info-row">
                        <label>用户描述</label>
                        <span><%= staff.getStaffRemark() %></span>
                    </div>
                    <div class="button-group">
                        <%--                        <button type="button" onclick="location.href='pages/system-page/500.html'">查看详情</button>--%>
                        <button type="button"
                                onclick="location.href='staff?flag=staff_edit_pre&staff_id=<%= staff.getStaffID() %>'">
                            修改信息
                        </button>
                    </div>
                </div>
            </div>

            <% }
            }%>

        </div>

        <div class="content" id="cargoManagement" style="display: none;">

            <%
                List<Cargo> cargoList = new CargoServiceImpl().selectAllCargo();

                int cargo_count = 0;
                for (Cargo cargo : cargoList) {
                    cargo_count++;
                }
            %>
            <div class="operation">
                <div class="count">
                    <div class="count-content">
                        <div class="count-line">
                            <label>数量</label>
                            <span>(<%= cargo_count %>)</span>
                        </div>
                        <a type="button" class="btn add" href='cargo_add.jsp'>入库</a>
                    </div>
                </div>
                <div class="search">
                    <input type="text" id="cargoSearchInput" class="search-input" placeholder="搜索...">
                    <button type="button" class="btn" onclick="cargoSearch()">搜索重置</button>
                </div>
            </div>

            <% for (Cargo cargo : cargoList) {
                if (cargo.getWarehouseID() == loginStaff.getWarehouseID()
                        || role_id == RoleEnum.NATIONAL_ADMIN) {
            %>
            <div class="info-container item">
                <div class="info-content">
                    <h2><%= cargo.getCargoName() %>
                    </h2>

                    <div class="info-row">
                        <label>货物ID</label>
                        <span><%= cargo.getCargoID() %></span>
                    </div>
                    <div class="info-row">
                        <label>货物价格</label>
                        <span><%= cargo.getCargoPrice() %></span>
                    </div>
                    <div class="info-row">
                        <label>货物类型</label>
                        <span><%= new CargoTypeServiceImpl().selectById(cargo.getCargoTypeID()).getCargoTypeName() %></span>
                    </div>
                    <div class="info-row">
                        <label>所在仓库</label>
                        <span><%= new WarehouseServiceImpl().selectById(cargo.getWarehouseID()).getWarehouseName() %></span>
                    </div>

                    <div class="info-row">
                        <label>货物描述</label>
                        <span><%= cargo.getCargoRemark() %></span>
                    </div>
                    <div class="button-group">
                        <button type="button"
                                onclick="location.href='cargo?flag=cargo_edit_pre&cargo_id=<%= cargo.getCargoID() %>'">
                            修改信息
                        </button>
                        <button type="button"
                                onclick="confirmDelete('cargo?flag=cargo_delete&delete_cargo_id=<%= cargo.getCargoID() %>')">
                            出库
                        </button>
                    </div>
                </div>
            </div>

            <% }
            }%>


        </div>
        <div class="content" id="warehouseManagement" style="display: none;">
            <%
                List<Warehouse> warehouseList = new WarehouseServiceImpl().selectAllWarehouse();

                int warehouse_count = 0;
                for (Warehouse warehouse : warehouseList) {
                    warehouse_count++;
                }
            %>
            <div class="operation">
                <div class="count">
                    <div class="count-content">
                        <div class="count-line">
                            <label>数量</label>
                            <span>(<%= warehouse_count %>)</span>
                        </div>
                        <% if (role_id == RoleEnum.NATIONAL_ADMIN || role_id == RoleEnum.DISTRICT_ADMIN || role_id == RoleEnum.WAREHOUSE_ADMIN) { %>
                        <a type="button" class="btn add" href='warehouse_add.jsp'>新增</a>
                        <% } %>
                    </div>
                </div>

                <div class="search">
                    <input type="text" id="warehouseSearchInput" class="search-input" placeholder="搜索...">
                    <button type="button" class="btn" onclick="warehouseSearch()">搜索重置</button>
                </div>
            </div>

            <% for (Warehouse warehouse : warehouseList) {
                if (warehouse.getDistrictID() == loginStaff.getDistrictID() || role_id == RoleEnum.NATIONAL_ADMIN) {
            %>

            <div class="info-container item">
                <div class="info-content">
                    <h2><%= warehouse.getWarehouseName() %>
                    </h2>

                    <div class="info-row">
                        <label>仓库ID</label>
                        <span><%= warehouse.getWarehouseID() %></span>
                    </div>
                    <div class="info-row">
                        <label>库存数</label>
                        <span><%= new WarehouseServiceImpl().getCargoCount(warehouse.getWarehouseID()) %></span>
                    </div>
                    <div class="info-row">
                        <label>仓库类型</label>
                        <span><%= new WarehouseTypeServiceImpl().selectById(warehouse.getWarehouseType()).getWarehouseTypeName() %></span>
                    </div>
                    <div class="info-row">
                        <label>所在片区</label>
                        <span><%= new DistrictServiceImpl().selectById(warehouse.getDistrictID()).getDistrictName() %></span>
                    </div>
                    <div class="info-row">
                        <label>详细地址</label>
                        <span><%= new WarehouseServiceImpl().selectById(warehouse.getWarehouseID()).getWarehouseLocation() %></span>
                    </div>
                    <div class="info-row">
                        <label>仓库描述</label>
                        <span><%= warehouse.getWarehouseRemark() %></span>
                    </div>
                    <div class="button-group">
                        <%--                        <button type="button" onclick="location.href='pages/system-page/500.html'">查看详情</button>--%>
                        <button type="button"
                                onclick="location.href='warehouse?flag=warehouse_edit_pre&warehouse_id=<%= warehouse.getWarehouseID() %>'">
                            修改信息
                        </button>
                    </div>
                </div>
            </div>

            <% }
            }%>


        </div>


        <div class="content" id="districtManagement" style="display: none;">
            <%
                List<District> districtList = new DistrictServiceImpl().selectAllDistrict();

                int district_count = 0;
                for (District district : districtList) {
                    district_count++;
                }
            %>
            <div class="operation">
                <div class="count">
                    <div class="count-content">
                        <div class="count-line">
                            <label>数量</label>
                            <span>(<%= district_count %>)</span>
                        </div>
                        <%--                        <a type="button" class="btn add" href='#'>新增</a>--%>
                    </div>
                </div>

                <div class="search">
                    <input type="text" id="DistrictSearchInput" class="search-input" placeholder="搜索...">
                    <button type="button" class="btn" onclick="DistrictSearch()">搜索重置</button>
                </div>
            </div>


            <% for (District district : districtList) { %>

            <div class="info-container item">
                <div class="info-content">
                    <h2><%= district.getDistrictName() %>
                    </h2>

                    <div class="info-row">
                        <label>片区ID</label>
                        <span><%= district.getDistrictID() %></span>
                    </div>
                    <div class="info-row">
                        <label>仓库数量</label>
                        <span><%= new DistrictServiceImpl().selectWarehouseCount(district.getDistrictID()) %></span>
                    </div>
                    <div class="info-row">
                        <label>用户数量</label>
                        <span><%= new DistrictServiceImpl().selectStaffCount(district.getDistrictID()) %></span>
                    </div>

                    <%--                    <div class="button-group">--%>
                    <%--                        <button type="button" onclick="location.href='pages/system-page/500.html'">查看详情</button>--%>
                    <%--                        <button type="button"--%>
                    <%--                                onclick="location.href='district?flag=district_edit_pre&district_id=<%= district.getDistrictID() %>'">修改信息--%>
                    <%--                        </button>--%>
                    <%--                    </div>--%>
                </div>
            </div>

            <% } %>

        </div>
    </div>
</div>

</body>
</html>
