package com.example.vatlieuxaydung.mapper;

import com.example.vatlieuxaydung.dto.request.KhachHangRequest;
import com.example.vatlieuxaydung.dto.response.KhachHangDto;
import com.example.vatlieuxaydung.model.KhachHang;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface KhachHangMapper {
    KhachHang toKhachHang(KhachHangRequest khachHangRequest);
    KhachHangDto toKhachHangDto(KhachHang khachHang);
    List<KhachHangDto> toListKhachHangDto(List<KhachHang> khachHangList);
}
