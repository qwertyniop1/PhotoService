package by.itransition.photocloud.controller;

import by.itransition.photocloud.persistance.dto.UserDto;
import by.itransition.photocloud.events.OnRegistrationCompleteEvent;
import by.itransition.photocloud.persistance.model.User;
import by.itransition.photocloud.persistance.model.VerificationToken;
import by.itransition.photocloud.service.IUserService;
import by.itransition.photocloud.validators.EmailExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;

import javax.validation.Valid;
import java.util.Calendar;
import java.util.Locale;

@Controller
@RequestMapping("/")
public class AuthController {

    @Autowired
    private IUserService service;

    @Autowired
    private ApplicationEventPublisher eventPublisher;

    @Autowired
    private MessageSource messages;

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
        model.addAttribute(user);
        if (result.hasErrors()) {
            return "auth/registration";
        }
        User registeredUser = createUser(user, result);
        if (registeredUser == null) {
            result.rejectValue("email", "message.userExist");
            return "auth/registration";
        }
        try {
            String appUrl = request.getContextPath();
            eventPublisher.publishEvent(new OnRegistrationCompleteEvent
                    (registeredUser, appUrl, request.getLocale()));
        } catch (Exception ex) {
            return "auth/emailError";
        }
        return result.hasErrors() ? "auth/registration" : "auth/success";
    }

    @GetMapping("/registration-confirm")
    public String confirmRegistration(@RequestParam("confirm_token") String token, WebRequest request, Model model) {
        Locale locale = request.getLocale();
        VerificationToken verificationToken = service.getVerificationToken(token);
        if (verificationToken == null) {
            model.addAttribute("message", messages.getMessage("message.invalidToken", null, locale));
            return "redirect:/wrong-user?lang=" + locale.getLanguage();
        }
        User user = verificationToken.getUser();
        Calendar calendar = Calendar.getInstance();
        if ((verificationToken.getExpiryDate().getTime() - calendar.getTime().getTime()) <= 0) {
            model.addAttribute("message", messages.getMessage("message.expiredToken", null, locale));
            return "redirect:/wrong-user?lang=" + locale.getLanguage();
        }
        user.setEnabled(true);
        service.saveRegisteredUser(user);
        return "redirect:/login?activate=true&lang=" + locale.getLanguage();
    }

    @GetMapping("/wrong-user")
    public String wrongUser(Model model) {
        return "auth/wrongUser"; // TODO problem with encoding message and user name
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
