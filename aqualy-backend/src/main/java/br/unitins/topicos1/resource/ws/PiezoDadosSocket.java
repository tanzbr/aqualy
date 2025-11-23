package br.unitins.topicos1.resource.ws;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;

import org.jboss.logging.Logger;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import br.unitins.topicos1.dto.DadosGraficoDTO;
import br.unitins.topicos1.service.LeituraPiezoService;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/ws/piezo/dados/{sensorId}")
@ApplicationScoped
public class PiezoDadosSocket {

    private static final Logger LOG = Logger.getLogger(PiezoDadosSocket.class);

    // Mapa de sessões por sensorId - múltiplos clientes podem conectar ao mesmo sensor
    private static final Map<String, Set<Session>> sessions = new ConcurrentHashMap<>();
    
    private static final ObjectMapper objectMapper = new ObjectMapper()
            .registerModule(new JavaTimeModule());

    @Inject
    LeituraPiezoService leituraPiezoService;

    @OnOpen
    public void onOpen(Session session, @PathParam("sensorId") String sensorId) {
        // Adiciona a sessão ao mapa
        sessions.computeIfAbsent(sensorId, k -> ConcurrentHashMap.newKeySet()).add(session);
        
        LOG.infof("Frontend conectado - Sensor ID: %s (Total de clientes conectados: %d)", 
                  sensorId, sessions.get(sensorId).size());
        
        // Envia os dados dos últimos 60 segundos imediatamente de forma assíncrona
        CompletableFuture.runAsync(() -> {
            try {
                DadosGraficoDTO dados = leituraPiezoService.obterDadosUltimos60Segundos(sensorId);
                String json = objectMapper.writeValueAsString(dados);
                
                if (session.isOpen()) {
                    session.getAsyncRemote().sendText(json, result -> {
                        if (result.getException() == null) {
                            LOG.infof("Dados iniciais enviados para cliente - Sensor: %s, Total de leituras: %d", 
                                      sensorId, dados.totalLeituras());
                        } else {
                            LOG.errorf(result.getException(), "Erro ao enviar dados iniciais para sensor: %s", sensorId);
                        }
                    });
                }
            } catch (Exception e) {
                LOG.errorf(e, "Erro ao buscar dados iniciais para sensor: %s", sensorId);
            }
        });
    }

    @OnClose
    public void onClose(Session session, @PathParam("sensorId") String sensorId) {
        Set<Session> sensorSessions = sessions.get(sensorId);
        if (sensorSessions != null) {
            sensorSessions.remove(session);
            if (sensorSessions.isEmpty()) {
                sessions.remove(sensorId);
            }
        }
        LOG.infof("Frontend desconectado - Sensor ID: %s", sensorId);
    }

    @OnError
    public void onError(Session session, @PathParam("sensorId") String sensorId, Throwable throwable) {
        Set<Session> sensorSessions = sessions.get(sensorId);
        if (sensorSessions != null) {
            sensorSessions.remove(session);
            if (sensorSessions.isEmpty()) {
                sessions.remove(sensorId);
            }
        }
        LOG.errorf(throwable, "Erro na conexão WebSocket de dados - Sensor ID: %s", sensorId);
    }

    /**
     * Método chamado pelo PiezoSocket quando uma nova leitura é registrada.
     * Envia os dados atualizados para todos os clientes conectados ao sensor.
     */
    public void notificarNovaLeitura(String sensorId) {
        Set<Session> sensorSessions = sessions.get(sensorId);
        
        if (sensorSessions == null || sensorSessions.isEmpty()) {
            // Nenhum cliente conectado a este sensor
            return;
        }

        // Executa de forma assíncrona para não bloquear a thread
        CompletableFuture.runAsync(() -> {
            try {
                DadosGraficoDTO dados = leituraPiezoService.obterDadosUltimos60Segundos(sensorId);
                String json = objectMapper.writeValueAsString(dados);
                
                // Envia para todos os clientes conectados a este sensor
                sensorSessions.forEach(session -> {
                    if (session.isOpen()) {
                        session.getAsyncRemote().sendText(json, result -> {
                            if (result.getException() != null) {
                                LOG.errorf(result.getException(), 
                                          "Erro ao enviar atualização para cliente do sensor %s", sensorId);
                            }
                        });
                    }
                });
                
                LOG.debugf("Atualização enviada para %d cliente(s) do sensor %s", 
                          sensorSessions.size(), sensorId);
                
            } catch (Exception e) {
                LOG.errorf(e, "Erro ao notificar nova leitura para sensor: %s", sensorId);
            }
        });
    }
}

