# Código Arduino - Sensor Piezoelétrico ESP32

## 📋 Descrição

Código para ESP32 que lê um sensor piezoelétrico e envia os dados via WebSocket para o backend a cada 1 segundo.

## 🔌 Hardware Necessário

- **ESP32** (qualquer versão com WiFi)
- **Sensor Piezoelétrico** conectado ao pino analógico
- **LED Neopixel** (opcional, para feedback visual)
- **Conexão WiFi**

## 📍 Pinagem

### Sensor Piezoelétrico:
- **Pino Analógico**: GPIO 34 (ADC1_6)
- **GND**: GND do ESP32
- **VCC**: 3.3V (se necessário)

### LED Neopixel (Opcional):
- **Data Pin**: GPIO 48
- **VCC**: 5V
- **GND**: GND

## ⚙️ Configuração

### 1. WiFi

Edite as credenciais no código:

```cpp
const char* ssid = "SEU_WIFI";
const char* password = "SUA_SENHA";
```

### 2. WebSocket

Configure o servidor:

```cpp
const char* ws_host = "aqualy.tanz.dev";  // Seu domínio
const uint16_t ws_port = 443;              // Porta HTTPS
const char* ws_path = "/ws/piezo/sensor01"; // Endpoint
const char* sensor_id = "sensor01";         // ID do sensor
```

### 3. Sensor

Ajuste o pino se necessário:

```cpp
const int PIEZO_PIN = 34;  // GPIO 34
```

## 📊 Como Funciona

### Leitura do Sensor:

1. **ADC lê o pino** (0-4095)
2. **Converte para voltagem** (0-3.3V)
3. **Envia via WebSocket** a cada 1 segundo

### Fórmula de Conversão:

```
Voltagem (V) = (ADC_Value / 4095) × 3.3
```

### Exemplo:
- ADC lê: 2048
- Voltagem: (2048 / 4095) × 3.3 = **1.65V**
- Envia: `"1.650"`

## 📡 Protocolo WebSocket

### Endpoint:
```
wss://aqualy.tanz.dev/ws/piezo/sensor01
```

### Formato de Envio:
```
0.150
0.250
0.180
```

Apenas o valor da voltagem com 3 casas decimais.

### Backend Processa:
1. Recebe: `"0.150"` (Volts)
2. Converte: `0.150 × 200 = 30.0` (Newtons)
3. Salva no banco:
   - `valor = 0.150`
   - `valor_newtons = 30.0`

## 🎨 Feedback Visual (LED)

| Cor | Status |
|-----|--------|
| 🔴 Vermelho | Desconectado do WiFi/WebSocket |
| 🟢 Verde | Conectado e pronto |
| 🔵 Azul | Enviando dados |

## 📝 Monitor Serial

Exemplo de saída:

```
========================================
🚀 Iniciando Sistema Piezoelétrico
========================================

📡 Conectando ao WiFi...
SSID: BRITO
...............
✅ WiFi Conectado!
📍 IP Local: 192.168.1.100
📶 RSSI: -45 dBm

🔌 Configurando WebSocket...
Host: aqualy.tanz.dev
Porta: 443
Path: /ws/piezo/sensor01
Sensor ID: sensor01
✅ WebSocket configurado!
========================================

📊 Iniciando leituras do sensor piezoelétrico...
⏱️  Intervalo de envio: 1 segundo

✅ WebSocket Conectado!
📍 Conectado em: /ws/piezo/sensor01
⚡ Leitura Piezoelétrica: 0.150 V
📤 Dados enviados: 0.150
⚡ Leitura Piezoelétrica: 0.250 V
📤 Dados enviados: 0.250
⚡ Leitura Piezoelétrica: 0.180 V
📤 Dados enviados: 0.180
```

## 🔧 Resolução de Problemas

### Erro: WiFi não conecta

```cpp
// Aumentar tentativas
int tentativas = 0;
while (WiFi.status() != WL_CONNECTED && tentativas < 60) {
    delay(500);
    Serial.print(".");
    tentativas++;
}
```

### Erro: WebSocket desconectando

1. Verificar certificado SSL do servidor
2. Verificar se o domínio está acessível
3. Testar com HTTP primeiro (porta 80, sem SSL)

```cpp
// Para testar sem SSL:
webSocket.begin(ws_host, 80, ws_path);  // Em vez de beginSSL
```

### Sensor lendo valores errados

**Verifique:**
1. Conexões do sensor (GND comum)
2. Tensão de alimentação (3.3V)
3. Pino analógico correto (ADC1 no ESP32)

