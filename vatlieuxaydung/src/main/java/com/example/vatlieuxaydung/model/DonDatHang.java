package com.example.vatlieuxaydung.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "dondathang")
public class DonDatHang {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "ma", columnDefinition = "CHAR(36)")
    String ma;
    Date ngayDat;
    String diaChiGiaoHang;
    Long tongTien;
    boolean trangThai;

    @ManyToOne
    @JoinColumn(name = "ma_kh", referencedColumnName = "ma_KH", nullable = false)
    KhachHang khachHang;

    @OneToMany(mappedBy = "donDatHang")
    @JsonIgnoreProperties("donDatHang")
    List<Mua> muaList = new ArrayList<>();
}
