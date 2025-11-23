#include <WiFi.h>
#include <WebSocketsClient.h>
#include <Adafruit_NeoPixel.h>

// ================= CONFIGURAÇÕES =================
// Rede
const char* ssid     = "Desafio Industrial FIETO";
const char* password = "";

// WebSocket
const char* WS_HOST = "aqualy.tanz.dev";
const uint16_t WS_PORT = 443;
const char* WS_PATH = "/ws/piezo/1";

// Piezo
constexpr uint8_t PIEZO_PIN = 14;
constexpr int ADC_MAX = 4095;
constexpr float VREF = 3.3;
constexpr int SAMPLE_INTERVAL = 100;   // mais responsivo

// Processamento correto (sem gambiarras)
constexpr int NUM_SAMPLES = 30;
constexpr float GAIN = 5.0;
constexpr int NOISE_THRESHOLD = 10;    // ruído mínimo real
constexpr float SUAVIZACAO = 0.3; // 0.0 (muito suave) a 1.0 (sem suavização)

// LED
#define LED_PIN 48
#define NUMPIXELS 1
constexpr uint8_t LED_BRIGHTNESS = 50;

Adafruit_NeoPixel pixel(NUMPIXELS, LED_PIN, NEO_GRB + NEO_KHZ800);
WebSocketsClient webSocket;

bool wsConnected = false;
unsigned long lastSampleTime = 0;
int leituraAnterior = 0;
float voltageAnterior = 0.0;

// ================= LED =================
void setLed(uint8_t r, uint8_t g, uint8_t b) {
  pixel.setPixelColor(0, pixel.Color(
    (r * LED_BRIGHTNESS) / 255,
    (g * LED_BRIGHTNESS) / 255,
    (b * LED_BRIGHTNESS) / 255
  ));
  pixel.show();
}

#define LED_DESCONECTADO() setLed(255,0,0)
#define LED_CONECTADO()    setLed(0,255,0)
#define LED_ENVIANDO()     setLed(0,0,255)
#define LED_VARIACAO()     setLed(255,165,0)

// ================= WEBSOCKET =================
void webSocketEvent(WStype_t type, uint8_t * payload, size_t length) {
  switch(type) {
    case WStype_DISCONNECTED:
      wsConnected = false;
      LED_DESCONECTADO();
      break;

    case WStype_CONNECTED:
      wsConnected = true;
      LED_CONECTADO();
      break;

    case WStype_TEXT:
      Serial.printf("Mensagem: %s\n", payload);
      break;

    default:
      break;
  }
}

// ================= LEITURA ADC =================
inline int lerADC() {
  return analogRead(PIEZO_PIN);
}

// ================= PROCESSAMENTO FÍSICAMENTE CORRETO =================
// Mede variação pico-a-pico real do sinal piezo
int processarSinal() {
  int minValue = ADC_MAX;
  int maxValue = 0;

  for(int i = 0; i < NUM_SAMPLES; i++) {
    int leitura = lerADC();
    if (leitura < minValue) minValue = leitura;
    if (leitura > maxValue) maxValue = leitura;
    delayMicroseconds(150);
  }

  // Diferença real de variação do sinal (sem offset artificial)
  int variacao = maxValue - minValue;

  int sinal = variacao * GAIN;

  if (sinal < NOISE_THRESHOLD) return 0;
  if (sinal > 65535) sinal = 65535;

  return sinal;
}

float converterVoltagem(int sinal) {
  return (sinal / GAIN / ADC_MAX) * VREF;
}

// ================= SUAVIZAÇÃO =================
float suavizarLeitura(float novaLeitura) {
  if (voltageAnterior == 0.0) {
    voltageAnterior = novaLeitura;
    return novaLeitura;
  }
  voltageAnterior = (SUAVIZACAO * novaLeitura) + ((1.0 - SUAVIZACAO) * voltageAnterior);
  return voltageAnterior;
}

// ================= ENVIO =================
void enviarDados(int sinal, float voltage) {
  if (!wsConnected) return;

  bool mudou = (sinal != 0 && sinal != leituraAnterior);
  mudou ? LED_VARIACAO() : LED_ENVIANDO();

  String payload = String(voltage, 3);
  webSocket.sendTXT(payload);

  leituraAnterior = sinal;
  delay(20);
  LED_CONECTADO();
}

// ================= SETUP =================
void setup() {
  Serial.begin(115200);
  pinMode(PIEZO_PIN, INPUT);

  analogReadResolution(12);
  analogSetAttenuation(ADC_11db);

  pixel.begin();
  LED_DESCONECTADO();

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) delay(500);

  webSocket.beginSSL(WS_HOST, WS_PORT, WS_PATH);
  webSocket.onEvent(webSocketEvent);
  webSocket.setReconnectInterval(5000);
  webSocket.setExtraHeaders("Origin: https://aqualy.tanz.dev");
}

// ================= LOOP =================
void loop() {
  webSocket.loop();

  if (millis() - lastSampleTime >= SAMPLE_INTERVAL) {
    int sinal = processarSinal();
    float tensao = converterVoltagem(sinal);
    float tensaoSuavizada = suavizarLeitura(tensao);

    Serial.print("Sinal digital: ");
    Serial.print(sinal);
    Serial.print(" | Voltagem bruta: ");
    Serial.print(tensao, 3);
    Serial.print(" V | Suavizada: ");
    Serial.print(tensaoSuavizada, 3);
    Serial.println(" V");

    enviarDados(sinal, tensaoSuavizada);
    lastSampleTime = millis();
  }
}