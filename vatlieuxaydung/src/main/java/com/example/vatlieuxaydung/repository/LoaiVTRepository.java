package com.example.vatlieuxaydung.repository;

import com.example.vatlieuxaydung.model.LoaiVT;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LoaiVTRepository extends JpaRepository<LoaiVT, String> {

    @Query(""" 
        SELECT distinct vt FROM LoaiVT vt where lower(vt.ma) like  lower(concat('%',:keyword,'%'))
                                          or lower(vt.tenLoai) like  lower(concat('%',:keyword,'%'))
    """)
    List<LoaiVT> searchLoaiVT(String keyword);
}
