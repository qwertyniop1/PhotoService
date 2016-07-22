package by.itransition.photocloud.auth.service;

import by.itransition.photocloud.auth.dao.UserDao;
import by.itransition.photocloud.auth.dto.UserDto;
import by.itransition.photocloud.auth.model.User;
import by.itransition.photocloud.auth.model.UserRole;
import by.itransition.photocloud.validators.EmailExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;

@Service
public class UserService implements IUserService {

    @Autowired
    private UserDao userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Transactional
    @Override
    public User registerNewUser(UserDto userDto) throws EmailExistException {
        if (emailExist(userDto.getEmail())) {
            throw new EmailExistException("There is an account with that email address: "
                    + userDto.getEmail());
        }
        User user = new User();
        user.setFirstName(userDto.getFirstName());
        user.setLastName(userDto.getLastName());
        user.setPassword(passwordEncoder.encode(userDto.getPassword()));
        user.setEmail(userDto.getEmail());
        user.setEnabled(true);  // TODO DELETE temporaly !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//        user.setUserRole(new HashSet<>(new UserRole()));
        return userRepository.save(user);
    }

    private boolean emailExist(String email) {
        User user = userRepository.findByEmail(email);
        return user != null;
    }
}
