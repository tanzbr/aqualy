package br.unitins.topicos1.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import br.unitins.topicos1.model.LeituraPiezo;

public record LeituraPiezoResponseDTO(
    Long id,
    BigDecimal valor,
    LocalDateTime dataHora,
    String sensorId
) {
    public static LeituraPiezoResponseDTO valueOf(LeituraPiezo leitura) {
        return new LeituraPiezoResponseDTO(
            leitura.getId(),
            leitura.getValor(),
            leitura.getDataHora(),
            leitura.getSensorId()
        );
    }
}



