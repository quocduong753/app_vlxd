package com.example.vatlieuxaydung.repository;

import com.example.vatlieuxaydung.model.LoaiVT;
import com.example.vatlieuxaydung.model.VatTu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VatTuRepository extends JpaRepository<VatTu, String> {
    @Query(""" 
        SELECT distinct vt FROM vattu vt 
        left join vt.loaivt l
        where lower(vt.ma) like  lower(concat('%',:keyword,'%'))
                                          or lower(vt.ten) like  lower(concat('%',:keyword,'%'))
                                          or lower(l.tenLoai) like  lower(concat('%',:keyword,'%'))
                                          
    """)
    List<VatTu> searchVT(String keyword);
}
