# Turistar Viagem - Plataforma de Viagens em Flutter

Plataforma multiplataforma (Web, iOS, Android) para busca e reserva de voos, hotéis, aluguel de carros e seguros de viagem.

## 🎯 Características

- ✈️ Busca de voos (nacionais e internacionais)
- 🏨 Busca de hotéis
- 🚗 Aluguel de carros
- 🛡️ Seguros de viagem
- 💳 Sistema de pagamento integrado
- 👤 Autenticação de usuários
- 📱 Responsivo para mobile e web
- 🌍 Suporte multiplataforma (Web, iOS, Android)

## 🛠️ Tecnologias

- **Flutter 3.x** - Framework multiplataforma
- **Dart** - Linguagem de programação
- **Provider** - Gerenciamento de estado
- **Go Router** - Navegação
- **Dio** - Cliente HTTP
- **Firebase** - Autenticação e Analytics
- **Stripe** - Pagamentos
- **Hive** - Armazenamento local

## 📁 Estrutura do Projeto

```
lib/
├── config/
│   ├── theme/
│   │   └── app_theme.dart
│   └── router/
│       └── app_router.dart
├── providers/
│   └── app_providers.dart
├── screens/
│   ├── home/
│   ├── flights/
│   ├── hotels/
│   ├── cars/
│   ├── insurance/
│   ├── checkout/
│   └── confirmation/
├── models/
│   ├── flight.dart
│   ├── hotel.dart
│   ├── booking.dart
│   └── user.dart
├── services/
│   ├── api_service.dart
│   ├── auth_service.dart
│   ├── flight_service.dart
│   └── payment_service.dart
├── widgets/
│   └── common/
├── utils/
│   ├── constants.dart
│   └── extensions.dart
└── main.dart
```

## 🚀 Como Começar

### Pré-requisitos

- Flutter SDK estável atual instalado (validado com Flutter 3.44.0)
- Dart SDK
- Android Studio (para Android)
- Xcode (para iOS)

### Instalação

1. Clone o repositório
```bash
git clone https://github.com/danielrodrigues677-hub/turistar-viagem-flutter.git
cd turistar-viagem-flutter
```

2. Instale as dependências
```bash
flutter pub get
```

3. Execute o projeto
```bash
flutter run
```


### Rodar no Android Studio

1. Instale o Flutter SDK estável atual e o Android Studio.
2. Abra a pasta raiz deste repositório no Android Studio.
3. Aguarde o Android Studio criar/atualizar `android/local.properties` com o caminho do Flutter SDK.
4. Rode:
```bash
flutter pub get
flutter run -d android
```

> Observação: Firebase, Stripe e APIs reais ainda não estão ligados. O app Android atual roda como protótipo visual com dados mockados de voos.

### Executar em diferentes plataformas

**Web:**
```bash
flutter run -d chrome
```

**iOS:**
```bash
flutter run -d ios
```

**Android:**
```bash
flutter run -d android
```

## 🔌 Integração com APIs

### Pátria Consolidadora

A integração com a API da Pátria Consolidadora está planejada para:
- Busca de voos em tempo real
- Busca de hotéis
- Aluguel de carros
- Seguros de viagem

**Credenciais:**
```dart
const String PATRIA_API_KEY = 'YOUR_API_KEY';
const String PATRIA_API_URL = 'https://api.patria.com.br';
```

### Stripe (Pagamentos)

Integração com Stripe para processamento de pagamentos:
- Cartão de crédito
- Cartão de débito
- PIX
- Boleto

## 📱 Responsividade

A aplicação é totalmente responsiva e otimizada para:
- Desktops (Web)
- Tablets
- Smartphones (iOS e Android)

## 🔐 Segurança

- Autenticação OAuth com Google
- Criptografia de dados sensíveis
- Validação de CPF/CNPJ
- Conformidade com LGPD

## 📊 Analytics

Integração com Firebase Analytics para rastrear:
- Buscas de voos
- Reservas completadas
- Conversões
- Comportamento do usuário

## 🐛 Troubleshooting

### Erro: "Flutter not found"
```bash
export PATH="$PATH:~/flutter/bin"
```

### Erro: "CocoaPods not installed"
```bash
sudo gem install cocoapods
```

### Erro: "Android SDK not found"
Configure a variável `ANDROID_HOME`:
```bash
export ANDROID_HOME=~/Android/Sdk
```

## 📝 Licença

MIT License - veja LICENSE.md para detalhes

## 👥 Autores

- Turistar Viagens - [contato@agenciaturistar.com.br](mailto:contato@agenciaturistar.com.br)

## 📞 Suporte

Para suporte, envie um email para: [contato@agenciaturistar.com.br](mailto:contato@agenciaturistar.com.br)
