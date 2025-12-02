package com.example.demo.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "equipos")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Equipo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, unique = true, length = 100)
    private String nombre;

    @Column(name = "anio_fundacion", nullable = false)
    private Short anioFundacion;

    @Column(name = "comuna_local", nullable = false, length = 80)
    private String comunaLocal;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String historia;
}
