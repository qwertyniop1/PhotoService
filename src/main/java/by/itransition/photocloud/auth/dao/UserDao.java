package by.itransition.photocloud.auth.dao;

import by.itransition.photocloud.auth.model.User;

public interface UserDao {

    User findByEmail(String email);

    User save(User user);
}
