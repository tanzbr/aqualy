## 💧 Projeto: Aqualy App

### 🧩 Descrição geral

O **Aqualy App** é a interface mobile do sistema de monitoramento inteligente de água, desenvolvido em **Flutter**. O aplicativo permite que usuários acompanhem em tempo real o consumo e a vazão de água através de medidores conectados, recebam insights gerados por inteligência artificial e gerenciem múltiplos dispositivos de forma prática e intuitiva.

---

## 🚀 Tecnologias utilizadas

**Framework:** Flutter 3.x, Dart  
**Desenvolvimento:** FlutterFlow (geração de código)  
**Gerenciamento de estado:** Provider  
**Navegação:** GoRouter  
**Backend:** API REST Quarkus (integração HTTP)  
**Gráficos:** fl_chart
**Ícones e fontes:** Google Fonts, Font Awesome  

---

## 📱 Funcionalidades principais

### 🔐 Autenticação e onboarding
- Tela de boas-vindas com slideshow
- Criação de conta com validação
- Login seguro
- Configuração inicial do perfil

### 🏠 Dashboard
- Visualização de todos os medidores cadastrados
- Status em tempo real de cada medidor
- Consumo atual e vazão instantânea
- Estatísticas mensais agregadas
- Acesso rápido aos detalhes de cada dispositivo

### 📊 Relatórios e estatísticas
- Gráficos de consumo por período (7, 14, 30, 90 dias)
- Análise de gastos em reais
- Comparativo de economia mensal
- Filtros customizados por data
- Métricas de vazão média e picos

### 🧠 Insights com IA
- Sugestões personalizadas de economia
- Análise de padrões de consumo
- Alertas de uso anormal
- Recomendações baseadas em histórico

### ⚙️ Configurações
- Gerenciamento de medidores
- Definição de limites de consumo e alertas
- Configuração de notificações personalizadas
- Edição de perfil e dados do usuário
- Cadastro e exclusão de dispositivos

---

## 📁 Estrutura do projeto

```
lib/
 ├── auth/                          # Autenticação
 │   └── auth_manager.dart
 ├── backend/
 │   ├── api_requests/              # Chamadas à API
 │   │   └── api_calls.dart
 │   └── schema/                    # Modelos de dados
 │       └── structs/
 │           ├── user_struct.dart
 │           ├── medidor_struct.dart
 │           └── ...
 ├── components/                    # Componentes reutilizáveis
 │   ├── cards/
 │   ├── custom_app_bar/
 │   ├── medidor_card/
 │   ├── power_button/
 │   ├── realtime_cards/
 │   └── suggestion_list/
 ├── flutter_flow/                  # Utilitários FlutterFlow
 │   ├── flutter_flow_util.dart
 │   ├── flutter_flow_widgets.dart
 │   ├── flutter_flow_charts.dart
 │   └── nav/
 ├── pages/
 │   ├── main_pages/                # Páginas principais
 │   │   ├── home_page/
 │   │   ├── stats_page/
 │   │   ├── insights_page/
 │   │   ├── settings_page/
 │   │   ├── medidor_details_page/
 │   │   └── medidor_settings_page/
 │   ├── onboarding/                # Fluxo de entrada
 │   │   ├── splash/
 │   │   ├── onboarding_slideshow/
 │   │   ├── sign_in/
 │   │   ├── onboarding_createaccount/
 │   │   └── add_device/
 │   └── profile_type/
 ├── app_state.dart                 # Estado global
 └── main.dart                      # Ponto de entrada
```

---

## 🌐 Integração com backend

O app se comunica com a API REST desenvolvida em Quarkus através de endpoints HTTP.

**URL base:** `https://aqualy.tanz.dev`

### 🔹 Principais endpoints utilizados

#### Autenticação
- `POST /auth/login` — Login e autenticação
- `POST /auth/registro` — Criação de nova conta

#### Usuários
- `GET /usuarios/{id}` — Dados do usuário
- `PUT /usuarios/{id}` — Atualização de perfil

#### Medidores
- `GET /medidores/usuario/{usuarioId}` — Lista medidores do usuário
- `GET /medidores/{id}` — Detalhes de um medidor
- `PUT /medidores/{id}` — Atualiza configurações do medidor
- `DELETE /medidores/{id}` — Remove medidor do sistema

