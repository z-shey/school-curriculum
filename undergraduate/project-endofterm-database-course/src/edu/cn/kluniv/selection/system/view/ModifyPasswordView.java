package edu.cn.kluniv.selection.system.view;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ModifyPasswordView extends JFrame {
    private JTextField txtOldPassword;
    private JTextField txtNewPassword;
    private JTextField txtConfirmPassword;
    private JButton btnModify;
    private JLabel lblMessage;
    private String account;

    public ModifyPasswordView(String account) {
        this.account = account;
        initialize();
        addComponents();
        addListeners();
        pack();
    }

    private void initialize() {
        setTitle("Modify Password");
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setResizable(false);
        setLocationRelativeTo(null);
        setLayout(new GridLayout(4, 2, 10, 10));
    }

    private void addComponents() {
        JLabel lblOldPassword = new JLabel("Old Password:");
        txtOldPassword = new JTextField();
        JLabel lblNewPassword = new JLabel("New Password:");
        txtNewPassword = new JTextField();
        JLabel lblConfirmPassword = new JLabel("Confirm Password:");
        txtConfirmPassword = new JTextField();
        btnModify = new JButton("Modify");
        lblMessage = new JLabel();

        add(lblOldPassword);
        add(txtOldPassword);
        add(lblNewPassword);
        add(txtNewPassword);
        add(lblConfirmPassword);
        add(txtConfirmPassword);
        add(btnModify);
        add(lblMessage);
    }

    private void addListeners() {
        btnModify.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String oldPassword = txtOldPassword.getText();
                String newPassword = txtNewPassword.getText();
                String confirmPassword = txtConfirmPassword.getText();

                if (oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                    lblMessage.setText("Please fill in all fields.");
                    return;
                }

                if (!newPassword.equals(confirmPassword)) {
                    lblMessage.setText("New password and confirm password do not match.");
                    return;
                }

                // TODO: Perform password modification logic here

                lblMessage.setText("Password modified successfully.");
            }
        });
    }
}
