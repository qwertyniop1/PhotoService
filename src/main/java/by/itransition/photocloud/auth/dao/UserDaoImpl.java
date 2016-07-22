package by.itransition.photocloud.auth.dao;

import by.itransition.photocloud.auth.model.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class UserDaoImpl implements UserDao{

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public User findByEmail(String email) {
        List<User> users = new ArrayList<>();
        users = sessionFactory.getCurrentSession()
                .createQuery("from User where email=?")
                .setParameter(0, email)
                .list();
        return users.size() > 0 ? users.get(0) : null;
    }

    @Override
    public User save(User user) {
        try {
            sessionFactory.getCurrentSession().save(user);
        } catch (Exception ex) {
            return null;
        }
        return user;
    }
}
