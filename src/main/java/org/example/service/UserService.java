package org.example.service;

import antlr.StringUtils;
import org.example.domain.Role;
import org.example.domain.User;
import org.example.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailSender mailSender;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepo.findByUsername(username);
    }

    public boolean addUser(User user) {
        User userFromDb = userRepo.findByUsername(user.getUsername());

        if(userFromDb != null) {
            return false;
        }

        user.setActive(false);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);

        sendEmail(user);

        return true;
    }

    private void sendEmail(User user) {
        if(user.getEmail() != null && !user.getEmail().isEmpty()) {
            String message = String.format(
                    "Hello, %s! \n" + "Welcome to our awesome Board application. Please, visit this link to activate your account: http://localhost:8080/activate/%s",
                    user.getUsername(),
                    user.getActivationCode()
            );

            mailSender.send(user.getEmail(), "Activation code", message);
        }
    }

    public boolean activateUser(String code) {
        User user = userRepo.findByActivationCode(code);

        if(user == null)
            return false;

        user.setActive(true);
        user.setActivationCode(null);
        userRepo.save(user);

        return false;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public void saveUser(User user, String username, Map<String, String> form) {
        user.setUsername(username);

        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        form.keySet().forEach(key -> {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        });

        userRepo.save(user);
    }

    public void updateProfile(User user, String password, String email) {
        String userEmail = user.getEmail();

        boolean emailChanged = ((email != null && !email.equals(userEmail)) || (userEmail != null && !userEmail.equals(email)));

        if(emailChanged) {
            user.setEmail(email);

            if(email != null && !email.isEmpty()) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }

        if(password != null && !password.isEmpty()) {
            user.setPassword(password);
        }

        userRepo.save(user);

        if(emailChanged)
        {
            sendEmail(user);
        }
    }
}
