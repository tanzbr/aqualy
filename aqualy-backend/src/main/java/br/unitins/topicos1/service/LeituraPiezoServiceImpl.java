package br.unitins.topicos1.service;

import java.time.LocalDateTime;

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
}



