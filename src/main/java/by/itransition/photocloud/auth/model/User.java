package by.itransition.photocloud.auth.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "users", catalog = "auth")
public class User {

    @Id
    @Column(unique = true, nullable = false, length = 45)
    private String email;

    @Column(nullable = false, length = 60)
    private String password;

    @Column(nullable = false)
    private boolean enabled;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    private Set<UserRole> userRole = new HashSet<>(0);

    public User() {
    }

    public User(String email, String password, boolean enabled, String firstName, String lastName, Set<UserRole> userRole) {
        this.email = email;
        this.password = password;
        this.enabled = enabled;
        this.firstName = firstName;
        this.lastName = lastName;
        this.userRole = userRole;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Set<UserRole> getUserRole() {
        return userRole;
    }

    public void setUserRole(Set<UserRole> userRole) {
        this.userRole = userRole;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        if (enabled != user.enabled) return false;
        if (!email.equals(user.email)) return false;
        if (!password.equals(user.password)) return false;
        if (!firstName.equals(user.firstName)) return false;
        if (!lastName.equals(user.lastName)) return false;
        return userRole.equals(user.userRole);

    }

    @Override
    public int hashCode() {
        int result = email.hashCode();
        result = 31 * result + password.hashCode();
        result = 31 * result + (enabled ? 1 : 0);
        result = 31 * result + firstName.hashCode();
        result = 31 * result + lastName.hashCode();
        result = 31 * result + userRole.hashCode();
        return result;
    }

    @Override
    public String toString() {
        return "User{" +
                "email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", enabled=" + enabled +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", userRole=" + userRole +
                '}';
    }
}
