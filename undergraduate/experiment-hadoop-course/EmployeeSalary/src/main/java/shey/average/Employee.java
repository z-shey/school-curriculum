package shey.average;

import org.apache.hadoop.io.Writable;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;

public class Employee implements Writable {
    private int employeeId;
    private String employeeName;
    private String job;
    private int manager;
    private String hireDate;
    private int salary;
    private int commission;
    private int departmentId;

    @Override
    public void write(DataOutput dataOutput) throws IOException {
        dataOutput.writeInt(this.employeeId);
        dataOutput.writeUTF(this.employeeName);
        dataOutput.writeUTF(this.job);
        dataOutput.writeInt(this.manager);
        dataOutput.writeUTF(this.hireDate);
        dataOutput.writeInt(this.salary);
        dataOutput.writeInt(this.commission);
        dataOutput.writeInt(this.departmentId);
    }

    @Override
    public void readFields(DataInput dataInput) throws IOException {
        this.employeeId = dataInput.readInt();
        this.employeeName = dataInput.readUTF();
        this.job = dataInput.readUTF();
        this.manager = dataInput.readInt();
        this.hireDate = dataInput.readUTF();
        this.salary = dataInput.readInt();
        this.commission = dataInput.readInt();
        this.departmentId = dataInput.readInt();
    }

    @Override
    public String toString() {
        return "Employee{" +
                "employeeId=" + employeeId +
                ", employeeName='" + employeeName + '\'' +
                ", job='" + job + '\'' +
                ", manager=" + manager +
                ", hireDate='" + hireDate + '\'' +
                ", salary=" + salary +
                ", commission=" + commission +
                ", departmentId=" + departmentId +
                '}';
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public int getManager() {
        return manager;
    }

    public void setManager(int manager) {
        this.manager = manager;
    }

    public String getHireDate() {
        return hireDate;
    }

    public void setHireDate(String hireDate) {
        this.hireDate = hireDate;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    public int getCommission() {
        return commission;
    }

    public void setCommission(int commission) {
        this.commission = commission;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }
}
