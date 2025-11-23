package br.unitins.topicos1.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import br.unitins.topicos1.dto.DadosGraficoDTO;
import br.unitins.topicos1.dto.LeituraPiezoDTO;
import br.unitins.topicos1.dto.LeituraPiezoResponseDTO;
import br.unitins.topicos1.model.LeituraPiezo;
import br.unitins.topicos1.repository.LeituraPiezoRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;

@ApplicationScoped
public class LeituraPiezoServiceImpl implements LeituraPiezoService {

    @Inject
    LeituraPiezoRepository leituraPiezoRepository;

    @Override
    @Transactional
    public LeituraPiezoResponseDTO registrarLeitura(@Valid LeituraPiezoDTO dto) {
        LeituraPiezo leitura = new LeituraPiezo();
        leitura.setValor(dto.valor());
        leitura.setSensorId(dto.sensorId());
        leitura.setDataHora(LocalDateTime.now());

        leituraPiezoRepository.persist(leitura);
        
        return LeituraPiezoResponseDTO.valueOf(leitura);
    }

    @Override
    public DadosGraficoDTO obterDadosUltimos60Segundos(String sensorId) {
        List<LeituraPiezo> leituras = leituraPiezoRepository.findUltimosSegundos(sensorId, 60);
        
        List<LocalDateTime> timestamps = leituras.stream()
                .map(LeituraPiezo::getDataHora)
                .collect(Collectors.toList());
        
        List<BigDecimal> valores = leituras.stream()
                .map(LeituraPiezo::getValor)
                .collect(Collectors.toList());
        
        return DadosGraficoDTO.criar(sensorId, timestamps, valores);
    }
}



