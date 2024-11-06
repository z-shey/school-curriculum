package servlet;


import entity.Warehouse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.impl.WarehouseServiceImpl;

import java.io.IOException;

@WebServlet(name = "WarehouseServlet", value = "/warehouse")
public class WarehouseServlet extends HttpServlet {
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
            case "warehouse_add" -> {
                Warehouse warehouse = new Warehouse();
                warehouse.setWarehouseName(req.getParameter("warehouse_name"));
                warehouse.setWarehouseLocation(req.getParameter("warehouse_location"));
                warehouse.setWarehouseType(Integer.valueOf(req.getParameter("warehouse_type")));
                warehouse.setDistrictID(Integer.valueOf(req.getParameter("warehouse_districtID")));

                new WarehouseServiceImpl().insert(warehouse);

                resp.sendRedirect("workspace.jsp");
            }
            case "warehouse_edit_pre" -> {
                String warehouseId = req.getParameter("warehouse_id"); // 获取
                Warehouse warehouse = new WarehouseServiceImpl().selectById(Integer.valueOf(warehouseId));
//
                req.setAttribute("old_warehouse", warehouse);
                req.getRequestDispatcher("warehouse_edit.jsp").forward(req, resp);
            }
            case "warehouse_edit" -> {
                Warehouse warehouse = new Warehouse();

                warehouse.setWarehouseID(Integer.valueOf(req.getParameter("warehouse_id")));
                warehouse.setWarehouseName(req.getParameter("warehouse_name"));
                warehouse.setWarehouseLocation(req.getParameter("warehouse_location"));
                warehouse.setWarehouseType(Integer.valueOf(req.getParameter("warehouse_type")));
                warehouse.setDistrictID(Integer.valueOf(req.getParameter("warehouse_districtID")));
                warehouse.setWarehouseRemark(req.getParameter("warehouse_description"));

                new WarehouseServiceImpl().update(warehouse);

                resp.sendRedirect("workspace.jsp");
            }
            case "warehouse_delete" -> {
                new WarehouseServiceImpl().delete(Integer.valueOf(req.getParameter("delete_warehouse_id")));
                resp.sendRedirect("workspace.jsp");
            }
        }
    }
}
