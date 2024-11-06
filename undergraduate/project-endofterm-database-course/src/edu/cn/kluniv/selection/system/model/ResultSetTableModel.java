package edu.cn.kluniv.selection.system.model;

import edu.cn.kluniv.selection.system.dao.BaseDao;
import edu.cn.kluniv.selection.system.dao.CourseDao;
import edu.cn.kluniv.selection.system.dao.StudentDao;
import edu.cn.kluniv.selection.system.dao.TeacherDao;
import edu.cn.kluniv.selection.system.util.DBUtil;

import javax.swing.table.AbstractTableModel;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class ResultSetTableModel extends AbstractTableModel {
    private ResultSet resultSet;
    private ResultSetMetaData resultSetMetaData;

    public ResultSetTableModel(ResultSet resultSet) {
        this.resultSet = resultSet;
        try {
            resultSetMetaData = resultSet.getMetaData();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public ResultSet getResultSet() {
        return resultSet;
    }

    public String getColumnName(int columnIndex) {
        try {
            return resultSetMetaData.getColumnName(columnIndex + 1);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    @Override
    public int getRowCount() {
        try {
            resultSet.last();
            int rowCount = resultSet.getRow();
            resultSet.beforeFirst();
            return rowCount;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    @Override
    public int getColumnCount() {
        try {
            return resultSetMetaData.getColumnCount();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public void setValueAt(Object object, int rowIndex, int columnIndex) {
        try {

            resultSet.absolute(rowIndex + 1);
            resultSet.updateObject(columnIndex + 1, object);
            resultSet.updateRow();

            /*
            if (resultSet.absolute(rowIndex + 1) && !resultSet.rowDeleted()) {
                resultSet.updateObject(columnIndex + 1, object);
            } else {
                resultSet.absolute(rowIndex + 1);
            }
            resultSet.updateRow();
            */

            fireTableCellUpdated(rowIndex, columnIndex);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        try {
//            resultSet.absolute(rowIndex + 1);
//            return resultSet.getObject(columnIndex + 1);
            if (resultSet.absolute(rowIndex + 1) && !resultSet.rowDeleted()) {
                return resultSet.getObject(columnIndex + 1);
            } else {
                resultSet.absolute(rowIndex + 1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return null;
    }


    public boolean isCellEditable(int rowIndex, int columnIndex) {
        try {
            if (resultSet.getConcurrency() == ResultSet.CONCUR_UPDATABLE) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public void deleteRow(int rowIndex) {
        try {
            resultSet.absolute(rowIndex + 1);
            resultSet.deleteRow();
            fireTableRowsDeleted(rowIndex, rowIndex);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    public void insertRowStudent() {
        int rowInserted = getRowCount() + 1;
        try {
            resultSet.moveToInsertRow();
            resultSet.updateString("sno", "001");
            resultSet.updateString("sname", "待插入");
            resultSet.updateString("ssex", "男");
            resultSet.updateInt("sage", 23);
            resultSet.updateString("sdept", "信息技术");
            resultSet.insertRow();
            fireTableRowsInserted(rowInserted, rowInserted);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }


    public void insertRowTeacher() {
        int rowInserted = getRowCount() + 1;
        try {
            resultSet.moveToInsertRow();
            resultSet.updateString("tno", "001");
            resultSet.updateString("tname", "待插入");
            resultSet.updateString("tsex", "男");
            resultSet.updateInt("tage", 23);
            resultSet.updateString("tdept", "信息技术");
            resultSet.insertRow();
            fireTableRowsInserted(rowInserted, rowInserted);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void insertRowCourse() {
        int rowInserted = getRowCount() + 1;
        try {
            resultSet.moveToInsertRow();
            resultSet.updateString("cno", "001");
            resultSet.updateString("cname", "待插入");
            resultSet.updateString("tno", "02");
            resultSet.updateString("cpno", "待插入");
            resultSet.updateInt("ccredit", 3);
            resultSet.insertRow();
            fireTableRowsInserted(rowInserted, rowInserted);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    static public ResultSet freshData(String type, int role) {
        DBUtil dbUtil = new DBUtil();
        dbUtil.connect();
        StudentDao studentDao = new StudentDao(dbUtil);
        TeacherDao teacherDao = new TeacherDao(dbUtil);
        CourseDao courseDao = new CourseDao(dbUtil);
        switch (type) {
            case BaseDao.STUDENT:
                return studentDao.selectAll(role);
            case BaseDao.TEACHER:
                return teacherDao.selectAll(role);
            case BaseDao.COURSE:
                return courseDao.selectAll(role);
            default:
                return null;
        }
    }
}

