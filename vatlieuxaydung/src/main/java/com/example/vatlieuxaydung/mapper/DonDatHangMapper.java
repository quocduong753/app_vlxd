package com.example.vatlieuxaydung.mapper;


import com.example.vatlieuxaydung.dto.request.DonDatHangRequest;
import com.example.vatlieuxaydung.dto.response.DonDatHangDto;
import com.example.vatlieuxaydung.model.DonDatHang;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring", uses = KhachHangMapper.class)
public interface DonDatHangMapper {
    DonDatHang toDonDatHang(DonDatHangRequest request);

    @Mapping(source = "khachHang", target = "khachHang")
    @Mapping(source = "muaList", target = "muaList")
    DonDatHangDto toDonDatHangResponse(DonDatHang donDatHang);

    @Mapping(source = "khachHang", target = "khachHang")
    @Mapping(source = "muaList", target = "muaList")
    List<DonDatHangDto> toListDonDatHangResponse(List<DonDatHang> donDatHang);
}