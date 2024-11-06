package entity;

public class Role {
    private Integer RoleID;
    private String RoleIdentifier;
    private String RoleName;
    private Integer RoleNumber;

    public Role() {
    }

    public Role(Integer roleID, String roleIdentifier, String roleName, Integer roleNumber) {
        RoleID = roleID;
        RoleIdentifier = roleIdentifier;
        RoleName = roleName;
        RoleNumber = roleNumber;
    }

    public Integer getRoleID() {
        return RoleID;
    }

    public void setRoleID(Integer roleID) {
        RoleID = roleID;
    }

    public String getRoleIdentifier() {
        return RoleIdentifier;
    }

    public void setRoleIdentifier(String roleIdentifier) {
        RoleIdentifier = roleIdentifier;
    }

    public String getRoleName() {
        return RoleName;
    }

    public void setRoleName(String roleName) {
        RoleName = roleName;
    }

    public Integer getRoleNumber() {
        return RoleNumber;
    }

    public void setRoleNumber(Integer roleNumber) {
        RoleNumber = roleNumber;
    }
}
