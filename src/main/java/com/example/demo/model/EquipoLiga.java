package com.example.demo.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "equipos_liga")
@Data
@NoArgsConstructor
@AllArgsConstructor
@IdClass(EquipoLigaId.class)
public class EquipoLiga {
    @Id
    @ManyToOne
    @JoinColumn(name = "liga_id")
    private Liga liga;

    @Id
    @ManyToOne
    @JoinColumn(name = "equipo_id")
    private Equipo equipo;
}
