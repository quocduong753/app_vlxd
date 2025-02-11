package com.example.vatlieuxaydung.dto.response;

import com.example.vatlieuxaydung.model.Mua;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor
@AllArgsConstructor



public class DonDatHangDto {
    String ma;
    Date ngayDat;
    String diaChiGiaoHang;
    Long tongTien;
    boolean trangThai;
    KhachHangDto khachHang;
    List<MuaDto> muaList;
}
