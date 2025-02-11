package com.example.vatlieuxaydung.service;

import com.example.vatlieuxaydung.dto.request.LoginRequest;
import com.example.vatlieuxaydung.dto.request.NhanVienRequest;
import com.example.vatlieuxaydung.dto.response.AuthenticationResponse;
import com.example.vatlieuxaydung.dto.response.NhanVienDto;
import com.example.vatlieuxaydung.exeption.AppException;
import com.example.vatlieuxaydung.exeption.ErrorCode;
import com.example.vatlieuxaydung.mapper.NhanVienMapper;
import com.example.vatlieuxaydung.model.NhanVien;
import com.example.vatlieuxaydung.repository.NhanVienRepository;
import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE)
public class NhanVienService {
    @Autowired
     NhanVienRepository nhanVienRepository;

    @Autowired
    NhanVienMapper nhanVienMapper;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    JwtService jwtService;

    @NonFinal
    public NhanVienDto getNhanVien(String username) {
        NhanVien nhanVien = nhanVienRepository.findNhanVienByUserName(username);
        if(nhanVien == null) {
            throw new AppException(ErrorCode.RESOURCE_NOT_FOUND);
        }
        return nhanVienMapper.toNhanVienDto(nhanVien);
    }

    public List<NhanVienDto> getAllNhanVien(String username) {
        NhanVien nhanVien = nhanVienRepository.findNhanVienByUserName(username);
        if(nhanVien == null) {
            throw new AppException(ErrorCode.RESOURCE_NOT_FOUND);
        }
        if(!nhanVien.isAdmin()){
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }
        return nhanVienMapper.toListNhanVienDto(nhanVienRepository.findAll());
    }

    public NhanVienDto createNhanVien(NhanVienRequest request, String userAdmin) {
        NhanVien admin = nhanVienRepository.findNhanVienByUserName(userAdmin);
        if(admin == null || !admin.isAdmin()) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }
        if(nhanVienRepository.existsNhanVienByUserName(request.getUserName())){
            throw new AppException(ErrorCode.USERNAME_ALREADY_EXISTS);
        }
        NhanVien nhanVien = nhanVienMapper.toNhanVien(request);
        nhanVien.setPassword(passwordEncoder.encode(request.getPassword()));
        nhanVienRepository.save(nhanVien);
        return nhanVienMapper.toNhanVienDto(nhanVien);
    }

    public AuthenticationResponse loginNhanVien(LoginRequest request) {
        NhanVien nhanVien = nhanVienRepository.findNhanVienByUserName(request.getUserName());
        if(nhanVien == null) {
            throw new AppException(ErrorCode.USERNAME_NOT_FOUND);
        }
        boolean isPass = passwordEncoder.matches(request.getPass(), nhanVien.getPassword());
        if (!isPass){
            throw new AppException(ErrorCode.PASSWORD_INCORRECT);
        }
        var token = jwtService.GenerateToken(request.getUserName());
        return new AuthenticationResponse(token, true);
    }

}
