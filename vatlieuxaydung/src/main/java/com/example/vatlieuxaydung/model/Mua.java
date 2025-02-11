package com.example.vatlieuxaydung.model;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "mua")
@IdClass(MuaId.class)
public class Mua {

    @Id
    @ManyToOne
    @JoinColumn(name = "ma_don_dat_hang", columnDefinition = "CHAR(36)",updatable = false)
    @JsonIgnoreProperties("muaList")
    DonDatHang donDatHang;

    @Id
    @ManyToOne
    @JoinColumn(name = "ma_vat_tu", columnDefinition = "CHAR(30)", updatable = false)
    VatTu vatTu;

    Double sl;
    Long gia;
}