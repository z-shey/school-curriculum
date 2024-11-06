package edu.cn.kluniv.selection.system.dao;

import java.sql.ResultSet;

public interface BaseDao<T> {
    int USER_ROLE_STUDENT = 1;
    int USER_ROLE_TEACHER = 2;
    int USER_ROLE_ADMIN = 3;

    String TEACHER = "TEACHER";
    String STUDENT = "STUDENT";
    String COURSE = "COURSE";

    void insert(T entity);

    void delete(String id);

    void update(T entity, String id);

    ResultSet selectById(String id);

    ResultSet selectAll(int role);
}
