package com.example.vatlieuxaydung.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;


@Entity
@Getter
@Setter
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "khachhang")
public class KhachHang {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "ma_KH", columnDefinition = "CHAR(36)")
    String maKH;
    @Column(name = "tenKh")
    String tenKH;
    @Column(name = "userName")
    String userName;
    @Column(name = "email")
    String email;
    @Column(name = "pass")
    String pass;
    @Column(name = "diaChi")
    String diaChi;
    @Column(name = "gioiTinh")
    String gioiTinh;
    @Column(name = "NSinh")
    LocalDate ngaySinh;
    @Column(name = "dienThoai")
    String dienThoai;
    @Column(name = "active")
    boolean active;

    public KhachHang(String maKH, String tenKH, String userName, String email, String pass, String diaChi,
                     String gioiTinh, LocalDate ngaySinh, String dienThoai, boolean active) {
        this.maKH = maKH;
        this.tenKH = tenKH;
        this.userName = userName;
        this.email = email;
        this.pass = pass;
        this.diaChi = diaChi;
        this.gioiTinh = gioiTinh;
        this.ngaySinh = ngaySinh;
        this.dienThoai = dienThoai;
        this.active = active;
    }

    public KhachHang(String tenKH, String userName, String email, String pass, String diaChi,
                     String gioiTinh, LocalDate ngaySinh, String dienThoai, boolean active) {
        this.tenKH = tenKH;
        this.userName = userName;
        this.email = email;
        this.pass = pass;
        this.diaChi = diaChi;
        this.gioiTinh = gioiTinh;
        this.ngaySinh = ngaySinh;
        this.dienThoai = dienThoai;
        this.active = active;
    }
}
