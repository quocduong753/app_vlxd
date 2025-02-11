package com.example.vatlieuxaydung.repository;

import com.example.vatlieuxaydung.model.KhachHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface KhachHangRepository extends JpaRepository<KhachHang, String> {
    KhachHang findOneByUserName(String userName);
    Boolean existsKhachHangByUserName(String userName);
    KhachHang findOneByMaKH(String maKH);

    @Query("""
        SELECT DISTINCT kh FROM KhachHang kh
        WHERE LOWER(kh.maKH) LIKE LOWER(CONCAT('%', :keyword, '%'))
           OR LOWER(kh.tenKH) LIKE LOWER(CONCAT('%', :keyword, '%'))
           OR LOWER(kh.userName) LIKE LOWER(CONCAT('%', :keyword, '%'))
           OR LOWER(kh.dienThoai) LIKE LOWER(CONCAT('%', :keyword, '%'))
    """)
    List<KhachHang> searchKhachHang(String keyword);

}
