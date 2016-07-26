package by.itransition.photocloud.controller;

import by.itransition.photocloud.service.IAlbumService;
import by.itransition.photocloud.service.IPhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
        model.addAttribute("albumId", id);
        model.addAttribute("albumName", albumService.getName(id));
        return "albums/album";
    }

    @PostMapping("/add")
    public @ResponseBody
    String addPhoto(@RequestParam("photo_list[]") String[] photoIds, @RequestParam int id,
                    @RequestParam("album_name") String name, Model model) {
        albumService.addPhoto(id, name, photoIds);
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

    @GetMapping("/show/{id}")
    public String slideshow(@PathVariable int id, Model model) {
        model.addAttribute("photoList", albumService.getPhotos(id));
        return "photos/slideshow";
    }

}
