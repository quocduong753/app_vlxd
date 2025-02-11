package com.example.vatlieuxaydung.dto.response;

import com.example.vatlieuxaydung.model.VatTu;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor
@AllArgsConstructor
public class MuaDto {
    VatTu vatTu;
    Double sl;
    Long gia;
}
