package by.itransition.photocloud.service;

import by.itransition.photocloud.persistance.dao.PhotoDao;
import by.itransition.photocloud.persistance.dao.UserDao;
import by.itransition.photocloud.persistance.model.Photo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class PhotoService implements IPhotoService {

    @Autowired
    private PhotoDao photoRepository;

    @Autowired
    private UserDao userRepository;

    @Override
    public void addPhoto(String email, String photoId) {
        photoRepository.save(new Photo(photoId, userRepository.findByEmail(email), false));
    }

    @Override
    public List<Photo> getUserPhotos(String email) {
        return photoRepository.findByUser(userRepository.findByEmail(email));
    }

    @Override
    public void deletePhoto(String email, String photoId) {

    }
}
