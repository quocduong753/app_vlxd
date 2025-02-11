package com.example.vatlieuxaydung.controller;

import com.example.vatlieuxaydung.dto.common.ApiResponse;
import com.example.vatlieuxaydung.dto.response.LoaiVTDto;
import com.example.vatlieuxaydung.model.LoaiVT;
import com.example.vatlieuxaydung.model.VatTu;
import com.example.vatlieuxaydung.service.VatTuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/vatlieuxaydung/vattu")
public class VatTuController {
    @Autowired
    VatTuService vatTuService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<VatTu>>> getAllVatTu() {
        List<VatTu> dsVT = vatTuService.getAllVT();
        ApiResponse<List<VatTu>> response = new ApiResponse<>(dsVT);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<VatTu>> getVTById(@PathVariable("id") String id) {
        VatTu vatTu = vatTuService.getVTById(id);
        ApiResponse<VatTu> response = new ApiResponse<>(vatTu);
        return ResponseEntity.ok(response);
    }
    @PutMapping
    public ResponseEntity<ApiResponse<VatTu>> updateVT(@RequestBody VatTu VT) {
        VatTu vatTu = vatTuService.UpdateVatTu(VT);
        ApiResponse<VatTu> response = new ApiResponse<>(vatTu);
        return ResponseEntity.ok(response);
    }

    @PostMapping
    public ResponseEntity<ApiResponse<VatTu>> createVT(@RequestBody VatTu vatTu) {
        VatTu vt = vatTuService.createVT(vatTu);
        ApiResponse<VatTu> response = new ApiResponse<>(vt);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/search")
    public ResponseEntity<ApiResponse<List<VatTu>>> searchVT(
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
        List<VatTu> result = vatTuService.searchVT(keyword);
        ApiResponse<List<VatTu>> response = new ApiResponse<>(result);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteVT(@PathVariable String id) {
        vatTuService.deleteVT(id);
        ApiResponse<Void> response = new ApiResponse<>(null);
        return ResponseEntity.ok(response);
    }
}
