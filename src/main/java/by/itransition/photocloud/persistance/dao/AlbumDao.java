package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.Album;
import by.itransition.photocloud.persistance.model.Photo;
import by.itransition.photocloud.persistance.model.User;

import java.util.List;

public interface AlbumDao {

    Album findById(int id);

    List<Album> findByUser(User user);

    void save(Album album);

}
