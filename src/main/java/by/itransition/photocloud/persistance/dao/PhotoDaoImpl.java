package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.Album;
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
                .createQuery("from Photo where user=? and deleted=? order by upload_date")
                .setParameter(0, user)
                .setParameter(1, false)
                .list();
        return photos.size() > 0 ? photos : null;
    }

    @Override
    public Photo findById(String photoId) {
        List<Photo> photos = sessionFactory.getCurrentSession()
                .createQuery("from Photo where id=?")
                .setParameter(0, photoId)
                .list();
        return photos.size() > 0 ? photos.get(0) : null;
    }

    @Override
    public List<Photo> findByAlbum(int albumId) {
        List<Photo> photos = sessionFactory.getCurrentSession()
                .createQuery("from Photo photo join photo.albums album where album.id=?")
                .setParameter(0, albumId)
                .list();
        return photos.size() > 0 ? photos : null;
    }

    @Override
    public void save(Photo photo) {
        try {
            sessionFactory.getCurrentSession().saveOrUpdate(photo);
        } catch (Exception ex) {

        }
    }

    @Override
    public void delete(Photo photo) {
        try {
            sessionFactory.getCurrentSession().delete(photo);
        } catch (Exception ex) {

        }
    }
}
