# OpenGist (Open Gin)

OpenGist é uma alternativa self-hosted ao GitHub Gist para compartilhar snippets e anotações com versionamento via Git.

## Como usar

1. Copie o arquivo de exemplo de variáveis de ambiente:

   ```bash
   cp .env.example .env
   ```

2. (Opcional) Crie a rede externa `shared` se ainda não existir:

   ```bash
   docker network create shared
   ```

3. Suba o serviço:

   ```bash
   docker compose up -d
   ```

4. Acesse no navegador:

   ```text
   http://<seu-host>:6157
   ```

## Comandos úteis

```bash
# Subir em background
docker compose up -d

# Ver logs
docker compose logs -f opengist

# Parar e remover containers
docker compose down
```

## Segurança

- Não commite o arquivo `.env`.
- Em produção, publique o OpenGist atrás do Nginx Proxy Manager com HTTPS.

## Documentação oficial

- OpenGist: https://github.com/thomiceli/opengist
