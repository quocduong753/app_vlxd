package com.example.vatlieuxaydung.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class MuaRequest {
    String maVatTu;
    Double sl;
    Long gia;
}
