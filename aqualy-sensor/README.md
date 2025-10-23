## 💧 Projeto: Aqualy Sensor

### 🧩 Descrição geral

O **Aqualy Sensor** é o sistema embarcado responsável pela coleta de dados de vazão e consumo de água em tempo real. Desenvolvido para **ESP32**, o sensor se conecta via **WebSocket SSL** ao backend Quarkus, enviando leituras precisas de forma contínua e confiável.

---

## 🚀 Tecnologias utilizadas

**Plataforma:** ESP32  
**Linguagem:** C++ (Arduino Framework)  
**Comunicação:** WebSocket SSL (wss://)  
**Bibliotecas:**  
- `WiFi.h` — Conexão Wi-Fi  
- `WebSocketsClient.h` — Cliente WebSocket  
- `Adafruit_NeoPixel.h` — Controle de LED RGB  

---

## 🔧 Hardware utilizado

### Componentes principais:

| Componente | Modelo/Especificação | Função |
|------------|---------------------|---------|
| **Microcontrolador** | ESP32 | Processamento e conectividade Wi-Fi |
| **Sensor de Vazão** | YF-S201 | Medição precisa de fluxo de água |
| **LED RGB** | NeoPixel WS2812B | Indicador visual de status de conexão |

### Pinagem:

```
GPIO 15 → Sensor de Vazão (YF-S201)
GPIO 48 → LED NeoPixel (indicador de status)
```

---

## 📡 Funcionamento do sistema

### 🔄 Ciclo de operação:

1. **Conexão WiFi** → Conecta à rede configurada
2. **Conexão WebSocket** → Estabelece canal SSL com o backend
3. **Leitura contínua** → Monitora pulsos do sensor de vazão
4. **Cálculo de vazão** → Processa dados a cada 1 segundo
5. **Envio de dados** → Transmite leituras a cada 10 segundos
6. **Monitoramento** → Indica status de conexão via LED RGB

### 💡 Indicadores LED:

| Cor | Status |
|-----|--------|
| 🔴 **Vermelho** | Desconectado do servidor |
| 🟢 **Verde** | Conectado e operacional |
| 🔵 **Azul** | Enviando dados |

---

## 📊 Protocolo de comunicação

O sensor utiliza um protocolo baseado em texto via WebSocket.

### 📤 Mensagens enviadas (Sensor → Backend):

#### Envio de leituras
```
01;{medidorId};{consumoLitros};{vazaoLMin}
```
**Exemplo:** `01;1;2.450;45.67`

**Descrição:**
- `01` — Tipo de mensagem (leitura)
- `medidorId` — ID do medidor cadastrado
- `consumoLitros` — Consumo acumulado no período (3 decimais)
- `vazaoLMin` — Vazão média em litros/minuto (2 decimais)

**Frequência:** Enviado a cada 3 segundos contendo dados agregados do período

---

## ⚙️ Configuração

### 🌐 Conexão WiFi

Edite as credenciais no arquivo `aqualy.ino`:

```cpp
const char* ssid = "UNITINS_WIFI";
const char* password = "";
```

### 🔌 Configuração do WebSocket

```cpp
const char* ws_host = "aqualy.tanz.dev";
const uint16_t ws_port = 443;
const char* ws_path = "/ws/sensor/1";  // Substitua "1" pelo ID do medidor
const char* device_id = "1";            // ID do dispositivo
```

---

## 🔧 Como executar o projeto

### ⚙️ Pré-requisitos

- **Arduino IDE** 2.0+ ou **PlatformIO**
- **ESP32 Board Support** instalado
- **Bibliotecas necessárias:**
  ```
  - WiFi (nativa ESP32)
  - WebSocketsClient (by Markus Sattler)
  - Adafruit NeoPixel
  ```

### 📦 Instalação das bibliotecas

No Arduino IDE:
```
Sketch → Incluir Biblioteca → Gerenciar Bibliotecas...

Buscar e instalar:
1. "WebSockets" by Markus Sattler
2. "Adafruit NeoPixel"
```

### 🚀 Upload para o ESP32

1. Conecte o ESP32 via USB
2. Selecione a placa: `Tools → Board → ESP32 Dev Module`
3. Selecione a porta: `Tools → Port → COMx` (Windows) ou `/dev/ttyUSBx` (Linux)
4. Configure as credenciais WiFi e WebSocket
5. Clique em `Upload` (Ctrl+U)

## 🔗 Integração com o backend

### 📍 Endpoint WebSocket

```
wss://aqualy.tanz.dev/ws/sensor/{medidorId}
```

### 🔐 Segurança

- Conexão via **SSL/TLS** (porta 443)
- Cabeçalho de origem: `Origin: https://aqualy.tanz.dev`
- Reconexão automática a cada 5 segundos

### 🔄 Fluxo de dados

```
┌─────────┐       WebSocket SSL      ┌─────────┐       REST API      ┌──────────┐
│ ESP32   │ ────────────────────────► │ Backend │ ◄──────────────────│ Flutter  │
│ Sensor  │  Envia leituras           │ Quarkus │  Consulta dados     │   App    │
└─────────┘                           └─────────┘                     └──────────┘
```

1. **Sensor → Backend:** Envia leituras a cada 3s via WebSocket SSL
2. **Backend:** Processa, valida e armazena no banco de dados PostgreSQL
3. **Backend:** Gera insights com IA baseado nos padrões de consumo
4. **App → Backend:** Solicita dados via API REST
5. **App:** Exibe dashboards, gráficos e insights ao usuário

---

## 👥 Autores

**Cauã Fernandes, Dejanildo Júnior, Gisele Veloso, João Víttor Costa e Thalyssa Freitas**

---

## 📄 Licença

Este projeto foi desenvolvido para fins acadêmicos no contexto do **HACKÁGUA - UNITINS**.

---

# UNITINS - HACKÁGUA



