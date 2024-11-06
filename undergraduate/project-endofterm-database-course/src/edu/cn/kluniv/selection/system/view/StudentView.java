package edu.cn.kluniv.selection.system.view;

import edu.cn.kluniv.selection.system.model.ResultSetTableModel;

import javax.swing.*;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreeSelectionModel;
import java.awt.*;
import java.sql.ResultSet;

public class StudentView {
    protected JFrame frame;

    protected JTree tree;
    protected DefaultTreeModel treeModel;
    protected DefaultMutableTreeNode rootTreeNode;
    protected DefaultMutableTreeNode treeNodeSelectPersonalInfo;
    protected DefaultMutableTreeNode treeNodeSelectCoursePlan;
    protected DefaultMutableTreeNode treeNodeSelectGrade;
    protected DefaultMutableTreeNode treeNodeModifyPassword;
    protected JLabel labelBackground;
    protected JScrollPane scrollPane;
    protected JTable table;
    protected ResultSetTableModel resultSetTableModel;
    protected ResultSet rs;
    int rowCount;
    int columnCount;
    private ResultSetTableModel resultSetTableModelSelectPersonalInfo;
    private ResultSetTableModel resultSetTableModelSelectGrade;
    private ResultSetTableModel resultSetTableModelSelectCoursePlan;
    private ResultSet rsPersonalInfo;
    private ResultSet rsGrade;
    private ResultSet rsCoursePlan;
    private String account;

    public StudentView() {
        initialize();
        myEvent();
        frame.setVisible(true);
        frame.setLocationRelativeTo(null);
    }

    public StudentView(ResultSet rsPersonalinfo, ResultSet rsCoursePlan, ResultSet rsGrade, String account) {
        this.rsPersonalInfo = rsPersonalinfo;
        this.rsGrade = rsGrade;
        this.rsCoursePlan = rsCoursePlan;
        this.account = account;
        initialize();
        myEvent();
        frame.setVisible(true);
        frame.setLocationRelativeTo(null);
    }

    protected void myEvent() {
        tree.addTreeSelectionListener(new TreeSelectionListener() {
            @Override
            public void valueChanged(TreeSelectionEvent e) {
                DefaultMutableTreeNode node = (DefaultMutableTreeNode) tree.getLastSelectedPathComponent();
                if (node.isLeaf()) {
                    String selectNode = node.getUserObject().toString();
                    if (selectNode.equals(treeNodeSelectPersonalInfo.getUserObject().toString())) {
                        if (scrollPane != null) {
                            frame.remove(scrollPane);
                        }
                        resultSetTableModelSelectPersonalInfo = new ResultSetTableModel(rsPersonalInfo);
                        table = new JTable();
                        table.setModel(resultSetTableModelSelectPersonalInfo);
                        scrollPane = new JScrollPane(table);
                        scrollPane.setViewportView(table);
                        frame.getContentPane().add(scrollPane, BorderLayout.SOUTH);
                        frame.pack();
                        frame.setVisible(true);
                        System.out.println(treeNodeSelectPersonalInfo.getUserObject().toString());
                    }
                }
            }
        });

        tree.addTreeSelectionListener(new TreeSelectionListener() {

            @Override
            public void valueChanged(TreeSelectionEvent e) {
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

                    }

                }
            }
        });

        tree.addTreeSelectionListener(new TreeSelectionListener() {

            @Override
            public void valueChanged(TreeSelectionEvent e) {
                DefaultMutableTreeNode node = (DefaultMutableTreeNode) tree.getLastSelectedPathComponent();
                if (node.isLeaf()) {
                    String selectNode = node.getUserObject().toString();
                    if (selectNode.equals(treeNodeSelectGrade.getUserObject().toString())) {
                        if (scrollPane != null) {
                            frame.remove(scrollPane);
                        }
                        resultSetTableModelSelectGrade = new ResultSetTableModel(rsGrade);
                        table = new JTable();
                        table.setModel(resultSetTableModelSelectGrade);
                        scrollPane = new JScrollPane(table);
                        scrollPane.setViewportView(table);
                        frame.getContentPane().add(scrollPane, BorderLayout.SOUTH);
                        frame.pack();
                        frame.setVisible(true);
                        System.out.println(treeNodeSelectGrade.getUserObject().toString());

                    }
                }
            }
        });

        tree.addTreeSelectionListener(new TreeSelectionListener() {

            @Override
            public void valueChanged(TreeSelectionEvent e) {
                DefaultMutableTreeNode node = (DefaultMutableTreeNode) tree.getLastSelectedPathComponent();
                if (node.isLeaf()) {
                    String selectNode = node.getUserObject().toString();
                    if (selectNode.equals(treeNodeModifyPassword.getUserObject().toString())) {
                        ModifyPasswordView modifyPasswordView = new ModifyPasswordView(account);
                        modifyPasswordView.setVisible(true);
                        modifyPasswordView.setLocationRelativeTo(null);
                        System.out.println(treeNodeModifyPassword.getUserObject().toString());
                    }
                }
            }
        });

    }

    private void initialize() {
        frame = new JFrame("Index");
        frame.setResizable(false);
        frame.getContentPane().setLayout(new BorderLayout(10, 10));
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        tree = new JTree();
        tree.getSelectionModel().setSelectionMode(TreeSelectionModel.SINGLE_TREE_SELECTION);
        rootTreeNode = new DefaultMutableTreeNode("Student Operation");
        treeNodeSelectPersonalInfo = new DefaultMutableTreeNode("Student Information");
        treeNodeSelectCoursePlan = new DefaultMutableTreeNode("Course Plans");
        treeNodeSelectGrade = new DefaultMutableTreeNode("Grade");
        treeNodeModifyPassword = new DefaultMutableTreeNode("Modify Password");
        rootTreeNode.add(treeNodeSelectPersonalInfo);
        rootTreeNode.add(treeNodeSelectCoursePlan);
        rootTreeNode.add(treeNodeSelectGrade);
        rootTreeNode.add(treeNodeModifyPassword);
        treeModel = new DefaultTreeModel(rootTreeNode);
        tree.setModel(treeModel);
        frame.getContentPane().add(tree, BorderLayout.WEST);
        frame.pack();

    }

}
