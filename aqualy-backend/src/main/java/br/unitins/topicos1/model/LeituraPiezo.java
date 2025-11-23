package br.unitins.topicos1.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;

@Entity
public class LeituraPiezo extends DefaultEntity {
    
    @Column(precision = 10, scale = 3, nullable = false)
    private BigDecimal valor;
    
    @Column(name = "valor_newtons", precision = 10, scale = 3, nullable = false)
    private BigDecimal valorNewtons;
    
    @Column(name = "data_hora", nullable = false)
    private LocalDateTime dataHora;
    
    @Column(name = "sensor_id", length = 255)
    private String sensorId;

    public BigDecimal getValor() {
        return valor;
    }

    public void setValor(BigDecimal valor) {
        this.valor = valor;
    }

    public BigDecimal getValorNewtons() {
        return valorNewtons;
    }

    public void setValorNewtons(BigDecimal valorNewtons) {
        this.valorNewtons = valorNewtons;
    }

    public LocalDateTime getDataHora() {
        return dataHora;
    }

    public void setDataHora(LocalDateTime dataHora) {
        this.dataHora = dataHora;
    }

    public String getSensorId() {
        return sensorId;
    }

    public void setSensorId(String sensorId) {
        this.sensorId = sensorId;
    }
}



