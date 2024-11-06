package edu.cn.kluniv.selection.system.view;

import edu.cn.kluniv.selection.system.dao.*;
import edu.cn.kluniv.selection.system.model.User;
import edu.cn.kluniv.selection.system.util.DBUtil;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginView {
    private JFrame baseFrame;
    private JPanel panel;
    private JLabel labelAccount;
    private JLabel labelPassword;
    private JLabel labelGroupMemberDescription;
    private JTextField txtAccount;
    private JPasswordField txtPassword;
    private JButton buttonLogin;
    private String account;
    private String password;
    private DBUtil dbUtil;
    private UserDao userDao;
    private CourseDao courseDao;
    private StudentDao studentDao;
    private TeacherDao teacherDao;
    private SCDao scDao;
    private ResultSet resultSet;
    private User user;
    private StudentView studentView;
    private TeacherView teacherView;
    private AdministratorView administratorView;

    public LoginView() {
        dbUtil = new DBUtil();
        dbUtil.connect();
        userDao = new UserDao(dbUtil);
        studentDao = new StudentDao(dbUtil);
        teacherDao = new TeacherDao(dbUtil);
        courseDao = new CourseDao(dbUtil);
        scDao = new SCDao(dbUtil);
        initialize();
        events();
    }

    private void events() {
        buttonLogin.addActionListener(e -> {
            account = txtAccount.getText();
            password = String.valueOf(txtPassword.getPassword());

            if (!account.isEmpty() && !password.isEmpty()) {
                try {
                    resultSet = userDao.selectByAccountAndPassword(account, password);

                    if (resultSet.next()) {
                        user = userDao.saveUser(resultSet);

                        switch (user.getRole()) {
                            case BaseDao.USER_ROLE_STUDENT:
                                baseFrame.dispose();
                                studentView = new StudentView(
                                        studentDao.selectById(user.getAccount()),
                                        courseDao.selectAll(BaseDao.USER_ROLE_STUDENT),
                                        scDao.selectById(user.getAccount()),
                                        user.getAccount()
                                );
                                break;
                            case BaseDao.USER_ROLE_TEACHER:
                                baseFrame.dispose();
                                teacherView = new TeacherView(
                                        courseDao.selectAll(BaseDao.USER_ROLE_TEACHER),
                                        scDao.selectByTeaNo(user.getAccount()),
                                        user.getAccount()
                                );
                                break;
                            case BaseDao.USER_ROLE_ADMIN:
                                baseFrame.dispose();
                                administratorView = new AdministratorView(
                                        studentDao.selectAll(BaseDao.USER_ROLE_ADMIN),
                                        teacherDao.selectAll(BaseDao.USER_ROLE_ADMIN),
                                        courseDao.selectAll(BaseDao.USER_ROLE_ADMIN)
                                );
                        }
                    } else {
                        JOptionPane.showMessageDialog(null, "Please input correct username and password");
                    }
                } catch (SQLException e1) {
                    System.out.println(e1.getMessage());
                }
            } else {
                JOptionPane.showMessageDialog(null, "Please input username and password");
            }
        });
    }

    private void initialize() {
        baseFrame = new JFrame();
        baseFrame.setTitle("Login...");
        baseFrame.setBounds(100, 100, 891, 444);
        baseFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        baseFrame.getContentPane().setLayout(null);
        baseFrame.setResizable(false);

        panel = new JPanel();
        panel.setBounds(0, 0, 875, 405);
        panel.setLayout(null);
        baseFrame.getContentPane().add(panel);

        txtAccount = new JTextField();
        txtAccount.setBounds(373, 315, 154, 30);
        panel.add(txtAccount);
        txtAccount.setColumns(10);
        txtAccount.setText(null);

        txtPassword = new JPasswordField();
        txtPassword.setBounds(590, 315, 154, 30);
        txtPassword.setText(null);
        panel.add(txtPassword);

        txtAccount.setText("admin");
        txtPassword.setText("admin");

        labelAccount = new JLabel("Username");
        labelAccount.setBounds(300, 315, 70, 30);
        panel.add(labelAccount);

        labelPassword = new JLabel("Password");
        labelPassword.setBounds(530, 315, 70, 30);
        panel.add(labelPassword);

        buttonLogin = new JButton("login");
        buttonLogin.setBounds(761, 314, 89, 30);
        panel.add(buttonLogin);

        labelGroupMemberDescription = new JLabel("Course selection system by shey.");
        labelGroupMemberDescription.setBounds(10, 346, 840, 48);
        panel.add(labelGroupMemberDescription);

        baseFrame.setVisible(true);
    }

}