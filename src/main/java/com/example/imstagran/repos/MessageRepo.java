package com.example.imstagran.repos;

import com.example.imstagran.domain.Message;
import com.example.imstagran.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MessageRepo extends CrudRepository<Message,Long> {
    List<Message> findByTextContains(String text);
    List<Message> findAllByAuthor(User user);
}
