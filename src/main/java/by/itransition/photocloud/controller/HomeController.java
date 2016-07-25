package by.itransition.photocloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {

    @GetMapping("/tmp")
    public String index() {
        return "index";
    }

    @RequestMapping("/403")
    String accessDenied() {
        return "error/403";
    }

}


