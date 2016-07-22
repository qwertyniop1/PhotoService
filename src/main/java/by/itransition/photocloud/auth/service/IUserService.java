package by.itransition.photocloud.auth.service;

import by.itransition.photocloud.auth.dto.UserDto;
import by.itransition.photocloud.auth.model.User;
import by.itransition.photocloud.validators.EmailExistException;

public interface IUserService {
    User registerNewUser(UserDto user) throws EmailExistException;
}
