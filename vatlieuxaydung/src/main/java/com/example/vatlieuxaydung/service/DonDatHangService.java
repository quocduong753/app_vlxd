package com.example.vatlieuxaydung.service;


import com.example.vatlieuxaydung.dto.request.DonDatHangRequest;
import com.example.vatlieuxaydung.dto.request.MuaRequest;
import com.example.vatlieuxaydung.dto.response.DonDatHangDto;
import com.example.vatlieuxaydung.exeption.AppException;
import com.example.vatlieuxaydung.exeption.ErrorCode;
import com.example.vatlieuxaydung.mapper.DonDatHangMapper;
import com.example.vatlieuxaydung.model.*;
import com.example.vatlieuxaydung.repository.DonDatHangRepository;
import com.example.vatlieuxaydung.repository.KhachHangRepository;
import com.example.vatlieuxaydung.repository.MuaRepository;
import com.example.vatlieuxaydung.repository.VatTuRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class DonDatHangService {

    @Autowired
    DonDatHangRepository donDatHangRepository;

    @Autowired
    MuaRepository muaRepository;

    @Autowired
    DonDatHangMapper donDatHangMapper;

    @Autowired
    KhachHangRepository khachHangRepository;

    @Autowired
    VatTuRepository vatTuRepository;



    @Transactional
    public DonDatHangDto createDonDatHang(DonDatHangRequest request, String username) {
        KhachHang kh = khachHangRepository.findOneByUserName(username);
        if (kh == null) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }
        DonDatHang donDatHang = donDatHangMapper.toDonDatHang(request);
        donDatHang.setKhachHang(kh);
        donDatHang.setTrangThai(false);
        DonDatHang savedDonDatHang = donDatHangRepository.save(donDatHang);
        List<Mua> ls = new ArrayList<>();
        for (MuaRequest mua : request.getMuaList()) {
            VatTu vt = new VatTu();
            vt.setMa(mua.getMaVatTu());
            Mua m = new Mua(savedDonDatHang, vt, mua.getSl(), mua.getGia());
            ls.add(muaRepository.save(m));
        }
        savedDonDatHang.setMuaList(ls);
        return donDatHangMapper.toDonDatHangResponse(savedDonDatHang);
    }


    public List<DonDatHangDto> getAllDonDatHang() {
        return donDatHangMapper.toListDonDatHangResponse(donDatHangRepository.findAll());
    }

    public List<DonDatHangDto> getDonDatHangByUserName(String username) {
        return donDatHangMapper.toListDonDatHangResponse(donDatHangRepository.findDonDatHangByKhachHang_UserNameOrderByNgayDat(username));
    }
}
