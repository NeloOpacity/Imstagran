package com.example.imstagran.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;
import java.nio.file.Paths;

@Configuration
public class MvcConfig implements WebMvcConfigurer {
    @Value("${upload.path}")
    private String uploadPath;


    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/login").setViewName("login");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        File uploadDir = new File(Paths.get(uploadPath).toAbsolutePath().toString().replace("~", ""));
        registry.addResourceHandler("/img/**")
                .addResourceLocations("file:///" + uploadDir + "/");

        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:static/");
    }
}
