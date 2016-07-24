package by.itransition.photocloud.service;


import by.itransition.photocloud.persistance.model.Photo;

import java.util.List;

public interface IPhotoService {

    void addPhoto(String email, String photoId);

    List<Photo> getUserPhotos(String email);

    void deletePhoto(String photoId);

    void restore(String photoId);
}
