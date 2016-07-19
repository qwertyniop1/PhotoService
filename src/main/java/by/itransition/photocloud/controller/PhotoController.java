package by.itransition.photocloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/photo")
public class PhotoController {

    @GetMapping
    public String photos(Model model) {
        return "photos/index";
    }

    @GetMapping("/upload")
    public String uploadPhoto(@RequestParam("photo_id") String photoId, Model model) {
        //System.out.println(photoId);
        return null;
    }

    @GetMapping("/edit")
    public String editPhoto(Model model) {
        return "photos/edit";
    }



}