package by.itransition.photocloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/albums")
public class AlbumController {

    @GetMapping("/show")
    public String slideshow(Model model) {
        return "photos/slideshow";
    }

}
