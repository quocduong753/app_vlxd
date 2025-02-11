package com.example.vatlieuxaydung.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class LoaiVT {
    @Id
    @Column(name = "Ma", columnDefinition = "CHAR(30)")
    private String ma;
    @Column(name = "tenloai")
    private String tenLoai;
    @OneToMany(mappedBy = "loaivt")
    @JsonIgnoreProperties("loaivt")
    private List<VatTu> dsVatTu;


}
