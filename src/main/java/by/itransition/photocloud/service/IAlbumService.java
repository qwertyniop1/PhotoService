package by.itransition.photocloud.service;

import by.itransition.photocloud.persistance.model.Album;
import by.itransition.photocloud.persistance.model.Photo;

import java.util.List;

public interface IAlbumService {

    void create(String name, String email);

    String getName(int id);

    void addPhoto(int id, String name, String[] photoIds);

    List<Album> getUserAlbums(String email);

    List<Photo> getPhotos(int id);

    void delete(int id);

    void restore(int id);

}
