package br.unitins.topicos1.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import br.unitins.topicos1.dto.DadosGraficoDTO;
import br.unitins.topicos1.dto.LeituraPiezoDTO;
import br.unitins.topicos1.dto.LeituraPiezoResponseDTO;
import br.unitins.topicos1.model.LeituraPiezo;
import br.unitins.topicos1.repository.LeituraPiezoRepository;
import io.quarkus.narayana.jta.QuarkusTransaction;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.context.control.ActivateRequestContext;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;

@ApplicationScoped
public class LeituraPiezoServiceImpl implements LeituraPiezoService {

    @Inject
    LeituraPiezoRepository leituraPiezoRepository;
    
    // Coeficiente piezoelétrico fictício para conversão de voltagem (V) para força (N)
    // Material fictício baseado em cerâmica piezoelétrica PZT com sensibilidade de 500 pC/N
    // Considerando capacitância do sensor: 100 nF
    // Fator de conversão: 1 V = 200 N (para simplificar o cálculo)
    private static final BigDecimal COEFICIENTE_PIEZOELETRICO = new BigDecimal("200.0");

    @Override
    @Transactional
    public LeituraPiezoResponseDTO registrarLeitura(@Valid LeituraPiezoDTO dto) {
        LeituraPiezo leitura = new LeituraPiezo();
        leitura.setValor(dto.valor());
        
        // Converte o valor (voltagem) para Newtons usando o coeficiente piezoelétrico
        BigDecimal valorNewtons = dto.valor().multiply(COEFICIENTE_PIEZOELETRICO)
                .setScale(3, RoundingMode.HALF_UP);
        leitura.setValorNewtons(valorNewtons);
        
        leitura.setSensorId(dto.sensorId());
        leitura.setDataHora(LocalDateTime.now());

        leituraPiezoRepository.persist(leitura);
        
        return LeituraPiezoResponseDTO.valueOf(leitura);
    }

    @Override
    @ActivateRequestContext
    public DadosGraficoDTO obterDadosUltimos60Segundos(String sensorId) {
        return QuarkusTransaction.requiringNew().call(() -> {
            List<LeituraPiezo> leituras = leituraPiezoRepository.findUltimosSegundos(sensorId, 60);
            
            List<LocalDateTime> timestamps = leituras.stream()
                    .map(LeituraPiezo::getDataHora)
                    .collect(Collectors.toList());
            
            List<BigDecimal> valores = leituras.stream()
                    .map(LeituraPiezo::getValor)
                    .collect(Collectors.toList());
            
            List<BigDecimal> valoresNewtons = leituras.stream()
                    .map(LeituraPiezo::getValorNewtons)
                    .collect(Collectors.toList());
            
            return DadosGraficoDTO.criar(sensorId, timestamps, valores, valoresNewtons);
        });
    }
}



