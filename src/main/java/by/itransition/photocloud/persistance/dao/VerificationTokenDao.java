package by.itransition.photocloud.persistance.dao;

import by.itransition.photocloud.persistance.model.User;
import by.itransition.photocloud.persistance.model.VerificationToken;

public interface VerificationTokenDao {

    VerificationToken findByToken(String token);

    VerificationToken findByUser(User user);

    VerificationToken save(VerificationToken token);

}
