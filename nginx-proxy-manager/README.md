# Nginx Proxy Manager

Nginx Proxy Manager é uma ferramenta de gerenciamento de proxy reverso com interface web, que facilita a configuração de proxies, SSL/TLS e redirecionamentos.

## Como usar

### Iniciar o Nginx Proxy Manager

```bash
docker-compose up -d
```

### Parar o Nginx Proxy Manager

```bash
docker-compose down
```

### Acessar o Nginx Proxy Manager

Após iniciar os containers, acesse a interface de administração através de:

- Interface Admin: http://localhost:81

### Primeira vez

Credenciais padrão para o primeiro acesso:
- **Email**: admin@example.com
- **Senha**: changeme

⚠️ **Importante**: Altere a senha após o primeiro login!

## Portas

- **80**: HTTP (tráfego web)
- **443**: HTTPS (tráfego web seguro)
- **81**: Interface de administração web

## Volumes

- **npm_data**: Dados de configuração do Nginx Proxy Manager
- **npm_letsencrypt**: Certificados SSL/TLS do Let's Encrypt
- **npm_mysql**: Banco de dados MariaDB

## Serviços

### nginx-proxy-manager
Interface web e servidor proxy

### db (MariaDB)
Banco de dados para armazenar configurações

**Credenciais do banco:**
- Usuário: npm
- Senha: npm_password
- Database: npm

⚠️ **Segurança**: Altere as senhas no arquivo docker-compose.yml antes de usar em produção!

## Características

- Interface web intuitiva
- Configuração fácil de proxy reverso
- Certificados SSL gratuitos via Let's Encrypt
- Redirecionamentos HTTP
- Suporte para WebSocket
- Access Lists para controle de acesso
