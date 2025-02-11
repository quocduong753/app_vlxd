package com.example.vatlieuxaydung.mapper;

import com.example.vatlieuxaydung.dto.request.NhanVienRequest;
import com.example.vatlieuxaydung.dto.response.NhanVienDto;
import com.example.vatlieuxaydung.model.NhanVien;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface NhanVienMapper {
    NhanVienDto toNhanVienDto(NhanVien nhanVien);
    NhanVien toNhanVien(NhanVienRequest request);
    List<NhanVienDto> toListNhanVienDto(List<NhanVien> nhanVien);
}
