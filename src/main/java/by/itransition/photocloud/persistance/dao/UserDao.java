package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.User;

public interface UserDao {

    User findByEmail(String email);

    User save(User user);
}
