package com.example.vatlieuxaydung.mapper;

import com.example.vatlieuxaydung.dto.response.MuaDto;
import com.example.vatlieuxaydung.model.Mua;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper
public interface MuaMapper {
    List<MuaDto> toMuaDtoList(List<Mua> muaList);
}
