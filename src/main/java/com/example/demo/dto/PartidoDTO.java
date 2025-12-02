package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;
import java.time.LocalTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PartidoDTO {
    private Integer id;
    private Integer ligaId;
    private Short jornada;
    private LocalDate fecha;
    private LocalTime horaInicio;
    private String equipoLocalNombre;
    private String equipoVisitaNombre;
    private Short golesLocal;
    private Short golesVisita;
    private String estado;
}
