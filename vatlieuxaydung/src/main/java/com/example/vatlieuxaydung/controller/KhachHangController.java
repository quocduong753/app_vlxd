package com.example.vatlieuxaydung.controller;

import com.example.vatlieuxaydung.dto.common.ApiResponse;
import com.example.vatlieuxaydung.dto.request.LoginRequest;
import com.example.vatlieuxaydung.dto.request.KhachHangRequest;
import com.example.vatlieuxaydung.dto.request.UpdatePasswordRequest;
import com.example.vatlieuxaydung.dto.response.AuthenticationResponse;
import com.example.vatlieuxaydung.dto.response.KhachHangDto;
import com.example.vatlieuxaydung.service.JwtService;
import com.example.vatlieuxaydung.service.KhachHangService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/vatlieuxaydung/khachhang")
public class KhachHangController {
    @Autowired
    private KhachHangService khachHangService;

    @Autowired
    private JwtService jwtService;

    @GetMapping("/getAll")
    public ResponseEntity<ApiResponse< List<KhachHangDto>>>getAllKhachHang(
            @RequestHeader("Authorization") String authorizationHeader
    ) {
        String usernameNhanVien = jwtService.validateAndExtractUsername(authorizationHeader);
        ApiResponse<List<KhachHangDto>> response = new ApiResponse<>();
        response.setResult(khachHangService.getAllKhachHang(usernameNhanVien));
        return ResponseEntity.ok(response);
    }

    @PostMapping("/getKhachHang")
    public ResponseEntity<ApiResponse<KhachHangDto>>getKhachHang(
            @RequestHeader("Authorization") String authorizationHeader
    ) {
        String username = jwtService.validateAndExtractUsername(authorizationHeader);
        System.out.println(username);
        ApiResponse<KhachHangDto> response = new ApiResponse<>();
        response.setResult(khachHangService.getKhachHangUsername(username));
        return ResponseEntity.ok(response);
    }

    @GetMapping("/search")
    public ResponseEntity<ApiResponse<List<KhachHangDto>>> searchKhachHang(
            @RequestHeader("Authorization") String authorizationHeader,
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword
    ){
        String usernameNhanVien = jwtService.validateAndExtractUsername(authorizationHeader);
        ApiResponse<List<KhachHangDto>> response = new ApiResponse<>();
        response.setResult(khachHangService.searchKhachHang(keyword,usernameNhanVien));
        return ResponseEntity.ok(response);
    }

    @PostMapping
    ResponseEntity<ApiResponse<KhachHangDto>> create(@RequestBody @Valid KhachHangRequest khachHangRequest) {
        ApiResponse<KhachHangDto> apiResponse = new ApiResponse<>();
        apiResponse.setResult(khachHangService.AddKhachHang(khachHangRequest));
        return ResponseEntity.ok(apiResponse);
    }

    @PostMapping("/login")
    ResponseEntity<ApiResponse<AuthenticationResponse>> login(@RequestBody @Valid LoginRequest loginRequest) {
        ApiResponse<AuthenticationResponse> apiResponse = new ApiResponse<>();
        apiResponse.setResult(khachHangService.LoginKhachHang(loginRequest));
        return ResponseEntity.ok(apiResponse);
    }

    @PutMapping
    ResponseEntity<ApiResponse<KhachHangDto>> update(
            @RequestBody @Valid KhachHangRequest khachHangRequest,
            @RequestHeader("Authorization") String authorizationHeader) {
        String username = jwtService.validateAndExtractUsername(authorizationHeader);
        ApiResponse<KhachHangDto> apiResponse = new ApiResponse<>();
        apiResponse.setResult(khachHangService.updateKhachHang(khachHangRequest, username));
        return ResponseEntity.ok(apiResponse);
    }

    @PutMapping("/udatePassword")
    ResponseEntity<ApiResponse<String>> updatePassword(
            @RequestBody @Valid UpdatePasswordRequest request,
            @RequestHeader("Authorization") String authorizationHeader){
        String username = jwtService.validateAndExtractUsername(authorizationHeader);
        ApiResponse<String> apiResponse = new ApiResponse<>();
        if(khachHangService.updatePassword(username,request)){
            apiResponse.setResult("true");
        }
        return ResponseEntity.ok(apiResponse);
    }

    @PutMapping("/blockKhachHang")
    ResponseEntity<ApiResponse<KhachHangDto>> blockKhachHang(
            @RequestBody String khachHangId,
            @RequestHeader("Authorization") String authorizationHeader
    ) {
        String usernameAdmin = jwtService.validateAndExtractUsername(authorizationHeader);
        ApiResponse<KhachHangDto> apiResponse = new ApiResponse<>();
        apiResponse.setResult(khachHangService.blockKhachHang(khachHangId,usernameAdmin));
        return ResponseEntity.ok(apiResponse);
    }
}
