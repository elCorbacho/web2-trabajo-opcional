package com.example.demo.controller;

import com.example.demo.dto.EquipoDTO;
import com.example.demo.dto.ErrorResponseDTO;
import com.example.demo.model.Equipo;
import com.example.demo.service.EquipoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/equipos")
public class EquipoController {
    @Autowired
    private EquipoService equipoService;

    @GetMapping
    public ResponseEntity<List<EquipoDTO>> obtenerTodos() {
        List<Equipo> equipos = equipoService.obtenerTodosLosEquipos();
        List<EquipoDTO> dtos = equipos.stream()
                .map(this::convertirADTO)
                .collect(Collectors.toList());
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/buscar")
    public ResponseEntity<?> buscar(@RequestParam String nombre) {
        List<Equipo> equipos = equipoService.buscarEquiposPorNombre(nombre);
        if (equipos.isEmpty()) {
            ErrorResponseDTO error = new ErrorResponseDTO(
                LocalDateTime.now(),
                404,
                "Not Found",
                "No se encontraron equipos con el nombre: " + nombre,
                "/api/equipos/buscar?nombre=" + nombre
            );
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
        }
        List<EquipoDTO> dtos = equipos.stream()
                .map(this::convertirADTO)
                .collect(Collectors.toList());
        return ResponseEntity.ok(dtos);
    }

    private EquipoDTO convertirADTO(Equipo equipo) {
        EquipoDTO dto = new EquipoDTO();
        dto.setId(equipo.getId());
        dto.setNombre(equipo.getNombre());
        dto.setAnioFundacion(equipo.getAnioFundacion());
        dto.setComunaLocal(equipo.getComunaLocal());
        dto.setHistoria(equipo.getHistoria());
        return dto;
    }
}
