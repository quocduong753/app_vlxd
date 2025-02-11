package com.example.vatlieuxaydung.repository;

import com.example.vatlieuxaydung.model.Mua;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MuaRepository extends JpaRepository<Mua, String> {
    
}
