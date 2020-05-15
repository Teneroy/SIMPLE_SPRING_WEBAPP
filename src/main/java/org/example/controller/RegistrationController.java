package org.example.controller;

import org.example.domain.User;
import org.example.service.UserService;
import org.example.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
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
    public String addUser(@RequestParam String passwordConfirmation, @Valid User user, BindingResult bindingResult, Model model) {
        boolean confirmIsEmpty = (passwordConfirmation == null || passwordConfirmation.isEmpty());

        System.out.println(confirmIsEmpty);

        if(confirmIsEmpty) {
            model.addAttribute("passwordConfirmationError", "Password confirmation can't be empty");
        }

        if(user.getPassword() != null && !user.getPassword().equals(passwordConfirmation)) {
            model.addAttribute("passwordError", "Passwords are different!");
            return "registration";
        }

        if(bindingResult.hasErrors() || confirmIsEmpty) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);

            return "registration";
        }

        if(!userService.addUser(user)) {
            model.addAttribute("message", "This user has already been created");
            return "registration";
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
