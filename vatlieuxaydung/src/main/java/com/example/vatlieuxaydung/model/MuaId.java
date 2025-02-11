package com.example.vatlieuxaydung.model;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class MuaId implements Serializable {
    String vatTu;
    String donDatHang;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MuaId muaId = (MuaId) o;
        return Objects.equals(vatTu, muaId.vatTu) &&
                Objects.equals(donDatHang, muaId.donDatHang);
    }

    @Override
    public int hashCode() {
        return Objects.hash(vatTu, donDatHang);
    }
}