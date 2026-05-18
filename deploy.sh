#!/bin/bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 Iniciando Deploy da Turistar Viagem${NC}"

# 1. Verificar dependências
echo -e "${YELLOW}1️⃣ Verificando dependências...${NC}"
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter não está instalado${NC}"
    exit 1
fi

if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js não está instalado${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Dependências OK${NC}"

# 2. Limpar projeto
echo -e "${YELLOW}2️⃣ Limpando projeto...${NC}"
flutter clean
flutter pub get

# 3. Build web
echo -e "${YELLOW}3️⃣ Gerando build web...${NC}"
flutter build web --release --web-renderer html

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Erro ao gerar build web${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Build web gerado com sucesso${NC}"

# 4. Verificar tamanho do build
echo -e "${YELLOW}4️⃣ Verificando tamanho do build...${NC}"
BUILD_SIZE=$(du -sh build/web | cut -f1)
echo -e "${GREEN}📦 Tamanho do build: $BUILD_SIZE${NC}"

# 5. Deploy em Vercel
echo -e "${YELLOW}5️⃣ Fazendo deploy em Vercel...${NC}"
if command -v vercel &> /dev/null; then
    vercel --prod --confirm
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Deploy em Vercel concluído${NC}"
    else
        echo -e "${RED}❌ Erro ao fazer deploy em Vercel${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠️ Vercel CLI não encontrado. Pulando deploy em Vercel${NC}"
    echo -e "${YELLOW}   Instale com: npm install -g vercel${NC}"
fi

# 6. Deploy em Firebase (opcional)
echo -e "${YELLOW}6️⃣ Fazendo deploy em Firebase...${NC}"
if command -v firebase &> /dev/null; then
    read -p "Deseja fazer deploy em Firebase também? (s/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        firebase deploy
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Deploy em Firebase concluído${NC}"
        else
            echo -e "${RED}❌ Erro ao fazer deploy em Firebase${NC}"
        fi
    fi
else
    echo -e "${YELLOW}⚠️ Firebase CLI não encontrado${NC}"
    echo -e "${YELLOW}   Instale com: npm install -g firebase-tools${NC}"
fi

# 7. Resumo final
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Deploy Concluído com Sucesso!${NC}"
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo -e ""
echo -e "${YELLOW}📊 Resumo:${NC}"
echo -e "  • Build: build/web"
echo -e "  • Tamanho: $BUILD_SIZE"
echo -e "  • URL Vercel: https://app.agenciaturistar.com.br"
echo -e "  • URL Firebase: https://turistar-viagem.firebaseapp.com"
echo -e ""
echo -e "${YELLOW}📝 Próximos Passos:${NC}"
echo -e "  1. Verificar se o site está online"
echo -e "  2. Testar funcionalidades"
echo -e "  3. Monitorar analytics"
echo -e "  4. Publicar em App Store (iOS)"
echo -e "  5. Publicar em Google Play (Android)"
echo -e ""
