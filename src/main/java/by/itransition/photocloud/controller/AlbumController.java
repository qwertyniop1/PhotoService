package by.itransition.photocloud.controller;

import by.itransition.photocloud.service.IAlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/albums")
public class AlbumController {

    @Autowired
    private IAlbumService albumService;

    @GetMapping
    public String index(Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("albumList", albumService.getUserAlbums(user.getUsername()));
        return "albums/index";
    }

    @GetMapping("/create")
    public String create(@RequestParam("album") String name, Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        albumService.create(name, user.getUsername());
        return "redirect:/albums";
    }

    @GetMapping("/{id}")
    public String edit(@PathVariable int id, Model model) {
        model.addAttribute("albumList", albumService.getPhotos(id));
        return "albums/index";
    }

    @GetMapping("/show")
    public String slideshow(Model model) {
        return "photos/slideshow";
    }

}
