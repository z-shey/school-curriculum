package edu.cn.kluniv.selection.system.view;

import edu.cn.kluniv.selection.system.dao.BaseDao;
import edu.cn.kluniv.selection.system.model.ResultSetTableModel;

import javax.swing.*;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreeSelectionModel;
import java.awt.*;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.sql.ResultSet;
import java.util.Objects;

public class AdministratorView {
    private JFrame frame;
    private JTree tree;
    private DefaultTreeModel treeModel;
    private DefaultMutableTreeNode rootTreeNode;
    private DefaultMutableTreeNode treeNodeSelectStudentInfo;
    private DefaultMutableTreeNode treeNodeSelectTeacherInfo;
    private DefaultMutableTreeNode treeNodeSelectCoursePlan;
    private JScrollPane scrollPane;
    private JTable table;
    private ResultSetTableModel resultSetTableModelSelectsStudentInfo;
    private ResultSetTableModel resultSetTableModelSelectTeacherInfo;
    private ResultSetTableModel resultSetTableModelSelectCoursePlan;
    private ResultSet rsStudentInfo;
    private ResultSet rsTeacherInfo;
    private ResultSet rsCoursePlan;

    public AdministratorView(ResultSet rsStudentInfo, ResultSet rsTeacherInfo, ResultSet rsCoursePlan) {
        this.rsStudentInfo = rsStudentInfo;
        this.rsTeacherInfo = rsTeacherInfo;
        this.rsCoursePlan = rsCoursePlan;
        initialize();
        events();
        frame.setVisible(true);
        frame.setLocationRelativeTo(null);
    }


