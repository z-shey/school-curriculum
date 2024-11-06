package edu.cn.kluniv.selection.system.model;

public class Administrator {
    private String ano;
    private String aname;
    private String asex;
    private int aage;
    private String adept;

    public Administrator() {
    }

    public Administrator(String ano, String aname, String asex, int aage, String adept) {
        this.ano = ano;
        this.aname = aname;
        this.asex = asex;
        this.aage = aage;
        this.adept = adept;
    }

    public String getAno() {
        return ano;
    }

    public void setAno(String ano) {
        this.ano = ano;
    }

    public String getAname() {
        return aname;
    }

    public void setAname(String aname) {
        this.aname = aname;
    }

    public String getAsex() {
        return asex;
    }

    public void setAsex(String asex) {
        this.asex = asex;
    }

    public int getAage() {
        return aage;
    }

    public void setAage(int aage) {
        this.aage = aage;
    }

    public String getAdept() {
        return adept;
    }

    public void setAdept(String adept) {
        this.adept = adept;
    }
}
