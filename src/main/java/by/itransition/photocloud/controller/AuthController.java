package by.itransition.photocloud.controller;

import by.itransition.photocloud.auth.dto.UserDto;
import by.itransition.photocloud.auth.events.OnRegistrationCompleteEvent;
import by.itransition.photocloud.auth.model.User;
import by.itransition.photocloud.auth.model.VerificationToken;
import by.itransition.photocloud.auth.service.IUserService;
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
        User registeredUser = new User();
        if (!result.hasErrors()) {
            registeredUser = createUser(user, result);
            try {
                String appUrl = request.getContextPath();
                eventPublisher.publishEvent(new OnRegistrationCompleteEvent
                        (registeredUser, appUrl, request.getLocale()));
            } catch (Exception ex) {
                System.out.println("LOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOL\nLOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOl\n\n\n\n");
                System.out.println(ex);
                ex.printStackTrace();


                return "auth/emailError";
            }
        }
        if (registeredUser == null) {
            result.rejectValue("email", "Loh pizdets email lalka"); // TODO messages in separate file
        }
        model.addAttribute(user);
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
        return "redirect:/login?lang=" + locale.getLanguage();
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
