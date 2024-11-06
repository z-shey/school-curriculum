package servlet;


import dao.impl.RoleDaoImpl;
import entity.Role;
import entity.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.impl.RoleServiceImpl;
import service.impl.StaffServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "MainServlet", value = "/main")
public class MainServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // 注册
        Boolean register = Boolean.valueOf(req.getParameter("register"));
        if (register) {
            req.setAttribute("login_message", "暂不支持个人注册，请联系管理员增加！");
            req.getRequestDispatcher("login.jsp").forward(req, resp); // 转发错误信息
        }

        // 登录信息
        Staff loginStaff = new StaffServiceImpl().login(username, password);

        if (loginStaff != null) {
            HttpSession session = req.getSession();
            session.setAttribute("loginStaff", loginStaff); // 传登录信息

            req.getRequestDispatcher("workspace.jsp").forward(req, resp); // 转发到页面
        } else {
            req.setAttribute("login_message", "用户名或密码错误");
            req.getRequestDispatcher("login.jsp").forward(req, resp); // 转发错误信息
        }


    }
}
