package com.example.demo.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "partidos")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Partido {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "liga_id", nullable = false)
    private Integer ligaId;

    @Column(nullable = false)
    private Short jornada;

    @Column(nullable = false)
    private LocalDate fecha;

    @Column(name = "hora_inicio", nullable = false)
    private LocalTime horaInicio;

    @Column(name = "equipo_local_id", nullable = false)
    private Integer equipoLocalId;

    @Column(name = "equipo_visita_id", nullable = false)
    private Integer equipoVisitaId;

    @Column(name = "goles_local")
    private Short golesLocal;

    @Column(name = "goles_visita")
    private Short golesVisita;

    @Column(length = 20)
    private String estado;

    // Relaciones
    @ManyToOne
    @JoinColumn(name = "equipo_local_id", insertable = false, updatable = false)
    private Equipo equipoLocal;

    @ManyToOne
    @JoinColumn(name = "equipo_visita_id", insertable = false, updatable = false)
    private Equipo equipoVisita;

    @ManyToOne
    @JoinColumn(name = "liga_id", insertable = false, updatable = false)
    private Liga liga;
}
