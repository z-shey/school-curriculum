package edu.cn.kluniv.selection.system.model;

public class User {
    private String account;
    private String password;
    private int role;

    public User() {
    }

    public User(String account, String password, int role) {
        this.account = account;
        this.password = password;
        this.role = role;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
}
