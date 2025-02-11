package com.example.vatlieuxaydung.dto.request;


import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor
@AllArgsConstructor
public class LoginRequest {
    String userName;
    String pass;
}
