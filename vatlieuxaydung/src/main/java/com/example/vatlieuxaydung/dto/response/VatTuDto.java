package com.example.vatlieuxaydung.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class VatTuDto
{
    String ma;
    String ten;
    String dvt;
    Double donGia;
    String img;

}
