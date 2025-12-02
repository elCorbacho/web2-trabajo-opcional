package com.example.demo.service;

import com.example.demo.model.Partido;
import com.example.demo.repository.PartidoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;

@Service
public class PartidoService {
    @Autowired
    private PartidoRepository partidoRepository;

    public List<Partido> obtenerPartidosPorFecha(LocalDate fecha) {
        return partidoRepository.findByFecha(fecha);
    }

    public Partido obtenerPartidoPorId(Integer id) {
        return partidoRepository.findById(id).orElse(null);
    }

    public Partido actualizarMarcador(Integer id, Short golesLocal, Short golesVisita) {
        Partido partido = partidoRepository.findById(id).orElse(null);
        if (partido != null) {
            partido.setGolesLocal(golesLocal);
            partido.setGolesVisita(golesVisita);
            partido.setEstado("JUGADO");
            return partidoRepository.save(partido);
        }
        return null;
    }
}
