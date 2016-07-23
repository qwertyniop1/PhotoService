package by.itransition.photocloud.auth.dao;

import by.itransition.photocloud.auth.model.User;
import by.itransition.photocloud.auth.model.UserRole;

import java.util.List;

public interface UserRoleDao {

    List<UserRole> findByRole(String role);

}
