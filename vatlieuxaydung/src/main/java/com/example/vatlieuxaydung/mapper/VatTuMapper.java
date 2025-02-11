package com.example.vatlieuxaydung.mapper;

import com.example.vatlieuxaydung.dto.response.LoaiVTDto;
import com.example.vatlieuxaydung.dto.response.VatTuDto;
import com.example.vatlieuxaydung.model.LoaiVT;
import com.example.vatlieuxaydung.model.VatTu;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface VatTuMapper {
    VatTu toVatTu(VatTuDto vatTuDto);
    VatTuDto toVatTuDto(VatTu vatTu);
    void updateVatTu(@MappingTarget VatTu vatTu , VatTuDto vatTuDto);
}
