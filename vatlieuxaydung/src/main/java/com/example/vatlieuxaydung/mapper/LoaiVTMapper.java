package com.example.vatlieuxaydung.mapper;


import com.example.vatlieuxaydung.dto.response.LoaiVTDto;
import com.example.vatlieuxaydung.model.LoaiVT;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface LoaiVTMapper {
    LoaiVT toLoaiVT(LoaiVTDto loaiVTDto);
    LoaiVTDto toLoaiVTDto(LoaiVT loaiVT);

}
