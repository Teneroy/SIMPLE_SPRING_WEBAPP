package org.example.controller;

import org.example.domain.Role;
import org.example.domain.User;
import org.example.repos.UserRepo;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {
    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("message", "");
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(User user, Model model) {
        if(!userService.addUser(user)) {
            model.addAttribute("message", "This user has already been created");
            return "redirect:/registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActivated = userService.activateUser(code);

        if(isActivated) {
            model.addAttribute("message", "User was activated");
        } else {
            model.addAttribute("message", "Activation code was not found");
        }

        return "login";
    }
}
