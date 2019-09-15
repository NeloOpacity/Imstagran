package com.example.imstagran.controller;

import org.springframework.validation.BindingResult;

import java.util.Map;
import java.util.stream.Collectors;

public class ControllerUtils {

    static Map<String, String> getErrors(BindingResult bindingResult) {
        Map<String, String> errorsMap = bindingResult.getFieldErrors().stream().collect(Collectors.toMap(
                fieldError -> fieldError.getField() + "Error",
                fieldError -> fieldError.getDefaultMessage()
        ));
        return errorsMap;
    }
}
