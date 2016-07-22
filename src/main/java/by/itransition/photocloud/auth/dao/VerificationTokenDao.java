package by.itransition.photocloud.auth.dao;

import by.itransition.photocloud.auth.model.User;
import by.itransition.photocloud.auth.model.VerificationToken;

public interface VerificationTokenDao {

    VerificationToken findByToken(String token);

    VerificationToken findByUser(User user);

    VerificationToken save(VerificationToken token);

}
