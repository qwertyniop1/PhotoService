package by.itransition.photocloud.auth.dao;

import by.itransition.photocloud.auth.model.User;
import by.itransition.photocloud.auth.model.VerificationToken;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class VerificationTokenDaoImpl implements VerificationTokenDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public VerificationToken findByToken(String token) {
        List<VerificationToken> tokens = new ArrayList<>();
        tokens = sessionFactory.getCurrentSession()
                .createQuery("from VerificationToken where token=?")
                .setParameter(0, token)
                .list();
        return tokens.size() > 0 ? tokens.get(0) : null;
    }

    @Override
    public VerificationToken findByUser(User user) {
        List<VerificationToken> tokens = new ArrayList<>();
        tokens = sessionFactory.getCurrentSession()
                .createQuery("from VerificationToken where user=?")
                .setParameter(0, user)
                .list();
        return tokens.size() > 0 ? tokens.get(0) : null;
    }

    @Override
    public VerificationToken save(VerificationToken token) {
        try {
            sessionFactory.getCurrentSession().save(token);
        } catch (Exception ex) {
            return null;
        }
        return token;
    }
}
