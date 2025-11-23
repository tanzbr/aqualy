#include <WiFi.h>
#include <WebSocketsClient.h>
#include <Adafruit_NeoPixel.h>

// ==== CONFIGURAÇÕES DE REDE ====
const char* ssid = "BRITO";
const char* password = "Oi12oi12";

// ==== CONFIGURAÇÕES DO WEBSOCKET ====
const char* ws_host = "aqualy.tanz.dev";
const uint16_t ws_port = 443;  // Porta HTTPS
const char* ws_path = "/ws/piezo/sensor01";  // Endpoint do sensor piezoelétrico
const char* sensor_id = "sensor01";

WebSocketsClient webSocket;

// ==== SENSOR PIEZOELÉTRICO ====
const int PIEZO_PIN = 34;  // Pino analógico ADC1_6 (GPIO 34)
const float ADC_RESOLUTION = 4095.0;  // Resolução ADC 12-bit do ESP32
const float VOLTAGE_REF = 3.3;  // Tensão de referência do ESP32
const int SAMPLE_INTERVAL = 1000;  // Intervalo de amostragem em ms (1 segundo)

unsigned long lastSampleTime = 0;

// ==== LED NEOPIXEL ====
#define LED_PIN 48
#define NUMPIXELS 1
#define LED_BRIGHTNESS 50  // Brilho: 0-255 (50 = ~20% de brilho)
Adafruit_NeoPixel pixel(NUMPIXELS, LED_PIN, NEO_GRB + NEO_KHZ800);

// ==== CONTROLE DE CONEXÃO ====
bool wsConnected = false;

// ==== FUNÇÕES DE LED ====
void setLedColor(uint8_t r, uint8_t g, uint8_t b) {
  // Reduz a intensidade de cada cor proporcionalmente
  uint8_t dimR = (r * LED_BRIGHTNESS) / 255;
  uint8_t dimG = (g * LED_BRIGHTNESS) / 255;
  uint8_t dimB = (b * LED_BRIGHTNESS) / 255;
  
  pixel.setPixelColor(0, pixel.Color(dimR, dimG, dimB));
  pixel.show();
}

void ledDesconectado() { setLedColor(255, 0, 0); }     // Vermelho
void ledConectado() { setLedColor(0, 255, 0); }        // Verde
void ledEnviando()  { setLedColor(0, 0, 255); }        // Azul

// ==== CALLBACK DO WEBSOCKET ====
void webSocketEvent(WStype_t type, uint8_t * payload, size_t length) {
  switch(type) {
    case WStype_DISCONNECTED:
      Serial.println("🔴 WebSocket Desconectado!");
      wsConnected = false;
      ledDesconectado();
      break;
      
    case WStype_CONNECTED:
      Serial.println("✅ WebSocket Conectado!");
      Serial.printf("📍 Conectado em: %s\n", payload);
      wsConnected = true;
      ledConectado();
      break;
      
    case WStype_TEXT:
      Serial.printf("📨 Mensagem recebida: %s\n", payload);
      break;
      
    case WStype_ERROR:
      Serial.printf("❌ Erro WebSocket: %s\n", payload);
      ledDesconectado();
      break;
      
    case WStype_BIN:
      Serial.printf("⚠️ Dados binários recebidos (%u bytes)\n", length);
      break;
  }
}

// ==== FUNÇÃO PARA LER SENSOR PIEZOELÉTRICO ====
float lerSensorPiezo() {
  // Lê o valor do ADC (0-4095)
  int adcValue = analogRead(PIEZO_PIN);
  
  // Converte para voltagem (0-3.3V)
  float voltage = (adcValue / ADC_RESOLUTION) * VOLTAGE_REF;
  
  return voltage;
}

// ==== SETUP ====
void setup() {
  Serial.begin(115200);
  delay(100);
  
  Serial.println("\n\n========================================");
  Serial.println("🚀 Iniciando Sistema Piezoelétrico");
  Serial.println("========================================");
  
  // Configurar pino analógico
  pinMode(PIEZO_PIN, INPUT);
  
  // Configurar ADC
  analogReadResolution(12);  // Resolução de 12 bits (0-4095)
  analogSetAttenuation(ADC_11db);  // Atenuação para ler até 3.3V

  // Inicializar LED
  pixel.begin();
  ledDesconectado();

  // Conectar WiFi
  Serial.println("\n📡 Conectando ao WiFi...");
  Serial.printf("SSID: %s\n", ssid);
  WiFi.begin(ssid, password);

  int tentativas = 0;
  while (WiFi.status() != WL_CONNECTED && tentativas < 30) {
    delay(500);
    Serial.print(".");
    tentativas++;
  }

  if (WiFi.status() == WL_CONNECTED) {
    Serial.println("\n✅ WiFi Conectado!");
    Serial.print("📍 IP Local: ");
    Serial.println(WiFi.localIP());
    Serial.print("📶 RSSI: ");
    Serial.print(WiFi.RSSI());
    Serial.println(" dBm");
  } else {
    Serial.println("\n❌ Falha ao conectar WiFi!");
    return;
  }

  // Configurar WebSocket
  Serial.println("\n🔌 Configurando WebSocket...");
  Serial.printf("Host: %s\n", ws_host);
  Serial.printf("Porta: %u\n", ws_port);
  Serial.printf("Path: %s\n", ws_path);
  Serial.printf("Sensor ID: %s\n", sensor_id);
  
  // Configurar SSL/TLS
  webSocket.beginSSL(ws_host, ws_port, ws_path);
  
  // Configurar evento
  webSocket.onEvent(webSocketEvent);
  
  // Configurar reconexão automática
  webSocket.setReconnectInterval(5000);
  
  // Configurar headers customizados
  webSocket.setExtraHeaders("Origin: https://aqualy.tanz.dev");
  
  Serial.println("✅ WebSocket configurado!");
  Serial.println("========================================\n");
  
  Serial.println("📊 Iniciando leituras do sensor piezoelétrico...");
  Serial.println("⏱️  Intervalo de envio: 1 segundo\n");
}

// ==== LOOP PRINCIPAL ====
void loop() {
  // Processar eventos WebSocket
  webSocket.loop();

  // Verificar WiFi
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("🔴 WiFi desconectado! Tentando reconectar...");
    ledDesconectado();
    WiFi.begin(ssid, password);
    delay(5000);
    return;
  }

  unsigned long currentTime = millis();

  // Ler e enviar dados do sensor a cada 1 segundo
  if (currentTime - lastSampleTime >= SAMPLE_INTERVAL) {
    // Ler sensor piezoelétrico
    float voltage = lerSensorPiezo();
    
    // Exibir no monitor serial
    Serial.print("⚡ Leitura Piezoelétrica: ");
    Serial.print(voltage, 3);
    Serial.println(" V");
    
    // Enviar dados via WebSocket
    enviarDados(voltage);
    
    lastSampleTime = currentTime;
  }
}

// ==== FUNÇÃO DE ENVIO DE DADOS ====
void enviarDados(float voltage) {
  if (!wsConnected) {
    Serial.println("⚠️ WebSocket desconectado - não enviando dados");
    return;
  }

  ledEnviando();
  
  // Enviar apenas o valor da voltagem (formato simples)
  String payload = String(voltage, 3);
  webSocket.sendTXT(payload);
  
  Serial.println("📤 Dados enviados: " + payload);
  
  delay(100);
  ledConectado();
}
