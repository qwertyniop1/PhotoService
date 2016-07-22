package by.itransition.photocloud.controller;

import by.itransition.photocloud.auth.dto.UserDto;
import by.itransition.photocloud.auth.model.User;
import by.itransition.photocloud.auth.service.IUserService;
import by.itransition.photocloud.validators.EmailExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;

import javax.validation.Valid;

@Controller
@RequestMapping("/")
public class AuthController {

    @Autowired
    private IUserService service;

    @GetMapping("/login")
    public String loginForm(Model model) {
//        model.addAttribute(new User());
        return "auth/login";
    }

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("user", new UserDto());
        return "auth/registration";
    }

    @PostMapping("/register")
    public String registerNewUser(@ModelAttribute("user") @Valid UserDto user, BindingResult result,
                                  WebRequest request, Errors errors, Model model) {
        User registeredUser = new User();
        if (!result.hasErrors()) {
            registeredUser = createUser(user, result);
        }
        if (registeredUser == null) {
            result.rejectValue("email", "Loh pizdets email lalka"); // TODO messages in separate file
        }
        model.addAttribute(user);
        return result.hasErrors() ? "auth/registration" : "auth/success";
    }

    private User createUser(UserDto user, BindingResult result) {
        User registered = null;
        try {
            registered = service.registerNewUser(user);
        } catch (EmailExistException e) {

        }
        return registered;
    }

}

// TODO verification by email http://www.baeldung.com/security-spring