    protected void events() {
        tree.addTreeSelectionListener(e -> {
            DefaultMutableTreeNode node = (DefaultMutableTreeNode) tree.getLastSelectedPathComponent();
            if (node.isLeaf()) {
                String selectNode = node.getUserObject().toString();
                if (selectNode.equals(treeNodeSelectStudentInfo.getUserObject().toString())) {
                    if (scrollPane != null) {
                        frame.remove(scrollPane);
                    }
                    resultSetTableModelSelectsStudentInfo = new ResultSetTableModel(rsStudentInfo);
                    table = new JTable();
                    table.setModel(resultSetTableModelSelectsStudentInfo);
                    scrollPane = new JScrollPane(table);
                    scrollPane.setViewportView(table);
                    frame.getContentPane().add(scrollPane, BorderLayout.SOUTH);
                    frame.pack();
                    frame.setVisible(true);
                    System.out.println(treeNodeSelectStudentInfo.getUserObject().toString());
                    table.addKeyListener(new KeyAdapter() {
                        public void keyPressed(KeyEvent e) {
                            if (e.getKeyCode() == KeyEvent.VK_DELETE) {
                                int row = table.getSelectedRow();
                                if (row != -1) {
                                    resultSetTableModelSelectsStudentInfo.deleteRow(row);
                                    table.setModel(new ResultSetTableModel(Objects.requireNonNull(
                                            ResultSetTableModel.freshData(
                                                    BaseDao.STUDENT,
                                                    BaseDao.USER_ROLE_ADMIN)
                                    )));
                                }
                            }
                        }
                    });
                    table.addKeyListener(new KeyAdapter() {
                        public void keyPressed(KeyEvent e) {
                            if (e.getKeyCode() == KeyEvent.VK_INSERT) {
                                resultSetTableModelSelectsStudentInfo.insertRowStudent();
                            }
                        }
                    });

                }

            }
        });

        tree.addTreeSelectionListener(e -> {
            DefaultMutableTreeNode node = (DefaultMutableTreeNode) tree.getLastSelectedPathComponent();
            if (node.isLeaf()) {
                String selectNode = node.getUserObject().toString();
                if (selectNode.equals(treeNodeSelectTeacherInfo.getUserObject().toString())) {
                    if (scrollPane != null) {
                        frame.remove(scrollPane);
                    }
                    resultSetTableModelSelectTeacherInfo = new ResultSetTableModel(rsTeacherInfo);
                    table = new JTable();
                    table.setModel(resultSetTableModelSelectTeacherInfo);
                    scrollPane = new JScrollPane(table);
                    scrollPane.setBounds(1307, 46, 2, 2);
                    scrollPane.setViewportView(table);
                    frame.getContentPane().add(scrollPane, BorderLayout.SOUTH);
                    frame.pack();
                    frame.setVisible(true);
                    System.out.println(treeNodeSelectTeacherInfo.getUserObject().toString());

                    table.addKeyListener(new KeyAdapter() {
                        public void keyPressed(KeyEvent e) {
                            if (e.getKeyCode() == KeyEvent.VK_DELETE) {
                                int row = table.getSelectedRow();
//                                resultSetTableModelSelectTeacherInfo.deleteRow(row);
//                                table.setModel(new ResultSetTableModel(Objects.requireNonNull(
//                                            ResultSetTableModel.freshData(
//                                                    BaseDao.TEACHER,
//                                                    BaseDao.USER_ROLE_ADMIN)
//                                    )));

                                if (row != -1) {
                                    resultSetTableModelSelectTeacherInfo.deleteRow(row);
                                    table.setModel(new ResultSetTableModel(Objects.requireNonNull(
                                            ResultSetTableModel.freshData(
                                                    BaseDao.TEACHER,
                                                    BaseDao.USER_ROLE_ADMIN)
                                    )));
                                }
                            }
                        }
                    });
                    table.addKeyListener(new KeyAdapter() {
                        public void keyPressed(KeyEvent e) {
                            if (e.getKeyCode() == KeyEvent.VK_A) {
                                System.out.println("insert");
                                resultSetTableModelSelectTeacherInfo.insertRowTeacher();
                            }
                        }
                    });

                }
            }
        });

        tree.addTreeSelectionListener(e -> {
            DefaultMutableTreeNode node = (DefaultMutableTreeNode) tree.getLastSelectedPathComponent();
            if (node.isLeaf()) {
                String selectNode = node.getUserObject().toString();
                if (selectNode.equals(treeNodeSelectCoursePlan.getUserObject().toString())) {
                    if (scrollPane != null) {
                        frame.remove(scrollPane);
                    }
                    resultSetTableModelSelectCoursePlan = new ResultSetTableModel(rsCoursePlan);
                    table = new JTable();
                    table.setModel(resultSetTableModelSelectCoursePlan);
                    scrollPane = new JScrollPane(table);
                    scrollPane.setViewportView(table);
                    frame.getContentPane().add(scrollPane, BorderLayout.SOUTH);
                    frame.pack();
                    frame.setVisible(true);
                    System.out.println(treeNodeSelectCoursePlan.getUserObject().toString());
                    table.addKeyListener(new KeyAdapter() {
                        public void keyPressed(KeyEvent e) {
                            if (e.getKeyCode() == KeyEvent.VK_DELETE) {
                                int row = table.getSelectedRow();
                                if (row != -1) {
                                    resultSetTableModelSelectCoursePlan.deleteRow(row);
                                    table.setModel(new ResultSetTableModel(Objects.requireNonNull(
                                            ResultSetTableModel.freshData(
                                                    BaseDao.COURSE,
                                                    BaseDao.USER_ROLE_ADMIN)
                                    )));
                                }
                            }
                        }
                    });
                    table.addKeyListener(new KeyAdapter() {
                        public void keyPressed(KeyEvent e) {
                            if (e.getKeyCode() == KeyEvent.VK_INSERT) {
                                resultSetTableModelSelectCoursePlan.insertRowCourse();
                            }
                        }
                    });
                }

            }
        });
    }

    private void initialize() {
        frame = new JFrame("Administrator");
        frame.setResizable(false);
        frame.getContentPane().setLayout(new BorderLayout(10, 10));
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        tree = new JTree();
        tree.getSelectionModel().setSelectionMode(TreeSelectionModel.SINGLE_TREE_SELECTION);
        rootTreeNode = new DefaultMutableTreeNode("Administrator Operation");
        treeNodeSelectStudentInfo = new DefaultMutableTreeNode("Student Information Management");
        treeNodeSelectTeacherInfo = new DefaultMutableTreeNode("Teacher Information Management");
        treeNodeSelectCoursePlan = new DefaultMutableTreeNode("Courses Plans Management");
        rootTreeNode.add(treeNodeSelectStudentInfo);
        rootTreeNode.add(treeNodeSelectTeacherInfo);
        rootTreeNode.add(treeNodeSelectCoursePlan);
        treeModel = new DefaultTreeModel(rootTreeNode);
        tree.setModel(treeModel);
        frame.getContentPane().add(tree, BorderLayout.CENTER);
        frame.pack();
    }

}
