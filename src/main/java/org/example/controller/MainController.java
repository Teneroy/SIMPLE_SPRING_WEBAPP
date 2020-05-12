package org.example.controller;

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

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
    public String add(@AuthenticationPrincipal User user, @RequestParam String text, @RequestParam String tag, Model model, @RequestParam("file") MultipartFile file) throws IOException {
        if(text.isEmpty() || tag.isEmpty()) {
            return main(user, "", model);
        }
        Message message = new Message(text, tag, user);
        if(file != null) {
            File uploadDir = new File(uploadPath);
            boolean mkdirResult = true;

            if(!uploadDir.exists()) {
                mkdirResult = uploadDir.mkdir();
            }

            if(mkdirResult)
            {
                String uuidFile = UUID.randomUUID().toString();
                String resultFilename = uuidFile + "." + file.getOriginalFilename();
                boolean fileUploaded = true;
                try {
                    file.transferTo(new File(uploadPath + "/" + resultFilename));
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    fileUploaded = false;
                }
                if (fileUploaded)
                    message.setFilename(resultFilename);
            }
        }
        messageRepo.save(message);
        Iterable<Message> messages = messageRepo.findAll();
        model.addAttribute("messages", messages);
        model.addAttribute("admin", (user.getRoles().contains(Role.ADMIN) ? "ADMIN" : "USER"));
        return "main";
    }
}
