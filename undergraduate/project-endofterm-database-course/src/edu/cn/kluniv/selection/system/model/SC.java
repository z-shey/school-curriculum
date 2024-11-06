package edu.cn.kluniv.selection.system.model;

public class SC {
    private String sno;
    private String sname;
    private String sdept;
    private String cno;
    private String cname;
    private String tname;
    private float grade;
    private String term;

    public SC() {
    }

    public SC(String sno, String sname, String sdept, String cno, String cname, String tname, float grade, String term) {
        this.sno = sno;
        this.sname = sname;
        this.sdept = sdept;
        this.cno = cno;
        this.cname = cname;
        this.tname = tname;
        this.grade = grade;
        this.term = term;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getSdept() {
        return sdept;
    }

    public void setSdept(String sdept) {
        this.sdept = sdept;
    }

    public String getCno() {
        return cno;
    }

    public void setCno(String cno) {
        this.cno = cno;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public float getGrade() {
        return grade;
    }

    public void setGrade(float grade) {
        this.grade = grade;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }
}
