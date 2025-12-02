package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EquipoDTO {
    private Integer id;
    private String nombre;
    private Short anioFundacion;
    private String comunaLocal;
    private String historia;
}
