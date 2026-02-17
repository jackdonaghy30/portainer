# Portainer

Portainer é uma ferramenta de gerenciamento Docker baseada na web que facilita a administração de containers, imagens, volumes e redes Docker.

## Como usar

### Iniciar o Portainer

```bash
docker-compose up -d
```

### Parar o Portainer

```bash
docker-compose down
```

### Acessar o Portainer

Após iniciar o container, acesse o Portainer através de:

- HTTP: http://localhost:9000
- HTTPS: https://localhost:9443

### Primeira vez

Na primeira vez que acessar, você precisará:
1. Criar uma conta de administrador (usuário e senha)
2. Conectar ao Docker local (já configurado automaticamente via socket)

## Portas

- **9000**: Interface web HTTP
- **9443**: Interface web HTTPS

## Volumes

- **portainer_data**: Armazena os dados de configuração do Portainer
- **/var/run/docker.sock**: Socket do Docker (permite gerenciar o Docker host)

⚠️ **Aviso de Segurança**: O Portainer tem acesso total ao Docker daemon através do socket. Isso significa que:
- Qualquer usuário com acesso ao Portainer pode gerenciar todos os containers
- Em produção, configure autenticação forte e considere usar controles de acesso
- Não exponha a porta 9000/9443 publicamente sem proteção adicional (firewall, VPN, etc.)
- Considere usar HTTPS (porta 9443) em vez de HTTP (porta 9000) para comunicação segura

## Características

- Interface web intuitiva
- Gerenciamento de containers, imagens, volumes e redes
- Suporte para Docker Swarm e Kubernetes
- Controle de acesso baseado em usuários
- Templates de aplicação
