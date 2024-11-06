package edu.cn.kluniv.selection.system.model;

public class Teacher {
    private String tno;
    private String tname;
    private String tsex;
    private int tage;
    private String tdept;

    public Teacher() {
    }

    public Teacher(String tno, String tname, String tsex, int tage, String tdept) {
        this.tno = tno;
        this.tname = tname;
        this.tsex = tsex;
        this.tage = tage;
        this.tdept = tdept;
    }

    public String getTno() {
        return tno;
    }

    public void setTno(String tno) {
        this.tno = tno;
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public String getTsex() {
        return tsex;
    }

    public void setTsex(String tsex) {
        this.tsex = tsex;
    }

    public int getTage() {
        return tage;
    }

    public void setTage(int tage) {
        this.tage = tage;
    }

    public String getTdept() {
        return tdept;
    }

    public void setTdept(String tdept) {
        this.tdept = tdept;
    }
}
