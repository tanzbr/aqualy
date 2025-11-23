package br.unitins.topicos1.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

public record DadosGraficoDTO(
    String sensorId,
    
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    List<LocalDateTime> timestamps,
    
    List<BigDecimal> valores,
    
    Integer totalLeituras
) {
    public static DadosGraficoDTO criar(String sensorId, List<LocalDateTime> timestamps, List<BigDecimal> valores) {
        return new DadosGraficoDTO(sensorId, timestamps, valores, valores.size());
    }
}

