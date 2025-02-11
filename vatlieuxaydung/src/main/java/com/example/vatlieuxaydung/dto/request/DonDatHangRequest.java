package com.example.vatlieuxaydung.dto.request;


import com.example.vatlieuxaydung.model.Mua;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class DonDatHangRequest {
    String maKh;
    Date ngayDat;
    String diaChiGiaoHang;
    Long tongTien;
    List<MuaRequest> muaList;
}
