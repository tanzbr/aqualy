# Conversão Piezoelétrica - Voltagem para Newtons

## 📊 Descrição

O sistema agora converte automaticamente os valores recebidos do sensor piezoelétrico (em Volts) para força (em Newtons) usando um coeficiente piezoelétrico de um material fictício.

## 🔬 Material Fictício

**Material:** Cerâmica Piezoelétrica PZT-Fictício (baseado em PZT-5H)

### Propriedades:
- **Sensibilidade**: 500 pC/N (picocoulombs por Newton)
- **Capacitância do sensor**: 100 nF (nanofarads)
- **Coeficiente de conversão**: 1 V = 200 N

### Cálculo Simplificado:

```
Força (N) = Voltagem (V) × Coeficiente
Força (N) = Voltagem (V) × 200
```

**Exemplo:**
- Arduino envia: `0.5` (0.5 Volts)
- Servidor calcula: `0.5 × 200 = 100.0 N`
- Armazena ambos os valores no banco

## 💾 Estrutura de Dados

### Banco de Dados

Tabela `leitura_piezo` agora possui:

| Campo | Tipo | Descrição |
|-------|------|-----------|
| id | BIGINT | ID único da leitura |
| valor | DECIMAL(10,3) | Valor original (Volts) |
| **valor_newtons** | DECIMAL(10,3) | **Valor convertido (Newtons)** |
| data_hora | TIMESTAMP | Timestamp da leitura |
| sensor_id | VARCHAR(255) | ID do sensor |

### JSON de Resposta

```json
{
  "id": 1,
  "valor": 0.5,
  "valorNewtons": 100.0,
  "dataHora": "2025-11-23T10:30:00",
  "sensorId": "sensor01"
}
```

### JSON para Gráficos

```json
{
  "sensorId": "sensor01",
  "timestamps": [
    "2025-11-23T10:30:00",
    "2025-11-23T10:30:01",
    "2025-11-23T10:30:02"
  ],
  "valores": [0.5, 0.6, 0.55],
  "valoresNewtons": [100.0, 120.0, 110.0],
  "totalLeituras": 3
}
```

## 🔄 Fluxo de Conversão

```
1. Arduino → Envia: 0.5 V
        ↓
2. WebSocket recebe: "0.5"
        ↓
3. Service converte:
   - Valor original: 0.5 V
   - Valor Newtons: 0.5 × 200 = 100.0 N
        ↓
4. Salva no banco:
   - valor: 0.5
   - valor_newtons: 100.0
        ↓
5. Frontend recebe ambos os valores
```

## 🧪 Exemplos de Conversão

| Voltagem (V) | Força (N) | Aplicação |
|--------------|-----------|-----------|
| 0.001 | 0.2 | Pressão muito leve |
| 0.01 | 2.0 | Toque suave |
| 0.1 | 20.0 | Pressão leve |
| 0.5 | 100.0 | Pressão moderada |
| 1.0 | 200.0 | Pressão forte |
| 2.5 | 500.0 | Pressão muito forte |
| 5.0 | 1000.0 | Pressão máxima |

## 📈 Uso no Frontend

### JavaScript - Gráfico de Voltagem

```javascript
const ws = new WebSocket('ws://localhost:8080/ws/piezo/dados/sensor01');

ws.onmessage = (event) => {
    const dados = JSON.parse(event.data);
    
    // Gráfico de voltagem (valores originais)
    graficoVoltagem.data.labels = dados.timestamps;
    graficoVoltagem.data.datasets[0].data = dados.valores;
    graficoVoltagem.update();
};
```

### JavaScript - Gráfico de Força (Newtons)

```javascript
const ws = new WebSocket('ws://localhost:8080/ws/piezo/dados/sensor01');

ws.onmessage = (event) => {
    const dados = JSON.parse(event.data);
    
    // Gráfico de força em Newtons
    graficoForca.data.labels = dados.timestamps;
    graficoForca.data.datasets[0].data = dados.valoresNewtons;
    graficoForca.options.scales.y.title.text = 'Força (N)';
    graficoForca.update();
};
```

### JavaScript - Gráfico Combinado

