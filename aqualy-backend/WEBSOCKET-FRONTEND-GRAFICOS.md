# WebSocket Frontend - Dados para Gráficos em Tempo Real

## 📊 Descrição

Sistema WebSocket para frontend consumir dados dos últimos 60 segundos em tempo real, formatados para construção de gráficos. Os dados são enviados automaticamente a cada nova leitura do sensor (a cada 1 segundo).

## 🔌 Endpoint WebSocket

```
ws://localhost:8080/ws/piezo/dados/{sensorId}
```

**Parâmetro:**
- `{sensorId}`: Identificador único do sensor/bloco (ex: "sensor01", "bloco-a1", etc.)

## 📤 Funcionamento

1. **Frontend conecta** no WebSocket
2. **Servidor envia imediatamente** os dados dos últimos 60 segundos
3. **A cada nova leitura** do sensor (1 segundo), servidor envia dados atualizados automaticamente
4. **Janela móvel** de 60 segundos sempre atualizada

## 📥 Formato de Resposta (JSON)

```json
{
  "sensorId": "sensor01",
  "timestamps": [
    "2025-11-23T10:30:00",
    "2025-11-23T10:30:01",
    "2025-11-23T10:30:02",
    ...
  ],
  "valores": [123.45, 124.56, 125.67, ...],
  "totalLeituras": 60
}
```

### Estrutura dos Dados

- **sensorId**: ID do sensor que gerou os dados
- **timestamps**: Array de timestamps no formato ISO-8601 (LocalDateTime)
- **valores**: Array de valores do sensor piezoelétrico (BigDecimal)
- **totalLeituras**: Quantidade de leituras no array

**Observação:** Os arrays `timestamps` e `valores` têm o mesmo tamanho e estão na mesma ordem (índice 0 de timestamps corresponde ao índice 0 de valores).

## 🧪 Teste do WebSocket

### JavaScript (Navegador)

```javascript
const sensorId = "sensor01";
const ws = new WebSocket(`ws://localhost:8080/ws/piezo/dados/${sensorId}`);

ws.onopen = () => {
    console.log("Conectado ao WebSocket de dados");
};

ws.onmessage = (event) => {
    const dados = JSON.parse(event.data);
    
    console.log(`Sensor: ${dados.sensorId}`);
    console.log(`Total de leituras: ${dados.totalLeituras}`);
    
    // Arrays separados para gráficos
    const timestamps = dados.timestamps;
    const valores = dados.valores;
    
    // Atualizar gráfico
    atualizarGrafico(timestamps, valores);
};

ws.onclose = () => console.log("Desconectado");
ws.onerror = (error) => console.error("Erro:", error);

// Função exemplo para atualizar gráfico (Chart.js)
function atualizarGrafico(timestamps, valores) {
    myChart.data.labels = timestamps;
    myChart.data.datasets[0].data = valores;
    myChart.update();
}
```

### React.js

```javascript
import { useEffect, useState } from 'react';

function GraficoPiezo({ sensorId }) {
    const [dados, setDados] = useState({ timestamps: [], valores: [] });

    useEffect(() => {
        const ws = new WebSocket(`ws://localhost:8080/ws/piezo/dados/${sensorId}`);
        
        ws.onmessage = (event) => {
            const novos = JSON.parse(event.data);
            setDados({
                timestamps: novos.timestamps,
                valores: novos.valores
            });
        };

        return () => ws.close();
    }, [sensorId]);

    return (
        <div>
            <h2>Sensor: {sensorId}</h2>
            <GraficoLinha dados={dados} />
        </div>
    );
}
```

### Python

```python
import websocket
import json

def on_message(ws, message):
    dados = json.loads(message)
    
    print(f"Sensor: {dados['sensorId']}")
    print(f"Total de leituras: {dados['totalLeituras']}")
    
    timestamps = dados['timestamps']
    valores = dados['valores']
    
    # Processar dados
    for i in range(len(valores)):
        print(f"{timestamps[i]}: {valores[i]}")

def on_open(ws):
    print("Conectado ao WebSocket de dados")

sensor_id = "sensor01"
ws = websocket.WebSocketApp(
    f"ws://localhost:8080/ws/piezo/dados/{sensor_id}",
    on_message=on_message,
    on_open=on_open
)

ws.run_forever()
```

## 📈 Integração com Bibliotecas de Gráficos

### Chart.js

```javascript
const ctx = document.getElementById('myChart').getContext('2d');
const myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: [],
        datasets: [{
            label: 'Sensor Piezoelétrico',
            data: [],
            borderColor: 'rgb(75, 192, 192)',
            tension: 0.1
        }]
    },
    options: {
        responsive: true,
        scales: {
            x: {
                display: true,
                title: {
                    display: true,
                    text: 'Tempo'
                }
            },
            y: {
                display: true,
                title: {
                    display: true,
                    text: 'Valor'
                }
            }
        }
    }
});

const ws = new WebSocket('ws://localhost:8080/ws/piezo/dados/sensor01');

