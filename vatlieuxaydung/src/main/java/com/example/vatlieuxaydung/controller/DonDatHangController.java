package com.example.vatlieuxaydung.controller;

import com.example.vatlieuxaydung.dto.common.ApiResponse;
import com.example.vatlieuxaydung.dto.request.DonDatHangRequest;
import com.example.vatlieuxaydung.dto.response.DonDatHangDto;
import com.example.vatlieuxaydung.service.DonDatHangService;
import com.example.vatlieuxaydung.service.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("vatlieuxaydung/dondathang")
public class DonDatHangController {
    @Autowired
    DonDatHangService donDatHangService;

    @Autowired
    private JwtService jwtService;

    @PostMapping
    public ResponseEntity<ApiResponse<DonDatHangDto>> createDonDatHang(
            @RequestBody DonDatHangRequest donDatHang,
            @RequestHeader("Authorization") String authorizationHeader){
        String username = jwtService.validateAndExtractUsername(authorizationHeader);
        ApiResponse<DonDatHangDto> response = new ApiResponse<>();
        response.setResult(donDatHangService.createDonDatHang(donDatHang,username));
        return ResponseEntity.ok(response);
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<DonDatHangDto>>> getAllDonDatHang(){
        ApiResponse<List<DonDatHangDto>> response = new ApiResponse<>();
        response.setResult(donDatHangService.getAllDonDatHang());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/getDonHang")
    public ResponseEntity<ApiResponse<List<DonDatHangDto>>> getDonHang(
            @RequestHeader("Authorization") String authorizationHeader
    ){
        String username = jwtService.validateAndExtractUsername(authorizationHeader);
        ApiResponse<List<DonDatHangDto>> response = new ApiResponse<>();
        response.setResult(donDatHangService.getDonDatHangByUserName(username));
        return ResponseEntity.ok(response);
    }
}
