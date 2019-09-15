package com.example.imstagran.controller;

import com.example.imstagran.domain.Message;
import com.example.imstagran.domain.User;
import com.example.imstagran.repos.MessageRepo;
import com.example.imstagran.repos.UserRepo;
import com.example.imstagran.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;
    @Value("${upload.path}")
    private String uploadPath;
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private UserService userService;

    @GetMapping("/")

    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

    @GetMapping("/main")
    public String main(@RequestParam(required = false, defaultValue = "") String filter, Model model) {
        Iterable<Message> msgs;
        if (filter != null && !filter.isEmpty()) {
            msgs = messageRepo.findByTextContains(filter);
        } else {
            msgs = messageRepo.findAll();
        }
        model.addAttribute("messages", msgs);
        model.addAttribute("filter", filter);
        return "main";
    }

    @PostMapping("/main")
    public String add(@AuthenticationPrincipal User user,
                      @Valid Message msg,
                      BindingResult bindingResult,
                      Model model,
                      @RequestParam("file") MultipartFile file) throws IOException {
        msg.setAuthor(user);
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("message", msg);
        } else {
            if (file != null && !file.getOriginalFilename().isEmpty()) {
                File uploadDir = new File(Paths.get(uploadPath).toAbsolutePath().toString()
                        .replace("~", ""));
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                String uuidFile = UUID.randomUUID().toString();
                String resultFileName = uuidFile + "." + file.getOriginalFilename();
                file.transferTo(new File(uploadDir + "/" + resultFileName));
                msg.setFilename(resultFileName);
            }
            model.addAttribute("message", null);
            messageRepo.save(msg);
        }
        Iterable<Message> messages = messageRepo.findAll();
        model.addAttribute("messages", messages);
        return "main";
    }

    @GetMapping("/channel/{username}")
    public String showUserChannel(
            @AuthenticationPrincipal User user,
            @PathVariable String username,
            Model model
    ) {
        User userChannel = userRepo.findByUsername(username);
        Set<Message> messages = userChannel.getMessages();
        boolean isCurrentUser = user.equals(userChannel);
        model.addAttribute("isCurrentUser", isCurrentUser);
        if (!isCurrentUser)
            model.addAttribute("subscribed", userChannel.getSubscribers().contains(user));
        model.addAttribute("username", username);
        model.addAttribute("subscriptions", userChannel.getSubscriptions());
        model.addAttribute("subscribers", userChannel.getSubscribers());
        model.addAttribute("messages", messages);
        return "userChannel";
    }

    @PostMapping("/subscribe")
    public String subscribe(
            @AuthenticationPrincipal User user,
            @RequestParam String channel
    ) {
        User userChannel = userRepo.findByUsername(channel);
        userService.addSubscription(user, userChannel);
        return "redirect:/channel/" + channel;
    }



    @PostMapping("/unsubscribe")
    public String unsubscribe(
            @AuthenticationPrincipal User user,
            @RequestParam String channel
    ) {
        User userChannel = userRepo.findByUsername(channel);
        userService.removeSubscription(user, userChannel);
        return "redirect:/channel/" + channel;
    }

    @GetMapping("channel/{username}/{type}")
    public String listSubs(
            @PathVariable String username,
            @PathVariable String type,
            Model model
    ){
        User channel=userRepo.findByUsername(username);
        if(type.equals("subscribers"))
            model.addAttribute("subs",channel.getSubscribers());
        else
            model.addAttribute("subs",channel.getSubscriptions());
        return "listSubs";
    }
}