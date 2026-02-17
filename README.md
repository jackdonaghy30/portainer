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
- Altere as senhas padrão do Nginx Proxy Manager antes de usar em produção
- Configure firewall adequadamente para restringir acesso às portas
- Use HTTPS sempre que possível
- Mantenha as imagens Docker atualizadas
