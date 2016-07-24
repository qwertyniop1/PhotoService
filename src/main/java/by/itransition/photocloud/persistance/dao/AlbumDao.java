package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.Album;
import by.itransition.photocloud.persistance.model.User;

import java.util.List;

public interface AlbumDao {

    List<Album> findByUser(User user);

    void save(Album album);

}
