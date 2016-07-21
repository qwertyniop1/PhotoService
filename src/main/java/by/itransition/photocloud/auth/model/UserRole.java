package by.itransition.photocloud.auth.model;

import javax.persistence.*;

@Entity
@Table(name = "user_roles", catalog = "auth", uniqueConstraints = @UniqueConstraint(columnNames = {"role", "username"}))
public class UserRole {

    @Id
    @Column(name = "user_role_id", unique = true, nullable = false)
    private int userRoleId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "username", nullable = false)
    private User user;

    @Column(nullable = false)
    private String role;

    public UserRole() {
    }

    public UserRole(int userRoleId, User user, String role) {
        this.userRoleId = userRoleId;
        this.user = user;
        this.role = role;
    }

    public int getUserRoleId() {
        return userRoleId;
    }

    public void setUserRoleId(int userRoleId) {
        this.userRoleId = userRoleId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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
        return role.equals(userRole.role);

    }

    @Override
    public int hashCode() {
        int result = userRoleId;
        result = 31 * result + role.hashCode();
        return result;
    }

    @Override
    public String toString() {
        return "UserRole{" +
                "userRoleId=" + userRoleId +
                ", role='" + role + '\'' +
                '}';
    }
}