**Calibração:**

```cpp
// Adicionar offset se necessário
float voltage = ((adcValue / ADC_RESOLUTION) * VOLTAGE_REF) + OFFSET;
const float OFFSET = 0.0;  // Ajustar conforme necessário
```

### Leituras ruidosas

Adicione filtro de média móvel:

```cpp
const int NUM_SAMPLES = 10;
float samples[NUM_SAMPLES];
int sampleIndex = 0;

float lerSensorPiezo() {
  // Ler múltiplas amostras
  float sum = 0;
  for (int i = 0; i < NUM_SAMPLES; i++) {
    int adcValue = analogRead(PIEZO_PIN);
    float voltage = (adcValue / ADC_RESOLUTION) * VOLTAGE_REF;
    sum += voltage;
    delay(10);
  }
  
  return sum / NUM_SAMPLES;  // Retorna média
}
```

## 📚 Bibliotecas Necessárias

Instale via Arduino IDE:

1. **WiFi** (nativa do ESP32)
2. **WebSocketsClient** by Markus Sattler
   - Arduino IDE → Sketch → Include Library → Manage Libraries
   - Buscar: "WebSockets"
   - Instalar: "WebSockets by Markus Sattler"

3. **Adafruit_NeoPixel** (se usar LED)
   - Buscar: "Adafruit NeoPixel"
   - Instalar: "Adafruit NeoPixel by Adafruit"

## 🚀 Upload para ESP32

### Via Arduino IDE:

1. **Configurar placa:**
   - Tools → Board → ESP32 Arduino → ESP32 Dev Module

2. **Configurar porta:**
   - Tools → Port → COMx (Windows) ou /dev/ttyUSBx (Linux)

3. **Upload:**
   - Sketch → Upload
   - Ou: Ctrl+U

### Via PlatformIO:

```ini
[env:esp32dev]
platform = espressif32
board = esp32dev
framework = arduino
lib_deps = 
    links2004/WebSockets@^2.3.6
    adafruit/Adafruit NeoPixel@^1.10.4
```

## 🧪 Teste Rápido

### Simular Sensor:

Se não tiver o sensor físico, simule valores aleatórios:

```cpp
float lerSensorPiezo() {
  // Simula valores entre 0.0 e 1.0V
  float voltage = random(0, 1000) / 1000.0;
  return voltage;
}
```

### Teste Local (sem SSL):

Para testar localmente sem HTTPS:

```cpp
const char* ws_host = "192.168.1.100";  // IP do seu PC
const uint16_t ws_port = 8080;
webSocket.begin(ws_host, ws_port, "/ws/piezo/sensor01");  // Sem SSL
```

## 📊 Especificações Técnicas

### ADC do ESP32:
- **Resolução**: 12 bits (0-4095)
- **Tensão máxima**: 3.3V
- **Atenuação**: 11dB (0-3.3V)
- **Precisão**: ±2%

### Taxa de Amostragem:
- **Intervalo**: 1000ms (1 Hz)
- **Pode ser alterado**: Editar `SAMPLE_INTERVAL`

### Consumo de Energia:
- **WiFi ativo**: ~160mA
- **WebSocket**: ~10-20mA adicional
- **Total aproximado**: ~180mA @ 3.3V

## 🎯 Aplicação - Nexfloor

Para o projeto de pisos inteligentes:

### Cenários de Teste:

1. **Sem carga**: 0.0-0.1V → 0-20N
2. **Pessoa caminhando**: 0.2-0.5V → 40-100N
3. **Equipamento leve**: 0.5-1.5V → 100-300N
4. **Equipamento pesado**: 1.5-2.5V → 300-500N
5. **Sobrecarga**: > 2.5V → > 500N

### Alertas:

```cpp
void verificarCarga(float voltage) {
  float force = voltage * 200;  // Conversão aproximada
  
  if (force > 500) {
    Serial.println("⚠️ SOBRECARGA DETECTADA!");
    // Enviar alerta adicional
  } else if (force > 400) {
    Serial.println("⚡ Carga alta");
  }
}
```

## 🔗 Links Úteis

- [ESP32 Pinout](https://randomnerdtutorials.com/esp32-pinout-reference-gpios/)
- [ESP32 ADC](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/peripherals/adc.html)
- [WebSockets Library](https://github.com/Links2004/arduinoWebSockets)
- [Adafruit NeoPixel](https://learn.adafruit.com/adafruit-neopixel-uberguide)

