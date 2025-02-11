package com.example.vatlieuxaydung.repository;

import com.example.vatlieuxaydung.model.DonDatHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DonDatHangRepository extends JpaRepository<DonDatHang, String> {
    List<DonDatHang> findDonDatHangByKhachHang_UserNameOrderByNgayDat(String UserName);
}
