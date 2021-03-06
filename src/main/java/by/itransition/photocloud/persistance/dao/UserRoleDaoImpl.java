package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.UserRole;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserRoleDaoImpl implements UserRoleDao{

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<UserRole> findByRole(String role) {
        List<UserRole> roles;
        roles = sessionFactory.getCurrentSession()
                .createQuery("from UserRole where role=?")
                .setParameter(0, role)
                .list();
        return roles.size() > 0 ? roles : null;
    }
}
