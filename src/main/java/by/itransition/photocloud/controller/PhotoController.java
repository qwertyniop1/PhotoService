package by.itransition.photocloud.controller;

import by.itransition.photocloud.persistance.model.Photo;
import by.itransition.photocloud.service.IPhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/photo")
public class PhotoController {

    @Autowired
    private IPhotoService photoService;

    @GetMapping
    public String photos(Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("photoList", photoService.getUserPhotos(user.getUsername()));
        return "photos/index";
    }

    @PostMapping("/upload")
    public @ResponseBody
    String uploadPhoto(@RequestParam("photo_id") String photoId, Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        photoService.addPhoto(user.getUsername(), photoId);
        return "saved";
    }

    @GetMapping("/edit")
    public String editPhoto(@RequestParam("photo_id") String photoId, Model model) {
        model.addAttribute("photo_id", photoId);
        return "photos/edit";
    }

    // TODO saving to the cloud
    @PostMapping("/edit")
    public String savePhoto(Model model) {
        return "redirect:/photo";
    }

    @PostMapping("/delete")
    public @ResponseBody
    String deletePhoto(@RequestParam("photo_id") String photoId, Model model) {
        photoService.deletePhoto(photoId);
        return "deleted";
    }

    @PostMapping("/restore")
    public @ResponseBody
    String restorePhoto(@RequestParam("photo_id") String photoId, Model model) {
        photoService.restore(photoId);
        return "restored";
    }

}