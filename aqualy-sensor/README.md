## 💧 Projeto: Aqualy Sensor

### 🧩 Descrição geral

O **Aqualy Sensor** é o sistema embarcado responsável pela coleta de dados de vazão e consumo de água em tempo real. Desenvolvido para **ESP32**, o sensor se conecta via **WebSocket SSL** ao backend Quarkus, enviando leituras precisas e recebendo comandos remotos para controle do fluxo de água.

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
| **Microcontrolador** | ESP32 | Processamento e conectividade |
| **Sensor de Vazão** | YF-S201 | Medição de fluxo de água |
| **LED RGB** | NeoPixel WS2812B | Indicador visual de status |
| **Relé** | 1 canal (GPIO 8) | Controle de interrupção do fluxo |
| **Botão Touch** | GPIO 4 | Controle manual liga/desliga |

### Pinagem:

```
GPIO 15 → Sensor de Vazão (YF-S201)
GPIO 8  → Relé (controle de fluxo)
GPIO 48 → LED NeoPixel
GPIO 4  → Botão Touch
```

---

## 📡 Funcionamento do sistema

### 🔄 Ciclo de operação:

1. **Conexão WiFi** → Conecta à rede configurada
2. **Conexão WebSocket** → Estabelece canal SSL com o backend
3. **Leitura contínua** → Monitora pulsos do sensor de vazão
4. **Cálculo de vazão** → Processa dados a cada 1 segundo
5. **Envio de dados** → Transmite leituras a cada 10 segundos
6. **Recepção de comandos** → Responde a comandos remotos (ON/OFF)
7. **Controle local** → Permite acionamento via botão touch

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

#### 1. Envio de leituras
```
01;{medidorId};{consumoLitros};{vazaoLMin}
```
**Exemplo:** `01;1;2.450;45.67`

**Descrição:**
- `01` — Tipo de mensagem (leitura)
- `medidorId` — ID do medidor cadastrado
- `consumoLitros` — Consumo acumulado no período (3 decimais)
- `vazaoLMin` — Vazão média em litros/minuto (2 decimais)

#### 2. Envio de status
```
02;{medidorId};{ON/OFF}
```
**Exemplo:** `02;1;ON`

**Descrição:**
- `02` — Tipo de mensagem (status)
- `medidorId` — ID do medidor
- `ON/OFF` — Estado do relé

### 📥 Mensagens recebidas (Backend → Sensor):

#### 3. Controle remoto
```
03;{comando}
```
**Exemplos:**
- `03;ON` — Liga o relé (libera fluxo)
- `03;OFF` — Desliga o relé (bloqueia fluxo)

**Descrição:**
- `03` — Tipo de mensagem (comando)
- `comando` — Ação a ser executada

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

### 🎛️ Calibração do sensor

O fator de calibração pode ser ajustado para o sensor YF-S201:

```cpp
float calibrationFactor = 4.5;  // Pulsos por litro (ajustar conforme necessário)
```

**Calibração recomendada:**
- Valor padrão: `4.5` pulsos/litro
- Para maior precisão, realizar teste com volume conhecido

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

### 🔍 Monitoramento

Abra o Serial Monitor (115200 baud) para visualizar:
- Status de conexão WiFi
- Status de conexão WebSocket
- Leituras de vazão em tempo real
- Envio de dados
- Recepção de comandos

---

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
│ ESP32   │ ────────────────────────► │ Backend │ ──────────────────► │ Flutter  │
│ Sensor  │                           │ Quarkus │                     │   App    │
└─────────┘ ◄──────────────────────── └─────────┘                     └──────────┘
              Comandos ON/OFF
```

1. **Sensor → Backend:** Envia leituras a cada 10s via WebSocket
2. **Backend:** Processa, valida e armazena no banco de dados
3. **App → Backend:** Solicita dados via API REST
4. **Backend → Sensor:** Envia comandos de controle via WebSocket
5. **App:** Visualiza dados em tempo real e controla dispositivos

---

## 🎯 Funcionalidades implementadas

✅ Conexão WiFi com reconexão automática  
✅ Cliente WebSocket SSL com TLS  
✅ Leitura precisa de vazão com sensor YF-S201  
✅ Cálculo de consumo acumulado  
✅ Envio periódico de dados (10 segundos)  
✅ Recepção de comandos remotos  
✅ Controle de relé para interrupção de fluxo  
✅ Botão touch para controle manual  
✅ LED RGB com indicação de status  
✅ Debounce para botão touch  
✅ Protocolo de comunicação customizado  
✅ Monitoramento via Serial  

---

## 🧠 Lógica de medição

### Cálculo de vazão:

```cpp
// A cada 1 segundo:
float flowRate = pulseCount / calibrationFactor;  // L/min
float litrosPorSegundo = flowRate / 60.0;         // L/s

// Acumula consumo:
consumoLitros += litrosPorSegundo;
somaVazao += flowRate;
contagemMedidas++;
```

### Envio de dados:

```cpp
// A cada 10 segundos:
float mediaVazao = somaVazao / contagemMedidas;

// Envia: 01;{id};{consumo};{vazão média}
String payload = "01;" + device_id + ";" + 
                 String(consumoLitros, 3) + ";" + 
                 String(mediaVazao, 2);
```

---

## 🐛 Troubleshooting

### 🔴 LED vermelho permanente
- Verificar credenciais WiFi
- Confirmar se o backend está online
- Verificar URL e porta do WebSocket

### 📡 Conecta WiFi mas não conecta WebSocket
- Verificar caminho do WebSocket (`/ws/sensor/{id}`)
- Confirmar que o ID do medidor existe no backend
- Testar conectividade com o servidor

### 💧 Vazão sempre zerada
- Verificar conexão física do sensor (GPIO 15)
- Confirmar alimentação do sensor (5V)
- Testar continuidade do cabo
- Ajustar `calibrationFactor`

### 🔵 LED azul permanente
- Possível travamento no envio
- Reiniciar o ESP32
- Verificar Serial Monitor para erros

---

## 📊 Especificações técnicas

### Sensor YF-S201:
- **Tensão:** 5-24V DC
- **Faixa de vazão:** 1-30 L/min
- **Precisão:** ±10%
- **Tipo de sinal:** Pulsos digitais
- **Fator K:** ~4.5 pulsos/litro (depende do modelo)

### Consumo do sistema:
- **ESP32 ativo:** ~160-260mA
- **LED NeoPixel:** ~20mA (por cor)
- **Relé:** ~70-100mA
- **Total estimado:** ~300-400mA @ 5V

---

## 👥 Autores

**Cauã Fernandes, Dejanildo Júnior, Gisele Veloso, João Víttor Costa e Thalyssa Freitas**

---

## 📄 Licença

Este projeto foi desenvolvido para fins acadêmicos no contexto do **HACKÁGUA - UNITINS**.

---

# UNITINS - HACKÁGUA



