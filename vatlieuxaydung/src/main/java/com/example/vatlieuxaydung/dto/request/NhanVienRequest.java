package com.example.vatlieuxaydung.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor
@AllArgsConstructor
public class NhanVienRequest {
    String ten;
    @Size(min = 2, message = "USERNAME_INVALID")
    String userName;
    @Size(min = 6, message = "PASSWORD_INVALID")
    String password;
    @Email(message = "EMAIL_INVALID")
    String email;
    String diaChi;
    String gioiTinh;
    LocalDate ngaySinh;
    String dienThoai;
    }
