# Portainer - Docker Compose Files

Este repositório contém arquivos Docker Compose para gerenciar múltiplos containers Docker.

## Serviços Disponíveis

### 1. Portainer
Ferramenta de gerenciamento Docker com interface web.

**Localização**: `portainer/`

**Portas**:
- 9000 (HTTP)
- 9443 (HTTPS)

**Como usar**:
```bash
cd portainer
docker-compose up -d
```

Acesse: http://localhost:9000

[Documentação completa](./portainer/README.md)

---

### 2. Nginx Proxy Manager
Gerenciador de proxy reverso com interface web e suporte a SSL/TLS.

**Localização**: `nginx-proxy-manager/`

**Portas**:
- 80 (HTTP)
- 443 (HTTPS)
- 81 (Admin)

**Como usar**:
```bash
cd nginx-proxy-manager
cp .env.example .env
# Edite o .env para alterar as senhas padrão
docker-compose up -d
```

Acesse: http://localhost:81

**Credenciais padrão**:
- Email: admin@example.com
- Senha: changeme

[Documentação completa](./nginx-proxy-manager/README.md)

---

## Estrutura do Repositório

```
.
├── portainer/              # Portainer Docker Compose
│   ├── docker-compose.yml
│   └── README.md
├── nginx-proxy-manager/    # Nginx Proxy Manager Docker Compose
│   ├── docker-compose.yml
│   └── README.md
└── README.md              # Este arquivo
```

## Requisitos

- Docker Engine 20.10+
- Docker Compose 2.0+

## Comandos Úteis

### Iniciar todos os serviços
```bash
# Portainer
cd portainer && docker-compose up -d && cd ..

# Nginx Proxy Manager
cd nginx-proxy-manager && docker-compose up -d && cd ..
```

### Parar todos os serviços
```bash
# Portainer
cd portainer && docker-compose down && cd ..

# Nginx Proxy Manager
cd nginx-proxy-manager && docker-compose down && cd ..
```

### Ver logs
```bash
# Portainer
cd portainer && docker-compose logs -f

# Nginx Proxy Manager
cd nginx-proxy-manager && docker-compose logs -f
```

## Notas de Segurança

⚠️ **Importante**: 

### Nginx Proxy Manager
- **Sempre** crie um arquivo `.env` a partir do `.env.example` e defina senhas fortes
- Os valores de placeholder no `.env.example` devem ser substituídos antes do uso
- Altere as credenciais padrão da interface web após o primeiro login
- As portas 80 e 443 podem conflitar com outros servidores web - verifique antes de iniciar
- Configure firewall adequadamente para controlar acesso externo

### Portainer
- O Portainer tem acesso total ao Docker daemon através do socket
- Configure autenticação forte na primeira vez que acessar
- Não exponha as portas publicamente sem proteção adicional (firewall, VPN, proxy reverso)
- Use HTTPS (porta 9443) em vez de HTTP (porta 9000) quando possível

### Geral
- Mantenha as imagens Docker sempre atualizadas: `docker-compose pull && docker-compose up -d`
- Em produção, use HTTPS para todas as comunicações
- Considere usar um proxy reverso (como o próprio Nginx Proxy Manager) para adicionar camadas extras de segurança
- Faça backup regular dos volumes Docker