```javascript
const ws = new WebSocket('ws://localhost:8080/ws/piezo/dados/sensor01');

ws.onmessage = (event) => {
    const dados = JSON.parse(event.data);
    
    // Gráfico com ambos os eixos
    grafico.data.labels = dados.timestamps;
    
    // Dataset 1: Voltagem
    grafico.data.datasets[0].data = dados.valores;
    grafico.data.datasets[0].label = 'Voltagem (V)';
    grafico.data.datasets[0].yAxisID = 'y';
    
    // Dataset 2: Força
    grafico.data.datasets[1].data = dados.valoresNewtons;
    grafico.data.datasets[1].label = 'Força (N)';
    grafico.data.datasets[1].yAxisID = 'y1';
    
    grafico.update();
};
```

## 🎯 Aplicação Prática - Nexfloor

Para o projeto de **blocos de piso inteligentes**, a conversão para Newtons é essencial:

### Monitoramento de Integridade:
- **< 50 N**: Piso sem carga (vazio)
- **50-200 N**: Tráfego leve (pessoas caminhando)
- **200-500 N**: Tráfego moderado (equipamentos leves)
- **500-1000 N**: Tráfego pesado (equipamentos pesados)
- **> 1000 N**: Sobrecarga (alerta de integridade)

### Alertas de Manutenção Preventiva:
```javascript
ws.onmessage = (event) => {
    const dados = JSON.parse(event.data);
    
    // Verifica última leitura
    const ultimaForca = dados.valoresNewtons[dados.valoresNewtons.length - 1];
    
    if (ultimaForca > 1000) {
        alertar('CRÍTICO: Sobrecarga detectada!');
    } else if (ultimaForca > 800) {
        alertar('AVISO: Carga próxima do limite');
    }
    
    // Calcula média dos últimos 60 segundos
    const mediaForca = dados.valoresNewtons.reduce((a, b) => a + b, 0) / dados.totalLeituras;
    
    if (mediaForca > 600) {
        alertar('Manutenção preventiva recomendada');
    }
};
```

## ⚙️ Configuração do Coeficiente

Para alterar o coeficiente de conversão, edite o arquivo:

`src/main/java/br/unitins/topicos1/service/LeituraPiezoServiceImpl.java`

```java
// Altere o valor conforme necessário
private static final BigDecimal COEFICIENTE_PIEZOELETRICO = new BigDecimal("200.0");
```

### Outros Coeficientes Sugeridos:

**Materiais mais sensíveis:**
- **100.0**: Sensor de alta sensibilidade (0.01 V = 1 N)
- **50.0**: Sensor muito sensível (0.02 V = 1 N)

**Materiais menos sensíveis:**
- **500.0**: Sensor robusto (0.002 V = 1 N)
- **1000.0**: Sensor industrial pesado (0.001 V = 1 N)

## 🔬 Fundamentação Técnica

### Equação Piezoelétrica Básica:

```
Q = d × F
```

Onde:
- Q = Carga elétrica (Coulombs)
- d = Coeficiente piezoelétrico (C/N)
- F = Força aplicada (Newtons)

### Conversão Carga → Voltagem:

```
V = Q / C
```

Onde:
- V = Voltagem (Volts)
- C = Capacitância do sensor (Farads)

### Coeficiente Simplificado:

Para simplificar o cálculo no sistema, combinamos as duas equações:

```
F = V × (C / d)
F = V × Coeficiente
```

Para nosso material fictício:
- d = 500 pC/N = 500 × 10⁻¹² C/N
- C = 100 nF = 100 × 10⁻⁹ F
- Coeficiente = C / d = (100 × 10⁻⁹) / (500 × 10⁻¹²) = 200

Portanto: **1 V = 200 N**

## 📝 Notas Importantes

1. **Valores originais preservados**: O valor original em Volts é mantido no banco de dados para referência.

2. **Precisão**: Ambos os valores são armazenados com 3 casas decimais (DECIMAL 10,3).

3. **Consistência**: A conversão é feita automaticamente no servidor, garantindo consistência dos dados.

4. **Rastreabilidade**: É possível verificar os cálculos comparando `valor` e `valorNewtons` no banco.

5. **Flexibilidade**: O frontend pode escolher qual valor exibir (Volts ou Newtons) dependendo do contexto.

