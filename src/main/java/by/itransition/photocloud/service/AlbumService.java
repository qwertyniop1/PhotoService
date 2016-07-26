package by.itransition.photocloud.service;

import by.itransition.photocloud.persistance.dao.AlbumDao;
import by.itransition.photocloud.persistance.dao.PhotoDao;
import by.itransition.photocloud.persistance.dao.UserDao;
import by.itransition.photocloud.persistance.model.Album;
import by.itransition.photocloud.persistance.model.Photo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Transactional
@Service
public class AlbumService implements IAlbumService{

    @Autowired
    private AlbumDao albumRepository;

    @Autowired
    private UserDao userRepository;

    @Autowired
    PhotoDao photoRepository;

    @Override
    public void create(String name, String email) {
        albumRepository.save(new Album(name, userRepository.findByEmail(email), false));
    }

    @Override
    public String getName(int id) {
        return albumRepository.findById(id).getName();
    }

    @Override
    public void addPhoto(int id, String name, String[] photoIds) {
        Album album = albumRepository.findById(id);
        Set<Photo> photos = new HashSet<>(0);
        for (String photoId : photoIds) {
            photos.add(photoRepository.findById(photoId));
        }
        album.setPhotos(photos);
        album.setName(name);
        albumRepository.save(album);
    }

    @Override
    public List<Album> getUserAlbums(String email) {
        return albumRepository.findByUser(userRepository.findByEmail(email));
    }

    @Override
    public List<Photo> getPhotos(int id) {
        return photoRepository.findByAlbum(id);
    }

    @Override
    public void delete(int id) {
        Album album = albumRepository.findById(id);
        if (album == null) return;
        album.setDeleted(true);
        albumRepository.save(album);
    }

    @Override
    public void restore(int id) {
        Album album = albumRepository.findById(id);
        if (album == null) return;
        album.setDeleted(false);
        albumRepository.save(album);
    }
}
