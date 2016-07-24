package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.Photo;
import by.itransition.photocloud.persistance.model.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PhotoDaoImpl implements PhotoDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<Photo> findByUser(User user) {
        List<Photo> photos = sessionFactory.getCurrentSession()
                .createQuery("from Photo where user=?")
                .setParameter(0, user)
                .list();
        return photos.size() > 0 ? photos : null;
    }

    @Override
    public void save(Photo photo) {
        try {
            sessionFactory.getCurrentSession().save(photo);
        } catch (Exception ex) {

        }
    }
}