ws.onmessage = (event) => {
    const dados = JSON.parse(event.data);
    
    myChart.data.labels = dados.timestamps.map(t => 
        new Date(t).toLocaleTimeString()
    );
    myChart.data.datasets[0].data = dados.valores;
    myChart.update('none'); // Atualização sem animação para melhor performance
};
```

### Recharts (React)

```jsx
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';

function GraficoPiezo({ sensorId }) {
    const [dadosGrafico, setDadosGrafico] = useState([]);

    useEffect(() => {
        const ws = new WebSocket(`ws://localhost:8080/ws/piezo/dados/${sensorId}`);
        
        ws.onmessage = (event) => {
            const dados = JSON.parse(event.data);
            
            // Transformar arrays em formato para Recharts
            const formatted = dados.timestamps.map((timestamp, index) => ({
                tempo: new Date(timestamp).toLocaleTimeString(),
                valor: parseFloat(dados.valores[index])
            }));
            
            setDadosGrafico(formatted);
        };

        return () => ws.close();
    }, [sensorId]);

    return (
        <LineChart width={800} height={400} data={dadosGrafico}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="tempo" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Line type="monotone" dataKey="valor" stroke="#8884d8" />
        </LineChart>
    );
}
```

### D3.js

```javascript
const margin = {top: 20, right: 20, bottom: 30, left: 50};
const width = 800 - margin.left - margin.right;
const height = 400 - margin.top - margin.bottom;

const svg = d3.select("#grafico")
    .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", `translate(${margin.left},${margin.top})`);

const x = d3.scaleTime().range([0, width]);
const y = d3.scaleLinear().range([height, 0]);

const line = d3.line()
    .x(d => x(d.timestamp))
    .y(d => y(d.valor));

const ws = new WebSocket('ws://localhost:8080/ws/piezo/dados/sensor01');

ws.onmessage = (event) => {
    const dados = JSON.parse(event.data);
    
    const dataset = dados.timestamps.map((timestamp, i) => ({
        timestamp: new Date(timestamp),
        valor: parseFloat(dados.valores[i])
    }));
    
    x.domain(d3.extent(dataset, d => d.timestamp));
    y.domain([0, d3.max(dataset, d => d.valor)]);
    
    svg.selectAll("*").remove();
    
    svg.append("path")
        .datum(dataset)
        .attr("fill", "none")
        .attr("stroke", "steelblue")
        .attr("stroke-width", 1.5)
        .attr("d", line);
};
```

## 🏗️ Arquitetura do Sistema

```
Arduino → PiezoSocket (/ws/piezo/{sensorId})
              ↓
      registrarLeitura()
              ↓
         Database
              ↓
    notificarNovaLeitura()
              ↓
  PiezoDadosSocket (/ws/piezo/dados/{sensorId})
              ↓
         Frontend recebe update
```

## 📊 Características

- ✅ **Push automático**: Dados enviados automaticamente a cada nova leitura
- ✅ **Tempo real**: Latência mínima (< 1 segundo)
- ✅ **Janela móvel**: Sempre os últimos 60 segundos
- ✅ **Múltiplos clientes**: Vários frontends podem conectar ao mesmo sensor
- ✅ **Formato otimizado**: Arrays separados para facilitar uso em bibliotecas de gráficos
- ✅ **JSON nativo**: Fácil de consumir em qualquer linguagem
- ✅ **Reconexão automática**: Frontend pode reconectar a qualquer momento

## 🔍 Comportamento Detalhado

### Conexão Inicial

1. Frontend conecta em `/ws/piezo/dados/sensor01`
2. Servidor busca últimos 60 segundos de leituras
3. Servidor envia dados imediatamente
4. Frontend renderiza gráfico inicial

### Updates em Tempo Real

1. Arduino envia nova leitura via `/ws/piezo/sensor01`
2. Servidor salva no banco de dados
3. Servidor notifica `PiezoDadosSocket`
4. `PiezoDadosSocket` busca últimos 60 segundos atualizados
5. Envia para todos os clientes frontend conectados àquele sensor
6. Frontend atualiza gráfico automaticamente

### Desempenho

- **Consulta ao banco**: ~5-10ms (60 registros)
- **Serialização JSON**: ~1-2ms
- **Transmissão WebSocket**: ~1-5ms
- **Total**: ~10-20ms de latência

## 📝 Logs do Servidor

```
INFO  Frontend conectado - Sensor ID: sensor01 (Total de clientes conectados: 1)
INFO  Dados iniciais enviados para cliente - Sensor: sensor01, Total de leituras: 60
DEBUG Atualização enviada para 1 cliente(s) do sensor sensor01
INFO  Frontend desconectado - Sensor ID: sensor01
```

## 🚧 Possíveis Melhorias Futuras

- Cache de dados em memória para reduzir consultas ao banco
- Compressão de dados (gzip) para grandes volumes
- Filtros personalizados (últimos N segundos configurável)
- Agregação de dados (média, máximo, mínimo por período)
- Autenticação/Autorização nos WebSockets
- Rate limiting para prevenir sobrecarga

## 📚 Referências

- [WebSocket API (MDN)](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)
- [Chart.js Documentation](https://www.chartjs.org/docs/latest/)
- [Recharts Documentation](https://recharts.org/en-US/)
- [D3.js Documentation](https://d3js.org/)

