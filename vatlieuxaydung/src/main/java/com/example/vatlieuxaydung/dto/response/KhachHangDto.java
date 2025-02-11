package com.example.vatlieuxaydung.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor
@AllArgsConstructor
public class KhachHangDto {
    String maKH;
    String tenKH;
    String userName;
    String email;
    String diaChi;
    String gioiTinh;
    LocalDate ngaySinh;
    String dienThoai;
    boolean active;

}
