package com.example.vatlieuxaydung.controller;


import com.example.vatlieuxaydung.dto.common.ApiResponse;
import com.example.vatlieuxaydung.dto.response.LoaiVTDto;
import com.example.vatlieuxaydung.model.LoaiVT;
import com.example.vatlieuxaydung.service.LoaiVTService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/vatlieuxaydung/LoaiVT")
public class LoaiVTController {
    @Autowired
    LoaiVTService loaiVTService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<LoaiVT>>> getAllLoaiVT() {
        List<LoaiVT> dsloaiVT = loaiVTService.getAllLoaiVT();
        ApiResponse<List<LoaiVT>> response = new ApiResponse<>(dsloaiVT);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<LoaiVT>> getLoaiVTById(@PathVariable("id") String id) {
        LoaiVT loaiVT = loaiVTService.getLoaiVTById(id);
        ApiResponse<LoaiVT> response = new ApiResponse<>(loaiVT);
        return ResponseEntity.ok(response);
    }
    @PutMapping
    public ResponseEntity<ApiResponse<LoaiVTDto>> updateLoaiVT(@RequestBody LoaiVT loaiVT) {
        LoaiVTDto loaiDto = loaiVTService.UpdateLoaiVT(loaiVT);
        ApiResponse<LoaiVTDto> response = new ApiResponse<>(loaiDto);
        return ResponseEntity.ok(response);
    }

    @PostMapping
    public ResponseEntity<ApiResponse<LoaiVT>> createLoaiVT(@RequestBody LoaiVT loaiVT) {
        LoaiVT vt = loaiVTService.createLoaiVT(loaiVT);
        ApiResponse<LoaiVT> response = new ApiResponse<>(vt);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/search")
    public ResponseEntity<ApiResponse<List<LoaiVT>>> searchLoaiVT(
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
        List<LoaiVT> result = loaiVTService.searchLoaiVT(keyword);
        ApiResponse<List<LoaiVT>> response = new ApiResponse<>(result);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteLoaiVT(@PathVariable String id) {
        loaiVTService.deleteLoaiVT(id);
        ApiResponse<Void> response = new ApiResponse<>(null);
        return ResponseEntity.ok(response);
    }
}
