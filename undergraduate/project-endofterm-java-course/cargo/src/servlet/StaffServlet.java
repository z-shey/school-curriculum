package servlet;

import entity.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.impl.StaffServiceImpl;

import java.io.IOException;

@WebServlet(name = "StaffServlet", value = "/staff")
public class StaffServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");

        String flag = req.getParameter("flag"); // 前端获取操作类型


        switch (flag) {
            case "staff_add" -> {
                Staff staff = new Staff();
                staff.setStaffName(req.getParameter("staff_name"));
                staff.setUsername(req.getParameter("staff_username"));
                staff.setPassword(req.getParameter("staff_password"));
                staff.setRoleID(Integer.valueOf(req.getParameter("staff_roleId")));
                staff.setWarehouseID(Integer.valueOf(req.getParameter("staff_warehouseID")));
                staff.setDistrictID(Integer.valueOf(req.getParameter("staff_districtID")));
                staff.setStaffRemark(req.getParameter("staff_description"));

                new StaffServiceImpl().insert(staff);

//                resp.sendRedirect("/pages/system-page/success.html");
                resp.sendRedirect("workspace.jsp");

            }
            case "staff_edit_pre" -> {
                String staffId = req.getParameter("staff_id"); // 获取
                Staff staff = new StaffServiceImpl().selectById(Integer.valueOf(staffId));

                req.setAttribute("old_staff", staff);
                req.getRequestDispatcher("staff_edit.jsp").forward(req, resp);
            }
            case "staff_edit" -> {
                Staff staff = new Staff();

                staff.setStaffID(Integer.valueOf(req.getParameter("staff_id")));
                staff.setStaffName(req.getParameter("staff_name"));
                staff.setUsername(req.getParameter("staff_username"));
                staff.setPassword(req.getParameter("staff_password"));
                staff.setRoleID(Integer.valueOf(req.getParameter("staff_roleId")));
                staff.setWarehouseID(Integer.valueOf(req.getParameter("staff_warehouseID")));
                staff.setDistrictID(Integer.valueOf(req.getParameter("staff_districtID")));
                staff.setStaffRemark(req.getParameter("staff_description"));

                new StaffServiceImpl().update(staff);

//                resp.sendRedirect("/pages/system-page/success.html");
                resp.sendRedirect("workspace.jsp");

            }
            case "staff_delete" -> {
                new StaffServiceImpl().delete(Integer.valueOf(req.getParameter("delete_staff_id")));
//                resp.sendRedirect("/pages/system-page/success.html");
                resp.sendRedirect("workspace.jsp");
            }
        }
    }
}
