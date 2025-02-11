package com.example.vatlieuxaydung.service;

import com.example.vatlieuxaydung.dto.response.LoaiVTDto;
import com.example.vatlieuxaydung.exeption.AppException;
import com.example.vatlieuxaydung.exeption.ErrorCode;
import com.example.vatlieuxaydung.model.LoaiVT;
import com.example.vatlieuxaydung.model.VatTu;
import com.example.vatlieuxaydung.repository.VatTuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VatTuService {
    @Autowired
    private VatTuRepository vatTuRepository;
    public List<VatTu> getAllVT() {
        List<VatTu> VTList = vatTuRepository.findAll();
        return  VTList;
    }

    public VatTu getVTById(String id) {
        return vatTuRepository.findById(id).orElseThrow(()->new AppException(ErrorCode.RESOURCE_NOT_FOUND));
    }

    public VatTu UpdateVatTu(VatTu VTupdate) {
        return vatTuRepository.save(VTupdate);
    }

    public void deleteVT(String id) {
        VatTu vatTu = getVTById(id);
//        if(!vatTu.getDsVatTu().isEmpty()) throw new AppException(ErrorCode.CATEGORY_CONTAINS_PRODUCTS);
        vatTuRepository.delete(vatTu);    }

    public VatTu createVT(VatTu vatTu) {
        if(vatTuRepository.existsById(vatTu.getMa()))
            throw new AppException(ErrorCode.VATTU_ALREADY_EXISTS);
        return vatTuRepository.save(vatTu);
    }

    public List<VatTu> searchVT(String keyword) {
        List<VatTu> dsVt = vatTuRepository.searchVT(keyword);
        if (dsVt.isEmpty()) throw new AppException(ErrorCode.RESOURCE_NOT_FOUND);
        return dsVt;
    }
}
