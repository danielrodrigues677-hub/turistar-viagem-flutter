#!/bin/bash

# ============================================================================
# Deploy Script para Turistar Viagem - Flutter Web, iOS e Android
# ============================================================================
# Este script automatiza o processo de build e deploy para:
# - Web (Vercel e Firebase)
# - iOS (App Store)
# - Android (Google Play)
# ============================================================================

set -e  # Exit on error

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configurações
PROJECT_NAME="Turistar Viagem"
BUILD_DIR="build"
WEB_BUILD_DIR="$BUILD_DIR/web"
ANDROID_BUILD_DIR="$BUILD_DIR/app/outputs/bundle/release"
IOS_BUILD_DIR="$BUILD_DIR/ios/iphoneos"

# ============================================================================
# FUNÇÕES AUXILIARES
# ============================================================================

print_header() {
    echo -e "\n${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}\n"
}

print_step() {
    echo -e "${YELLOW}$1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

check_command() {
    if ! command -v $1 &> /dev/null; then
        print_error "$1 não está instalado"
        echo -e "${YELLOW}   Instale com: $2${NC}"
        return 1
    fi
    return 0
}

# ============================================================================
# VERIFICAÇÕES INICIAIS
# ============================================================================

print_header "🚀 Deploy $PROJECT_NAME"

print_step "1️⃣ Verificando dependências..."

if ! check_command "flutter" "https://flutter.dev/docs/get-started/install"; then
    exit 1
fi

if ! check_command "node" "https://nodejs.org/"; then
    exit 1
fi

print_success "Dependências verificadas"

# ============================================================================
# MENU DE SELEÇÃO
# ============================================================================

print_header "📱 Selecione o tipo de deploy"

echo "1) Web (Vercel)"
echo "2) Web (Firebase)"
echo "3) Android (Google Play)"
echo "4) iOS (App Store)"
echo "5) Todos (Web + Mobile)"
echo "6) Sair"
echo ""
read -p "Escolha uma opção (1-6): " DEPLOY_OPTION

case $DEPLOY_OPTION in
    1) DEPLOY_WEB_VERCEL=true; DEPLOY_WEB_FIREBASE=false; DEPLOY_ANDROID=false; DEPLOY_IOS=false ;;
    2) DEPLOY_WEB_VERCEL=false; DEPLOY_WEB_FIREBASE=true; DEPLOY_ANDROID=false; DEPLOY_IOS=false ;;
    3) DEPLOY_WEB_VERCEL=false; DEPLOY_WEB_FIREBASE=false; DEPLOY_ANDROID=true; DEPLOY_IOS=false ;;
    4) DEPLOY_WEB_VERCEL=false; DEPLOY_WEB_FIREBASE=false; DEPLOY_ANDROID=false; DEPLOY_IOS=true ;;
    5) DEPLOY_WEB_VERCEL=true; DEPLOY_WEB_FIREBASE=true; DEPLOY_ANDROID=true; DEPLOY_IOS=true ;;
    6) print_warning "Deploy cancelado"; exit 0 ;;
    *) print_error "Opção inválida"; exit 1 ;;
esac

# ============================================================================
# LIMPEZA E PREPARAÇÃO
# ============================================================================

print_step "2️⃣ Limpando e preparando projeto..."
flutter clean
flutter pub get
print_success "Projeto preparado"

# ============================================================================
# BUILD WEB
# ============================================================================

if [ "$DEPLOY_WEB_VERCEL" = true ] || [ "$DEPLOY_WEB_FIREBASE" = true ]; then
    print_step "3️⃣ Gerando build web..."
    
    flutter build web --release --web-renderer html
    
    if [ $? -ne 0 ]; then
        print_error "Erro ao gerar build web"
        exit 1
    fi
    
    BUILD_SIZE=$(du -sh $WEB_BUILD_DIR | cut -f1)
    print_success "Build web gerado ($BUILD_SIZE)"
fi

# ============================================================================
# DEPLOY WEB - VERCEL
# ============================================================================

if [ "$DEPLOY_WEB_VERCEL" = true ]; then
    print_step "4️⃣ Fazendo deploy em Vercel..."
    
    if check_command "vercel" "npm install -g vercel"; then
        vercel --prod --confirm
        if [ $? -eq 0 ]; then
            print_success "Deploy Vercel concluído"
        else
            print_error "Erro ao fazer deploy em Vercel"
            exit 1
        fi
    else
        print_warning "Vercel CLI não encontrado. Pulando deploy Vercel"
    fi
fi

# ============================================================================
# DEPLOY WEB - FIREBASE
# ============================================================================

if [ "$DEPLOY_WEB_FIREBASE" = true ]; then
    print_step "5️⃣ Fazendo deploy em Firebase..."
    
    if check_command "firebase" "npm install -g firebase-tools"; then
        firebase deploy --only hosting
        if [ $? -eq 0 ]; then
            print_success "Deploy Firebase concluído"
        else
            print_error "Erro ao fazer deploy em Firebase"
            exit 1
        fi
    else
        print_warning "Firebase CLI não encontrado. Pulando deploy Firebase"
    fi
fi

# ============================================================================
# BUILD ANDROID
# ============================================================================

if [ "$DEPLOY_ANDROID" = true ]; then
    print_step "6️⃣ Gerando build Android..."
    
    flutter build appbundle --release
    
    if [ $? -ne 0 ]; then
        print_error "Erro ao gerar build Android"
        exit 1
    fi
    
    print_success "Build Android gerado"
    print_warning "Próximo passo: Fazer upload em Google Play Console"
    echo -e "${YELLOW}   Arquivo: $ANDROID_BUILD_DIR/app-release.aab${NC}"
fi

# ============================================================================
# BUILD iOS
# ============================================================================

if [ "$DEPLOY_IOS" = true ]; then
    print_step "7️⃣ Gerando build iOS..."
    
    flutter build ios --release
    
    if [ $? -ne 0 ]; then
        print_error "Erro ao gerar build iOS"
        exit 1
    fi
    
    print_success "Build iOS gerado"
    print_warning "Próximo passo: Fazer upload em App Store Connect"
    echo -e "${YELLOW}   Abra em Xcode: open ios/Runner.xcworkspace${NC}"
fi

# ============================================================================
# RESUMO FINAL
# ============================================================================

print_header "✅ Deploy Concluído!"

echo -e "${YELLOW}📊 Resumo:${NC}"
echo ""

if [ "$DEPLOY_WEB_VERCEL" = true ]; then
    echo -e "  🌐 Web (Vercel): https://app.agenciaturistar.com.br"
fi

if [ "$DEPLOY_WEB_FIREBASE" = true ]; then
    echo -e "  🌐 Web (Firebase): https://turistar-viagem.firebaseapp.com"
fi

if [ "$DEPLOY_ANDROID" = true ]; then
    echo -e "  🤖 Android: Google Play Console"
    echo -e "     Arquivo: $ANDROID_BUILD_DIR/app-release.aab"
fi

if [ "$DEPLOY_IOS" = true ]; then
    echo -e "  🍎 iOS: App Store Connect"
    echo -e "     Abra em Xcode: open ios/Runner.xcworkspace"
fi

echo ""
echo -e "${YELLOW}📝 Próximos Passos:${NC}"
echo -e "  1. Verificar se o site está online"
echo -e "  2. Testar funcionalidades em todos os devices"
echo -e "  3. Monitorar analytics e logs"
echo -e "  4. Configurar domínio customizado (se necessário)"
echo -e "  5. Ativar HTTPS e certificados SSL"
echo ""

print_success "Tudo pronto! 🎉"
