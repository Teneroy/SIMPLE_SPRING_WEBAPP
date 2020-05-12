package org.example.controller;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
        model.addAttribute("admin", (user.getRoles().contains(Role.ADMIN) ? "ADMIN" : "USER"));
        return "main";
    }

    @PostMapping("/main")
    public String add(@AuthenticationPrincipal User user, @RequestParam String text, @RequestParam String tag, Model model, @RequestParam("file") MultipartFile file) {
        if(text.isEmpty() || tag.isEmpty()) {
            return main(user, "", model);
        }
        Message message = new Message(text, tag, user);
        if(file != null) {
            String resultFilename = FileUtils.uploadFile(uploadPath, file);
            if (!resultFilename.isEmpty())
                message.setFilename(resultFilename);
        }
        messageRepo.save(message);
        Iterable<Message> messages = messageRepo.findAll();
        model.addAttribute("messages", messages);
        model.addAttribute("admin", (user.getRoles().contains(Role.ADMIN) ? "ADMIN" : "USER"));
        return "redirect:/main";
    }
}
