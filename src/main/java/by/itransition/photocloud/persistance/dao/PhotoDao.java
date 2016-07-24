package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.Photo;
import by.itransition.photocloud.persistance.model.User;

import java.util.List;

public interface PhotoDao {

    List<Photo> findByUser(User user);

    Photo findById(String photoId);

    void save(Photo photo);

    void delete(Photo photo);
}
