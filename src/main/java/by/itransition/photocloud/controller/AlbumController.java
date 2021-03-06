package by.itransition.photocloud.controller;

import by.itransition.photocloud.persistance.dto.AlbumDto;
import by.itransition.photocloud.persistance.model.Album;
import by.itransition.photocloud.persistance.model.Photo;
import by.itransition.photocloud.service.IAlbumService;
import by.itransition.photocloud.service.IPhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/albums")
public class AlbumController {

    @Autowired
    private IAlbumService albumService;

    @Autowired
    private IPhotoService photoService;

    @GetMapping
    public String index(Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("albumList", albumService.getUserAlbums(user.getUsername()));
        return "albums/index";
    }

//    @GetMapping("/create")
//    public String createAlbum(Model model) {
//        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        model.addAttribute("photoList", photoService.getUserPhotos(user.getUsername()));
//        return "albums/album";
//    }

    @PostMapping("/create")
    public @ResponseBody
    String create(@RequestParam("album") String name, Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        albumService.create(name, user.getUsername());
        return "created";
    }

    @GetMapping("/{id}")
    public String edit(@PathVariable int id, Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("photoList", photoService.getUserPhotos(user.getUsername()));
        model.addAttribute("albumPhotos", albumService.getPhotos(id));
        model.addAttribute("albumDto", albumService.getAlbumDto(id));
        return "albums/album";
    }

    @PostMapping("/add")
    public @ResponseBody
    String addPhoto(@RequestParam("photo_list[]") String[] photoIds, @RequestParam int id,
                    @RequestParam("album_name") String name, @RequestParam boolean random,
                    @RequestParam int speed, @RequestParam("effect_speed") int effectSpeed,
                    @RequestParam String effects, Model model) {
        albumService.addPhoto(id, name, photoIds, effects, speed, effectSpeed, random);
        return "added";
    }

    @PostMapping("/delete")
    public @ResponseBody
    String delete(@RequestParam("album_id") int id, Model model) {
        albumService.delete(id);
        return "deleted";
    }

    @PostMapping("/restore")
    public  @ResponseBody
    String restore(@RequestParam("album_id") int id, Model model) {
        albumService.restore(id);
        return "restored";
    }

    @GetMapping("/show/{id}") //TODO 0 photos
    public String slideshow(@PathVariable int id, Model model) {
        List<Photo> photos = albumService.getPhotos(id);
        if (photos == null || photos.size() < 2)
            return "redirect:/albums/" + id;
        model.addAttribute("photoList", photos);
        model.addAttribute("albumDto", albumService.getAlbumDto(id));
        return "albums/slideshow";
    }

}
