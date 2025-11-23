package br.unitins.topicos1.resource.ws;

import java.math.BigDecimal;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CompletableFuture;

import org.jboss.logging.Logger;

import br.unitins.topicos1.dto.LeituraPiezoDTO;
import br.unitins.topicos1.service.LeituraPiezoService;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/ws/piezo/{sensorId}")
@ApplicationScoped
public class PiezoSocket {

    private static final Logger LOG = Logger.getLogger(PiezoSocket.class);

    Map<String, Session> sessions = new ConcurrentHashMap<>();

    @Inject
    LeituraPiezoService leituraPiezoService;

    @OnOpen
    public void onOpen(Session session, @PathParam("sensorId") String sensorId) {
        sessions.put(sensorId, session);
        LOG.infof("Arduino conectado - Sensor Piezoelétrico ID: %s", sensorId);
    }

    @OnClose
    public void onClose(Session session, @PathParam("sensorId") String sensorId) {
        sessions.remove(sensorId);
        LOG.infof("Arduino desconectado - Sensor Piezoelétrico ID: %s", sensorId);
    }

    @OnError
    public void onError(Session session, @PathParam("sensorId") String sensorId, Throwable throwable) {
        sessions.remove(sensorId);
        LOG.errorf(throwable, "Erro na conexão WebSocket - Sensor Piezoelétrico ID: %s", sensorId);
    }

    @OnMessage
    public void onMessage(String message, @PathParam("sensorId") String sensorId) {
        try {
            LOG.infof("Mensagem recebida do sensor %s: %s", sensorId, message);

            // Parse do valor recebido (formato simples: apenas o número)
            BigDecimal valor = new BigDecimal(message.trim());

            // Processa a leitura de forma assíncrona
            CompletableFuture.runAsync(() -> {
                leituraPiezoService.registrarLeitura(new LeituraPiezoDTO(valor, sensorId));
            }).whenComplete((v, t) -> {
                if (t == null) {
                    LOG.infof("Leitura piezoelétrica registrada - Sensor: %s, Valor: %s", sensorId, message);
                } else {
                    LOG.errorf(t, "Erro ao processar mensagem: %s", message);
                }
            });

        } catch (NumberFormatException e) {
            LOG.errorf(e, "Formato inválido de número recebido: %s", message);
        } catch (Exception e) {
            LOG.errorf(e, "Erro ao processar mensagem: %s", message);
        }
    }
}