#### Leituras e tempo real
- `GET /leituras/tempo-real/medidor/{medidorId}` — Dados em tempo real
- `GET /leituras/tempo-real/usuario/{usuarioId}` — Todos os medidores

#### Estatísticas
- `GET /estatisticas/usuario/{id}` — Estatísticas mensais
- `GET /estatisticas/grafico/usuario/{id}` — Dados para gráficos
- `GET /estatisticas/grafico/medidor/{id}` — Gráfico por medidor

#### Sugestões IA
- `GET /sugestoes/medidor/{id}` — Insights personalizados

---

## 🔧 Gerenciamento de estado

O app utiliza **Provider** para gerenciamento de estado global através da classe `FFAppState`.

### Estados principais:
- `loggedUser` — Dados do usuário autenticado
- `medidores` — Lista de medidores cadastrados
- `selectedInterval` — Período selecionado para análise
- `insightSelectedMedidor` — Medidor selecionado na tela de insights
- `alertsConfig` — Configurações de alertas e notificações

---

## 🧩 Componentes reutilizáveis

### 🎴 Cards
- **MedidorCard** — Exibe informações de um medidor
- **RealtimeCards** — Dados em tempo real
- **Cards** — Card genérico com estatísticas

### 📋 Listas
- **SuggestionList** — Lista de sugestões da IA
- **EmptyList** — Estado vazio com ilustração

### 🎨 Outros
- **CustomAppBar** — Barra superior personalizada
- **Header** — Cabeçalho de seções
- **Menu** — Menu lateral

---

## 📱 Navegação

O app utiliza **GoRouter** com navegação baseada em rotas nomeadas.

### Principais rotas:

| Rota | Descrição | Auth |
|------|-----------|------|
| `/` | Splash / Home | Condicional |
| `/splash` | Tela inicial | Não |
| `/onboarding-slideshow` | Apresentação | Não |
| `/sign-in` | Login | Não |
| `/onboarding-createaccount` | Cadastro | Não |
| `/home` | Dashboard | Sim |
| `/stats` | Relatórios | Sim |
| `/insights` | Insights IA | Sim |
| `/medidor-details` | Detalhes do medidor | Sim |
| `/settings` | Configurações | Sim |
| `/add-device` | Adicionar medidor | Sim |

---

## 🧪 Como executar o projeto

### ⚙️ Pré-requisitos

- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio / Xcode (para build nativo)
- Acesso à API backend

### 📦 Instalação

```bash
# Clonar o repositório
git clone https://github.com/tanzbr/aqualy.git
cd aqualy/aqualy-app

# Instalar dependências
flutter pub get

# Configurar dependências locais
cd dependencies/custom_date_range_picker_wcsgof
flutter pub get
cd ../ff_commons
flutter pub get
cd ../ff_theme
flutter pub get
cd ../..

# Executar em modo debug
flutter run
```

### 🌐 Configuração da API

Editar a URL base em `lib/backend/api_requests/api_calls.dart`:

```dart
static String getBaseUrl() => 'https://aqualy.tanz.dev';
```

---

## 📲 Build para produção

### Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle (Google Play)
flutter build appbundle --release
```

### iOS

```bash
# Build iOS
flutter build ios --release
```

### Web

```bash
# Build Web
flutter build web --release
```

---

## 🎨 Design e UI/UX

- **Tema customizado** com `FlutterFlowTheme`
- **Fonte principal:** Google Fonts
- **Ícones:** Font Awesome + Material Icons
- **Animações:** flutter_animate para transições
- **Gráficos:** fl_chart com estilo customizado
- **Responsividade:** Adapta-se a diferentes tamanhos de tela

---

## 🧠 Integração com sensores

Os sensores físicos se comunicam com o backend via WebSocket, e o app consome os dados processados através da API REST.

**Hardware:**
- Sensor de vazão YF-S201
- ESP32 como controlador
- Comunicação via WebSocket com o servidor

**Fluxo:**
1. Sensor → ESP32 → Backend (WebSocket)
2. Backend processa e armazena dados
3. App consulta dados via API REST
4. Usuário visualiza em tempo real

---

## 👥 Autores

**Cauã Fernandes, Dejanildo Júnior, Gisele Veloso, João Víttor Costa e Thalyssa Freitas**

---

## 📄 Licença

Este projeto foi desenvolvido para fins acadêmicos no contexto do **HACKÁGUA - UNITINS**.

---

# UNITINS - HACKÁGUA

