# WebSocket Sensor Piezoelétrico - Nexfloor

## 📡 Descrição

WebSocket implementado para receber dados do Arduino com sensor piezoelétrico a cada 1 segundo, salvando as leituras no banco de dados com timestamp para consultas futuras.

## 🔌 Endpoint WebSocket

```
ws://localhost:8080/ws/piezo/{sensorId}
```

**Parâmetro:**
- `{sensorId}`: Identificador único do sensor/bloco (ex: "sensor01", "bloco-a1", etc.)

## 📤 Formato de Envio

O Arduino deve enviar apenas o **valor numérico** da leitura do sensor piezoelétrico:

```
123.45
```

Exemplos válidos:
- `123.45`
- `0.001`
- `9999.999`

## 💾 Dados Armazenados

Cada leitura salva no banco de dados contém:
- **ID**: Identificador único da leitura (gerado automaticamente)
- **Valor**: Leitura do sensor piezoelétrico
- **Data/Hora**: Timestamp da recepção (gerado automaticamente pelo servidor)
- **Sensor ID**: Identificador do sensor (obtido do path parameter)

## 🗄️ Estrutura de Banco de Dados

Tabela `leitura_piezo`:
```sql
CREATE TABLE leitura_piezo (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(10,3) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    sensor_id VARCHAR(255)
);
```

## 🧪 Teste do WebSocket

### Usando JavaScript (navegador):

```javascript
const sensorId = "sensor01";
const ws = new WebSocket(`ws://localhost:8080/ws/piezo/${sensorId}`);

ws.onopen = () => {
    console.log("Conectado ao WebSocket");
    
    // Simula envio de leitura a cada 1 segundo
    setInterval(() => {
        const valor = (Math.random() * 1000).toFixed(3);
        ws.send(valor);
        console.log(`Enviado: ${valor}`);
    }, 1000);
};

ws.onclose = () => console.log("Desconectado");
ws.onerror = (error) => console.error("Erro:", error);
```

### Usando Python:

```python
import websocket
import time
import random

def on_open(ws):
    print("Conectado ao WebSocket")
    
    # Simula envio de leitura a cada 1 segundo
    for i in range(10):
        valor = round(random.uniform(0, 1000), 3)
        ws.send(str(valor))
        print(f"Enviado: {valor}")
        time.sleep(1)
    
    ws.close()

sensor_id = "sensor01"
ws = websocket.WebSocketApp(
    f"ws://localhost:8080/ws/piezo/{sensor_id}",
    on_open=on_open
)

ws.run_forever()
```

### Arduino ESP32:

```cpp
#include <WiFi.h>
#include <WebSocketsClient.h>

const char* ssid = "SEU_WIFI";
const char* password = "SUA_SENHA";
const char* serverHost = "SEU_SERVER_IP";
const int serverPort = 8080;
const char* sensorId = "sensor01";

WebSocketsClient webSocket;

void setup() {
    Serial.begin(115200);
    
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("\nWiFi conectado!");
    
    String path = String("/ws/piezo/") + sensorId;
    webSocket.begin(serverHost, serverPort, path);
}

void loop() {
    webSocket.loop();
    
    // Lê o sensor piezoelétrico
    float valor = analogRead(34) * (3.3 / 4095.0); // Exemplo
    
    // Envia para o servidor
    String mensagem = String(valor, 3);
    webSocket.sendTXT(mensagem);
    
    delay(1000); // Envia a cada 1 segundo
}
```

## 📊 Logs do Servidor

O servidor registra automaticamente:
- ✅ Conexões: `Arduino conectado - Sensor Piezoelétrico ID: sensor01`
- 📥 Mensagens: `Mensagem recebida do sensor sensor01: 123.45`
- 💾 Salvamento: `Leitura piezoelétrica registrada - Sensor: sensor01, Valor: 123.45`
- ❌ Desconexões: `Arduino desconectado - Sensor Piezoelétrico ID: sensor01`
- ⚠️ Erros: Formato inválido, falhas de conexão, etc.

## 🏗️ Arquitetura Implementada

```
Arduino → WebSocket (PiezoSocket)
             ↓
         LeituraPiezoService
             ↓
      LeituraPiezoRepository
             ↓
         Banco de Dados
```

### Componentes:
1. **LeituraPiezo.java**: Entidade JPA
2. **LeituraPiezoRepository.java**: Acesso a dados (Panache)
3. **LeituraPiezoDTO.java**: DTO de entrada com validações
4. **LeituraPiezoResponseDTO.java**: DTO de resposta
5. **LeituraPiezoService.java**: Interface do serviço
6. **LeituraPiezoServiceImpl.java**: Implementação do serviço
7. **PiezoSocket.java**: WebSocket endpoint

## 🔍 Consulta dos Dados

As leituras podem ser consultadas diretamente no banco de dados:

```sql
-- Todas as leituras de um sensor
SELECT * FROM leitura_piezo 
WHERE sensor_id = 'sensor01' 
ORDER BY data_hora DESC;

-- Leituras das últimas 24 horas
SELECT * FROM leitura_piezo 
WHERE sensor_id = 'sensor01' 
  AND data_hora >= NOW() - INTERVAL 24 HOUR
ORDER BY data_hora DESC;

-- Média de valores por sensor
SELECT sensor_id, AVG(valor) as media, COUNT(*) as total
FROM leitura_piezo 
GROUP BY sensor_id;
```

## 🚀 Próximos Passos (Opcional)

Se precisar de endpoints REST para consultar os dados, você pode criar:

- `GET /leituras/piezo/sensor/{sensorId}` - Lista leituras por sensor
- `GET /leituras/piezo/sensor/{sensorId}/ultima` - Última leitura
- `GET /leituras/piezo/sensor/{sensorId}/estatisticas` - Estatísticas (média, máx, mín)
- `GET /leituras/piezo/periodo?inicio=...&fim=...` - Leituras por período

## 📝 Notas

- O servidor adiciona o timestamp automaticamente ao receber cada leitura
- As leituras são processadas de forma assíncrona para melhor performance
- Múltiplos sensores podem estar conectados simultaneamente
- O formato de envio é extremamente simples: apenas o valor numérico



