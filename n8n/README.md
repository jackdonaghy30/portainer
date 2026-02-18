# n8n - Workflow Automation

n8n é uma ferramenta de automação de workflows extensível que permite conectar qualquer coisa a qualquer coisa. É uma alternativa fair-code ao Zapier, Integromat e outros.

## 🚀 Início Rápido

### Pré-requisitos

- Docker
- Docker Compose

### Instalação

1. **Copie o arquivo de exemplo de variáveis de ambiente:**
   ```bash
   cp .env.example .env
   ```

2. **Edite o arquivo `.env` e configure suas variáveis:**
   - `N8N_ENCRYPTION_KEY`: Gere uma chave de criptografia segura (use `openssl rand -hex 32`)
   - `N8N_BASIC_AUTH_USER`: Nome de usuário para acesso
   - `N8N_BASIC_AUTH_PASSWORD`: Senha de acesso
   - Ajuste outras variáveis conforme necessário

3. **Inicie o container:**
   ```bash
   docker-compose up -d
   ```

4. **Acesse a interface web:**
   - URL: http://localhost:5678
   - Use as credenciais configuradas em `N8N_BASIC_AUTH_USER` e `N8N_BASIC_AUTH_PASSWORD`

## 📋 Configuração

### Variáveis de Ambiente

As principais variáveis de ambiente estão documentadas no arquivo `.env.example`:

- **N8N_HOST**: Hostname para acesso (padrão: localhost)
- **N8N_PORT**: Porta de acesso (padrão: 5678)
- **N8N_PROTOCOL**: Protocolo (http ou https)
- **WEBHOOK_URL**: URL para webhooks (importante para integrações externas)
- **TIMEZONE**: Fuso horário (padrão: America/Sao_Paulo)
- **N8N_ENCRYPTION_KEY**: Chave de criptografia (obrigatória)

### Banco de Dados

Por padrão, n8n usa SQLite para armazenamento local. Para ambientes de produção, recomenda-se PostgreSQL:

1. Descomente a seção `postgres` no `docker-compose.yml`
2. Configure as variáveis `DB_POSTGRESDB_*` no arquivo `.env`
3. Defina `DB_TYPE=postgresdb`

### Reverse Proxy

Para usar com Nginx Proxy Manager ou outro reverse proxy:

1. Remova ou comente o mapeamento de portas no `docker-compose.yml`
2. Configure o proxy reverso para apontar para o container `n8n` na porta 5678
3. Atualize `N8N_PROTOCOL`, `N8N_HOST` e `WEBHOOK_URL` no `.env`

Exemplo com HTTPS:
```env
N8N_PROTOCOL=https
N8N_HOST=n8n.seudominio.com
WEBHOOK_URL=https://n8n.seudominio.com/
```

## 🔧 Comandos Úteis

### Ver logs
```bash
docker-compose logs -f n8n
```

### Parar o serviço
```bash
docker-compose down
```

### Reiniciar o serviço
```bash
docker-compose restart
```

### Atualizar para a versão mais recente
```bash
docker-compose pull
docker-compose up -d
```

### Backup dos dados
```bash
# Backup do volume de dados
docker run --rm -v n8n_n8n_data:/data -v $(pwd):/backup alpine tar czf /backup/n8n-backup-$(date +%Y%m%d).tar.gz -C /data .
```

## 📚 Recursos

- [Documentação Oficial do n8n](https://docs.n8n.io/)
- [Galeria de Workflows](https://n8n.io/workflows)
- [Comunidade n8n](https://community.n8n.io/)
- [n8n no GitHub](https://github.com/n8n-io/n8n)

## ⚠️ Segurança

**IMPORTANTE**: 
- **Sempre** altere as senhas padrão
- **Nunca** commite o arquivo `.env` para o repositório
- Use uma chave de criptografia forte e única
- Se expor publicamente, use HTTPS e autenticação forte
- Considere usar autenticação mais robusta (OAuth, LDAP) para produção

## 🐛 Troubleshooting

### Container não inicia
- Verifique se a porta 5678 não está em uso: `netstat -tuln | grep 5678`
- Verifique os logs: `docker-compose logs n8n`

### Problemas de permissão
- Certifique-se de que o volume tem as permissões corretas
- O n8n roda com UID 1000 por padrão

### Webhooks não funcionam
- Verifique se `WEBHOOK_URL` está configurado corretamente
- Se usar reverse proxy, certifique-se de que os headers estão sendo repassados corretamente
