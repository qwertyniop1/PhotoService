package by.itransition.photocloud.service;

import by.itransition.photocloud.persistance.dto.UserDto;
import by.itransition.photocloud.persistance.model.User;
import by.itransition.photocloud.persistance.model.VerificationToken;
import by.itransition.photocloud.validators.EmailExistException;

public interface IUserService {

    User registerNewUser(UserDto user) throws EmailExistException;

    User getUser(String verificationToken);

    void saveRegisteredUser(User user);

    VerificationToken getVerificationToken(String token);

    void createVerificationToken(User user, String token);

}
