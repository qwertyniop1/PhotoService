package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.Album;
import by.itransition.photocloud.persistance.model.Photo;
import by.itransition.photocloud.persistance.model.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AlbumDaoImpl implements AlbumDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<Album> findByUser(User user) {
        List<Album> albums = sessionFactory.getCurrentSession()
                .createQuery("from Album where user=? and deleted=? order by date")
                .setParameter(0, user)
                .setParameter(1, false)
                .list();
        return albums.size() > 0 ? albums : null;
    }

    @Override
    public void save(Album album) {
        try {
            sessionFactory.getCurrentSession().saveOrUpdate(album);
        } catch (Exception ex) {

        }
    }
}
