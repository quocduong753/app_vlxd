package com.example.vatlieuxaydung.service;

import com.example.vatlieuxaydung.dto.request.LoginRequest;
import com.example.vatlieuxaydung.dto.request.KhachHangRequest;
import com.example.vatlieuxaydung.dto.request.UpdatePasswordRequest;
import com.example.vatlieuxaydung.dto.response.AuthenticationResponse;
import com.example.vatlieuxaydung.dto.response.KhachHangDto;
import com.example.vatlieuxaydung.exeption.AppException;
import com.example.vatlieuxaydung.exeption.ErrorCode;
import com.example.vatlieuxaydung.mapper.KhachHangMapper;
import com.example.vatlieuxaydung.model.KhachHang;
import com.example.vatlieuxaydung.model.NhanVien;
import com.example.vatlieuxaydung.repository.KhachHangRepository;
import com.example.vatlieuxaydung.repository.NhanVienRepository;
import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE)
public class KhachHangService {
    @Autowired
    KhachHangRepository khachHangRepository;

    @Autowired
    NhanVienRepository nhanVienRepository;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    KhachHangMapper khachHangMapper;

    @Autowired
    JwtService jwtService;

    public KhachHangDto getKhachHangUsername(String username) {
        KhachHang kh = khachHangRepository.findOneByUserName(username);
        if (kh == null) {
            throw new AppException(ErrorCode.RESOURCE_NOT_FOUND);
        }
        return khachHangMapper.toKhachHangDto(kh);
    }

    public List<KhachHangDto> getAllKhachHang(String nhanvien) {
        NhanVien nhanVien = nhanVienRepository.findNhanVienByUserName(nhanvien);
        if(nhanVien == null) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }
        return khachHangMapper.toListKhachHangDto(khachHangRepository.findAll());
    }

    public KhachHangDto AddKhachHang(KhachHangRequest khachHangRequest) {
        if(khachHangRepository.existsKhachHangByUserName(khachHangRequest.getUserName())) {
            throw new AppException(ErrorCode.USERNAME_ALREADY_EXISTS);
        }
        KhachHang khachHang = khachHangMapper.toKhachHang(khachHangRequest);
        khachHang.setPass(passwordEncoder.encode(khachHangRequest.getPass()));
        khachHang.setActive(true);
        khachHangRepository.save(khachHang);
        return khachHangMapper.toKhachHangDto(khachHang);
    }

    public AuthenticationResponse LoginKhachHang(LoginRequest loginRequest){
        KhachHang khachHang = khachHangRepository.findOneByUserName(loginRequest.getUserName());
        if(khachHang != null) {
            String password = khachHang.getPass();
            Boolean isPass = passwordEncoder.matches(loginRequest.getPass(), password);
            if(isPass) {
                var token = jwtService.GenerateToken(khachHang.getUserName());
                return new AuthenticationResponse(token, true);
            }
            else {
                throw new AppException(ErrorCode.PASSWORD_INCORRECT);
            }
        }else {
            throw new AppException(ErrorCode.USERNAME_NOT_FOUND);
        }
    }

    public KhachHangDto updateKhachHang(KhachHangRequest request, String username){
        if(!request.getUserName().equals(username)) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }
        KhachHang khachHang = khachHangRepository.findOneByUserName(username);
        khachHang.setEmail(request.getEmail());
        khachHang.setDiaChi(request.getDiaChi());
        khachHang.setGioiTinh(request.getGioiTinh());
        khachHang.setDienThoai(request.getDienThoai());
        khachHang.setTenKH(request.getTenKH());
        khachHang.setNgaySinh(request.getNgaySinh());
        khachHangRepository.save(khachHang);
        return khachHangMapper.toKhachHangDto(khachHang);
    }

    public List<KhachHangDto> searchKhachHang(String keyword, String nhanvien) {
        NhanVien nhanVien = nhanVienRepository.findNhanVienByUserName(nhanvien);
        if(nhanVien == null) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }
        return khachHangMapper.toListKhachHangDto(khachHangRepository.searchKhachHang(keyword));
    }

    public KhachHangDto blockKhachHang(String idKhachHang, String userAdmin){
        NhanVien admin = nhanVienRepository.findNhanVienByUserName(userAdmin);
        if(admin == null) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }
        if(!admin.isAdmin()) throw new AppException(ErrorCode.ACCESS_DENIED);
        KhachHang khachHang = khachHangRepository.findOneByMaKH(idKhachHang);
        if(khachHang == null) {
            throw new AppException(ErrorCode.RESOURCE_NOT_FOUND);
        }
        khachHang.setActive(false);
        khachHangRepository.save(khachHang);
        return khachHangMapper.toKhachHangDto(khachHang);
    }

    public boolean updatePassword(String username, UpdatePasswordRequest request) {
        KhachHang khachHang = khachHangRepository.findOneByUserName(username);
        if(khachHang == null) {
            throw new AppException(ErrorCode.RESOURCE_NOT_FOUND);
        }
        if (!passwordEncoder.matches(request.getOldPassword(), khachHang.getPass())) {
            throw new AppException(ErrorCode.PASSWORD_INCORRECT);
        }
        khachHang.setPass(passwordEncoder.encode(request.getNewPassword()));
        khachHangRepository.save(khachHang);
        return true;

    }
}
