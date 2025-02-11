package com.example.vatlieuxaydung.model;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor
@AllArgsConstructor
public class NhanVien {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "ma", columnDefinition = "CHAR(36)")
    String ma;
    String ten;
    String userName;
    String email;
    String password;
    String diaChi;
    String gioiTinh;
    LocalDate ngaySinh;
    String dienThoai;
    boolean isAdmin;
}
