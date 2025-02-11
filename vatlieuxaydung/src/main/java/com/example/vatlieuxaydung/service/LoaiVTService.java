package com.example.vatlieuxaydung.service;

import com.example.vatlieuxaydung.dto.response.LoaiVTDto;
import com.example.vatlieuxaydung.exeption.AppException;
import com.example.vatlieuxaydung.exeption.ErrorCode;
import com.example.vatlieuxaydung.mapper.LoaiVTMapper;
import com.example.vatlieuxaydung.model.LoaiVT;
import com.example.vatlieuxaydung.model.VatTu;
import com.example.vatlieuxaydung.repository.LoaiVTRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LoaiVTService {
    @Autowired
    private LoaiVTRepository loaiVTRepository;

    @Autowired
    LoaiVTMapper loaiVTMapper;

    public List<LoaiVT> getAllLoaiVT() {
        List<LoaiVT> loaiVTList = loaiVTRepository.findAll();
        return  loaiVTList;
    }

    public LoaiVT getLoaiVTById(String id) {
        return loaiVTRepository.findById(id).orElseThrow(()->new AppException(ErrorCode.RESOURCE_NOT_FOUND));
    }

    public LoaiVTDto UpdateLoaiVT(LoaiVT loaiVT) {
        LoaiVT loai = getLoaiVTById(loaiVT.getMa());
        loai.setTenLoai(loaiVT.getTenLoai());
        loai = loaiVTRepository.save(loai);
        return loaiVTMapper.toLoaiVTDto(loai);
    }

    public void deleteLoaiVT(String id) {
        LoaiVT loaiVT = getLoaiVTById(id);
        if(!loaiVT.getDsVatTu().isEmpty()) throw new AppException(ErrorCode.CATEGORY_CONTAINS_PRODUCTS);
        loaiVTRepository.deleteById(id);
    }

    public LoaiVT createLoaiVT(LoaiVT loaiVT) {
        if(loaiVTRepository.existsById(loaiVT.getMa())) { throw new AppException(ErrorCode.VATTU_ALREADY_EXISTS); }
        return loaiVTRepository.save(loaiVT);
    }

    public List<LoaiVT> searchLoaiVT(String keyword) {
        List<LoaiVT> dsLoaiVt = loaiVTRepository.searchLoaiVT(keyword);
        if(dsLoaiVt.isEmpty()) throw new AppException(ErrorCode.RESOURCE_NOT_FOUND);
        return dsLoaiVt;
    }
}
