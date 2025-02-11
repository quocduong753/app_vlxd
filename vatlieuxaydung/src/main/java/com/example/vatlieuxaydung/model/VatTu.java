package com.example.vatlieuxaydung.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity(name = "vattu")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class VatTu {
    @Id
    @Column(name = "Ma", columnDefinition = "CHAR(30)")
    String ma;
    @Column(name = "Ten")
    String ten;
    @Column(name = "DVT")
    String dvt;
    @Column(name = "dongia")
    Double donGia;
    String image;
    @ManyToOne
    @JoinColumn(name="LoaiVT")
    @JsonIgnoreProperties("dsVatTu")
    LoaiVT loaivt;

}
