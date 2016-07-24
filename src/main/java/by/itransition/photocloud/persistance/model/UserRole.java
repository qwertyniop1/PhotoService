package by.itransition.photocloud.persistance.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "user_roles", catalog = "auth")
public class UserRole {

    @Id
    @Column(name = "user_role_id", unique = true, nullable = false)
    private int userRoleId;

//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "user_email", nullable = false)
    @ManyToMany(fetch = FetchType.LAZY, mappedBy = "userRoles")
    private Set<User> users = new HashSet<>(0);

    @Column(nullable = false)
    private String role;

    public UserRole() {
    }

    public UserRole(int userRoleId, Set<User> users, String role) {
        this.userRoleId = userRoleId;
        this.users = users;
        this.role = role;
    }

    public int getUserRoleId() {
        return userRoleId;
    }

    public void setUserRoleId(int userRoleId) {
        this.userRoleId = userRoleId;
    }

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserRole userRole = (UserRole) o;

        if (userRoleId != userRole.userRoleId) return false;
        if (!users.equals(userRole.users)) return false;
        return role.equals(userRole.role);

    }

    @Override
    public int hashCode() {
        int result = userRoleId;
        result = 31 * result + users.hashCode();
        result = 31 * result + role.hashCode();
        return result;
    }

    @Override
    public String toString() {
        return "UserRole{" +
                "userRoleId=" + userRoleId +
                ", users=" + users +
                ", role='" + role + '\'' +
                '}';
    }
}
