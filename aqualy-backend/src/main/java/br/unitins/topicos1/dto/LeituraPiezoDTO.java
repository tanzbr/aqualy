package br.unitins.topicos1.dto;

import java.math.BigDecimal;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record LeituraPiezoDTO(
    @NotNull(message = "O valor da leitura é obrigatório")
    @Positive(message = "O valor deve ser positivo")
    BigDecimal valor,
    
    String sensorId
) {}



