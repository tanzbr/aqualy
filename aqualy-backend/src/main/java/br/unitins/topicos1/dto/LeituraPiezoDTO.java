package br.unitins.topicos1.dto;

import java.math.BigDecimal;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;

public record LeituraPiezoDTO(
    @NotNull(message = "O valor da leitura é obrigatório")
    @PositiveOrZero(message = "O valor deve ser zero ou positivo")
    BigDecimal valor,
    
    String sensorId
) {}



