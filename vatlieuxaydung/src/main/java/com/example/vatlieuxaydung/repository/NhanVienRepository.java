package com.example.vatlieuxaydung.repository;


import com.example.vatlieuxaydung.model.NhanVien;
import jakarta.validation.constraints.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NhanVienRepository extends JpaRepository<NhanVien, String> {
    boolean existsNhanVienByUserName(@Size(min = 2, message = "USERNAME_INVALID") String userName);

    NhanVien findNhanVienByUserName(String userName);
}
