package servlet;


import entity.Cargo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.impl.CargoServiceImpl;

import java.io.IOException;

// @WebServlet是Java Servlet 3.0规范中的注解，
// 用于将一个类声明为Servlet组件并指定其URL模式。
// 当Web应用程序接收到一个匹配URL模式的请求时，
// 容器会调用该注解指定的Servlet类来处理该请求。
// 这样可以不需要在web.xml文件中显式地配置Servlet组件，
// 而是通过注解的方式来实现Servlet组件的映射和管理。
// 可以减少配置文件的冗余，提高开发效率。
@WebServlet(name = "CargoServlet", value = "/cargo")
public class CargoServlet extends HttpServlet {
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
            case "cargo_add" -> {
                Cargo cargo = new Cargo();
                cargo.setCargoName(req.getParameter("cargo_name"));
                cargo.setCargoPrice(Double.valueOf(req.getParameter("cargo_price")));
                cargo.setCargoTypeID(Integer.valueOf(req.getParameter("cargo_type")));
                cargo.setWarehouseID(Integer.valueOf(req.getParameter("cargo_warehouseID")));
                cargo.setCargoRemark(req.getParameter("cargo_description"));

                new CargoServiceImpl().insert(cargo);

                resp.sendRedirect("workspace.jsp");
            }
            case "cargo_edit_pre" -> {
                String cargoId = req.getParameter("cargo_id"); // 获取
                Cargo cargo = new CargoServiceImpl().selectById(Integer.valueOf(cargoId));

                req.setAttribute("old_cargo", cargo);
                req.getRequestDispatcher("cargo_edit.jsp").forward(req, resp);
            }
            case "cargo_edit" -> {
                Cargo cargo = new Cargo();

                cargo.setCargoID(Integer.valueOf(req.getParameter("cargo_id")));
                cargo.setCargoName(req.getParameter("cargo_name"));
                cargo.setCargoPrice(Double.valueOf(req.getParameter("cargo_price")));
                cargo.setCargoTypeID(Integer.valueOf(req.getParameter("cargo_type")));
                cargo.setWarehouseID(Integer.valueOf(req.getParameter("cargo_warehouseID")));
                cargo.setCargoRemark(req.getParameter("cargo_description"));

                new CargoServiceImpl().update(cargo);

                resp.sendRedirect("workspace.jsp");
            }
            case "cargo_delete" -> {
                new CargoServiceImpl().delete(Integer.valueOf(req.getParameter("delete_cargo_id")));
                resp.sendRedirect("workspace.jsp");
            }
        }
    }
}
