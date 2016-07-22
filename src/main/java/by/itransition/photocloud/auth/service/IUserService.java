package by.itransition.photocloud.auth.service;

import by.itransition.photocloud.auth.dto.UserDto;
import by.itransition.photocloud.auth.model.User;
import by.itransition.photocloud.auth.model.VerificationToken;
import by.itransition.photocloud.validators.EmailExistException;

public interface IUserService {

    User registerNewUser(UserDto user) throws EmailExistException;

    User getUser(String verificationToken);

    void saveRegisteredUser(User user);

    VerificationToken getVerificationToken(String token);

    void createVerificationToken(User user, String token);

}
