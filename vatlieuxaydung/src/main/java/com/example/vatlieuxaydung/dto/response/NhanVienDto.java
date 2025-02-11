package com.example.vatlieuxaydung.dto.response;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor
@AllArgsConstructor
public class NhanVienDto {
    String ma;
    String ten;
    String userName;
    String email;
    String diaChi;
    String gioiTinh;
    LocalDate ngaySinh;
    String dienThoai;
    boolean isAdmin;
}
