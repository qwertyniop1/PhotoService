package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.Album;
import by.itransition.photocloud.persistance.model.Photo;
import by.itransition.photocloud.persistance.model.User;

import java.util.List;

public interface PhotoDao {

    List<Photo> findByUser(User user);

    Photo findById(String photoId);

    List<Photo> findByAlbum(int albumId);

    void save(Photo photo);

    void delete(Photo photo);
}
