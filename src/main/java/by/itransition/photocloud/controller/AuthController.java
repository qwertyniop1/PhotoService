package by.itransition.photocloud.controller;

import by.itransition.photocloud.auth.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/")
public class AuthController {

    @GetMapping("/login")
    public String loginForm(Model model) {
//        model.addAttribute(new User());
        return "auth/login";
    }

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute(new User());
        return "auth/registration";
    }

}
