package com.example.demo.repository;

import com.example.demo.model.EquipoLiga;
import com.example.demo.model.EquipoLigaId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EquipoLigaRepository extends JpaRepository<EquipoLiga, EquipoLigaId> {
}
