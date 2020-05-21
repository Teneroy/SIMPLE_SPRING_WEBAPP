package org.example.controller;

import org.example.domain.Message;
import org.example.domain.User;
import org.example.repos.MessageRepo;
import org.example.utils.ControllerUtils;
import org.example.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Set;

@Controller
@RequestMapping("/user-messages")
public class MessagesController {
    @Autowired
    private MessageRepo messageRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("{user}")
    public String userMessages(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam(required = false) Message message
    ) {
        Set<Message> messages = user.getMessages();

        model.addAttribute("userChannel", user);
        model.addAttribute("subscriptionsCount", user.getSubscriptions().size());
        model.addAttribute("subscribersCount", user.getSubscribers().size());
        model.addAttribute("isSubscriber", user.getSubscribers().contains(currentUser));
        model.addAttribute("messages", messages);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        model.addAttribute("admin", ControllerUtils.getRole(user));
        model.addAttribute("message", message);

        return "userMessages";
    }

    @PostMapping("{user}")
    public String updateMessage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam("id") Message message,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            @RequestParam("file") MultipartFile file
    ) {
        if(!message.getAuthor().equals(currentUser))
            return "redirect:/user-messages/" + user;

        if(file != null ) {
            String resultFilename = FileUtils.uploadFile(uploadPath, file);
            if (!resultFilename.isEmpty())
                message.setFilename(resultFilename);
        }

        if(text != null && !text.isEmpty()) {
            message.setText(text);
        }

        if(tag != null && !tag.isEmpty()) {
            message.setTag(tag);
        }

        messageRepo.save(message);

        return "redirect:/user-messages/" + user;
    }
}
