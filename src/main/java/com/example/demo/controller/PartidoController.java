package com.example.demo.controller;

import com.example.demo.dto.ErrorResponseDTO;
import com.example.demo.dto.MarcadorDTO;
import com.example.demo.dto.PartidoDTO;
import com.example.demo.model.Partido;
import com.example.demo.service.PartidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/partidos")
public class PartidoController {
    @Autowired
    private PartidoService partidoService;

    @GetMapping
    public ResponseEntity<List<PartidoDTO>> obtenerPartidosPorFecha(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha) {
        List<Partido> partidos = partidoService.obtenerPartidosPorFecha(fecha);
        List<PartidoDTO> dtos = partidos.stream()
                .map(this::convertirADTO)
                .collect(Collectors.toList());
        return ResponseEntity.ok(dtos);
    }

    @PutMapping("/{id}/marcador")
    public ResponseEntity<?> actualizarMarcador(
            @PathVariable Integer id,
            @RequestBody MarcadorDTO marcadorDTO,
            @RequestHeader(required = false) String requestURI) {
        
        // Validar que los goles no sean negativos
        if (marcadorDTO.getGolesLocal() < 0 || marcadorDTO.getGolesVisita() < 0) {
            ErrorResponseDTO error = new ErrorResponseDTO(
                LocalDateTime.now(),
                400,
                "Bad Request",
                "Los valores de goles no pueden ser negativos",
                "/api/partidos/" + id + "/marcador"
            );
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
        }
        
        Partido partido = partidoService.actualizarMarcador(
                id,
                marcadorDTO.getGolesLocal(),
                marcadorDTO.getGolesVisita());
        
        if (partido == null) {
            ErrorResponseDTO error = new ErrorResponseDTO(
                LocalDateTime.now(),
                404,
                "Not Found",
                "Partido no encontrado con ID: " + id,
                "/api/partidos/" + id + "/marcador"
            );
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
        }
        
        return ResponseEntity.ok(convertirADTO(partido));
    }

    private PartidoDTO convertirADTO(Partido partido) {
        PartidoDTO dto = new PartidoDTO();
        dto.setId(partido.getId());
        dto.setLigaId(partido.getLigaId());
        dto.setJornada(partido.getJornada());
        dto.setFecha(partido.getFecha());
        dto.setHoraInicio(partido.getHoraInicio());
        dto.setEquipoLocalNombre(partido.getEquipoLocal() != null ? 
                partido.getEquipoLocal().getNombre() : null);
        dto.setEquipoVisitaNombre(partido.getEquipoVisita() != null ? 
                partido.getEquipoVisita().getNombre() : null);
        dto.setGolesLocal(partido.getGolesLocal());
        dto.setGolesVisita(partido.getGolesVisita());
        dto.setEstado(partido.getEstado());
        return dto;
    }
}
