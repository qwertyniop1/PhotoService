package by.itransition.photocloud.service;

import by.itransition.photocloud.persistance.dao.UserDao;
import by.itransition.photocloud.persistance.dao.UserRoleDao;
import by.itransition.photocloud.persistance.dao.VerificationTokenDao;
import by.itransition.photocloud.persistance.dto.UserDto;
import by.itransition.photocloud.persistance.model.User;
import by.itransition.photocloud.persistance.model.VerificationToken;
import by.itransition.photocloud.validators.EmailExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;

@Transactional
@Service
public class UserService implements IUserService {

    @Autowired
    private UserDao userRepository;

    @Autowired
    private VerificationTokenDao tokenRepository;

    @Autowired
    private UserRoleDao roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

//    @Transactional
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
        user.setEnabled(false);
        user.setUserRoles(new HashSet<>(roleRepository.findByRole("ROLE_USER")));
        return userRepository.save(user);
    }

    @Override
    public User getUser(String verificationToken) {
        return tokenRepository.findByToken(verificationToken).getUser();
    }

    @Override
    public void saveRegisteredUser(User user) {
        userRepository.save(user);
    }

    @Override
    public VerificationToken getVerificationToken(String token) {
        return tokenRepository.findByToken(token);
    }

    @Override
    public void createVerificationToken(User user, String token) {
        tokenRepository.save(new VerificationToken(user, token));
    }

    private boolean emailExist(String email) {
        User user = userRepository.findByEmail(email);
        return user != null;
    }
}
