package br.unitins.topicos1.service;

import br.unitins.topicos1.dto.DadosGraficoDTO;
import br.unitins.topicos1.dto.LeituraPiezoDTO;
import br.unitins.topicos1.dto.LeituraPiezoResponseDTO;
import jakarta.validation.Valid;

public interface LeituraPiezoService {
    LeituraPiezoResponseDTO registrarLeitura(@Valid LeituraPiezoDTO dto);
    DadosGraficoDTO obterDadosUltimos60Segundos(String sensorId);
}



