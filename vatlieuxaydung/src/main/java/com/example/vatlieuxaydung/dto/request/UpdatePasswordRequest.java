package com.example.vatlieuxaydung.dto.request;


import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UpdatePasswordRequest {
    String oldPassword;
    @Size(min = 6, message = "PASSWORD_INVALID")
    String newPassword;
}
