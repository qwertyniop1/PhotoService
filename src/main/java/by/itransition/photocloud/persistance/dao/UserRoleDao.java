package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.UserRole;

import java.util.List;

public interface UserRoleDao {

    List<UserRole> findByRole(String role);

}
