package br.unitins.topicos1.repository;

import java.time.LocalDateTime;
import java.util.List;

import br.unitins.topicos1.model.LeituraPiezo;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class LeituraPiezoRepository implements PanacheRepository<LeituraPiezo> {
    
    public List<LeituraPiezo> findBySensorIdAndPeriodo(String sensorId, LocalDateTime inicio, LocalDateTime fim) {
        return find("sensorId = ?1 AND dataHora BETWEEN ?2 AND ?3 ORDER BY dataHora ASC", 
                    sensorId, inicio, fim).list();
    }
    
    public LeituraPiezo findUltimaLeitura(String sensorId) {
        return find("sensorId = ?1 ORDER BY dataHora DESC", sensorId).firstResult();
    }
    
    public List<LeituraPiezo> findAllBySensorId(String sensorId) {
        return find("sensorId = ?1 ORDER BY dataHora DESC", sensorId).list();
    }
    
    public List<LeituraPiezo> findUltimosSegundos(String sensorId, int segundos) {
        LocalDateTime dataLimite = LocalDateTime.now().minusSeconds(segundos);
        return find("sensorId = ?1 AND dataHora >= ?2 ORDER BY dataHora ASC", 
                    sensorId, dataLimite).list();
    }
}



