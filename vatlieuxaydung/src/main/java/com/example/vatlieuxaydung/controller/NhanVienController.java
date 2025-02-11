package com.example.vatlieuxaydung.controller;


import com.example.vatlieuxaydung.dto.common.ApiResponse;
import com.example.vatlieuxaydung.dto.request.IntrospectRequest;
import com.example.vatlieuxaydung.dto.request.LoginRequest;
import com.example.vatlieuxaydung.dto.request.NhanVienRequest;
import com.example.vatlieuxaydung.dto.response.AuthenticationResponse;
import com.example.vatlieuxaydung.dto.response.IntrospectResponse;
import com.example.vatlieuxaydung.dto.response.NhanVienDto;
import com.example.vatlieuxaydung.exeption.AppException;
import com.example.vatlieuxaydung.exeption.ErrorCode;
import com.example.vatlieuxaydung.service.JwtService;
import com.example.vatlieuxaydung.service.NhanVienService;
import com.nimbusds.jose.JOSEException;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.List;

@RestController
@RequestMapping("/vatlieuxaydung/nhanvien")
public class NhanVienController {
    @Autowired
    private NhanVienService nhanvienService;

    @Autowired
    private JwtService jwtService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<NhanVienDto>>> getAllNhanVien(
            @RequestHeader("Authorization") String authorizationHeader) {
        String username = jwtService.validateAndExtractUsername(authorizationHeader);
        List<NhanVienDto> nhanVienList = nhanvienService.getAllNhanVien(username);
        ApiResponse<List<NhanVienDto>> response = new ApiResponse<>(nhanVienList);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/getNV")
    public ResponseEntity<ApiResponse<NhanVienDto>> getNhanVien(
            @RequestHeader("Authorization") String authorizationHeader){
        String username = jwtService.validateAndExtractUsername(authorizationHeader);
        ApiResponse<NhanVienDto> response = new ApiResponse<>(nhanvienService.getNhanVien(username));
        return ResponseEntity.ok(response);
    }


    @PostMapping("/login")
    public ResponseEntity<ApiResponse<AuthenticationResponse>> loginNhanVien(
            @RequestBody @Valid LoginRequest request
    ){
        ApiResponse<AuthenticationResponse> response = new ApiResponse<>();
        response.setResult(nhanvienService.loginNhanVien(request));
        return ResponseEntity.ok(response);
    }

    @PostMapping("/create")
    public ResponseEntity<ApiResponse<NhanVienDto>> createNhanVien(
            @RequestHeader("Authorization") String authorizationHeader,@RequestBody @Valid NhanVienRequest request){
        String usernameAdmin = jwtService.validateAndExtractUsername(authorizationHeader);
        ApiResponse<NhanVienDto> response = new ApiResponse<>();
        response.setResult(nhanvienService.createNhanVien(request,usernameAdmin));
        return ResponseEntity.ok(response);
    }
}
