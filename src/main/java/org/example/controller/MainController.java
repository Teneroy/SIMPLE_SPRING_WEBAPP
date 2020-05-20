package org.example.controller;

import org.example.utils.ControllerUtils;
import org.example.utils.FileUtils;
import org.example.domain.Message;
import org.example.domain.Role;
import org.example.domain.User;
import org.example.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Model model) {
        return "greeting";
    }

    @GetMapping("/error")
    public String error(Model model) {

        return "error";
    }

    @GetMapping("/main")
    public String main(@AuthenticationPrincipal User user, @RequestParam(required = false, defaultValue = "") String filter, Model model) {
        Iterable<Message> messages = (filter.isEmpty() ? messageRepo.findAll() : messageRepo.findByTag(filter));
        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);
        model.addAttribute("admin", ControllerUtils.getRole(user));
        return "main";
    }

    @PostMapping("/main")
    public String add(@AuthenticationPrincipal User user, @Valid Message message, BindingResult bindingResult, Model model, @RequestParam("file") MultipartFile file) {
        message.setAuthor(user);

        if(bindingResult.hasErrors()) {
            System.out.println("hasErrors");
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            System.out.println(errorsMap.toString());
            model.mergeAttributes(errorsMap);
            model.addAttribute("message", message);
        } else {
            if(file != null ) {
                String resultFilename = FileUtils.uploadFile(uploadPath, file);
                if (!resultFilename.isEmpty())
                    message.setFilename(resultFilename);
            }

            model.addAttribute("message", null);

            messageRepo.save(message);
        }

        Iterable<Message> messages = messageRepo.findAll();
        model.addAttribute("messages", messages);
        model.addAttribute("admin", ControllerUtils.getRole(user));

        return "main";
    }

    @GetMapping("/user-messages/{user}")
    public String userMessages(
        @AuthenticationPrincipal User currentUser,
        @PathVariable User user,
        Model model
    ) {
        Set<Message> messages = user.getMessages();

        model.addAttribute("messages", messages);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        model.addAttribute("admin", ControllerUtils.getRole(user));

        return "userMessages";
    }
}
