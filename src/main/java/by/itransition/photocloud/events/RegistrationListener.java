package by.itransition.photocloud.events;

import by.itransition.photocloud.persistance.model.User;
import by.itransition.photocloud.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.MessageSource;
import org.springframework.core.env.Environment;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.UUID;

@Component
public class RegistrationListener implements ApplicationListener<OnRegistrationCompleteEvent> {

    @Autowired
    private IUserService userService;

    @Autowired
    private MessageSource messages;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private Environment environment;

    @Override
    @Async
    public void onApplicationEvent(OnRegistrationCompleteEvent event) {
        try {
            confirmRegistration(event);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    @Async
    private void confirmRegistration(OnRegistrationCompleteEvent event) throws MessagingException {
        User user = event.getUser();
        String token = UUID.randomUUID().toString();
        userService.createVerificationToken(user, token);
        String recipientAddress = user.getEmail();
        String subject = "Itransition Photo cloud";
        String confirmationUrl = event.getApplicationUrl()
                + "/registration-confirm?confirm_token=" + token;
        String message = messages.getMessage("message.registrationConfirm", null, event.getLocale());
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
        helper.setTo(recipientAddress);
        helper.setSubject(subject);
        helper.setText("<html><body>" + "<strong>" + message + "<br><a href='" + confirmationUrl
                + "'>" + confirmationUrl + "</a></body></html>", true);
        helper.setFrom(environment.getProperty("support.email"));
        mailSender.send(mimeMessage);
    }
}
