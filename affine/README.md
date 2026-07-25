# AFFiNE (Docker Compose)

Stack do AFFiNE para auto-hospedagem com Docker Compose, incluindo PostgreSQL, Redis e job de migração inicial.

## Como usar

1. Entre na pasta do serviço:

```powershell
cd affine
```

2. Copie o arquivo de exemplo e ajuste as variáveis:

```powershell
cp .env.example .env
```

3. Crie a rede externa `shared` (se ainda não existir):

```powershell
docker network create shared
```

4. Suba os containers:

```powershell
docker compose up -d
```

5. Acesse no navegador:

`http://<HOST>:3010`

## Variáveis de ambiente

| Variável | Obrigatória | Padrão | Descrição |
| --- | --- | --- | --- |
| `AFFINE_REVISION` | Não | `stable` | Canal/versão da imagem (`stable`, `beta`, `canary`). |
| `PORT` | Não | `3010` | Porta HTTP exposta no host. |
| `AFFINE_SERVER_EXTERNAL_URL` | Não | vazio | URL pública da instância (recomendado para links corretos em produção). |
| `AFFINE_INDEXER_ENABLED` | Não | `false` | Ativa/desativa indexador interno do AFFiNE. |
| `DB_DATA_LOCATION` | Não | `./postgres` | Persistência do PostgreSQL no host. |
| `UPLOAD_LOCATION` | Não | `./storage` | Persistência dos arquivos enviados (blobs). |
| `CONFIG_LOCATION` | Não | `./config` | Persistência de configurações do AFFiNE. |
| `DB_USERNAME` | Não | `affine` | Usuário do PostgreSQL. |
| `DB_PASSWORD` | Sim | — | Senha do PostgreSQL (defina antes do primeiro start). |
| `DB_DATABASE` | Não | `affine` | Nome do banco PostgreSQL. |

## Comandos úteis

- Subir em background: `docker compose up -d`
- Ver logs: `docker compose logs -f affine`
- Parar: `docker compose down`
- Atualizar imagens: `docker compose pull && docker compose up -d`

## Segurança

- Defina uma senha forte em `DB_PASSWORD` antes da primeira execução.
- Em produção, publique por HTTPS via Nginx Proxy Manager e configure `AFFINE_SERVER_EXTERNAL_URL`.
- Faça backup periódico de `DB_DATA_LOCATION`, `UPLOAD_LOCATION` e `CONFIG_LOCATION`.
- Não comite o arquivo `.env`.

## Documentação oficial

- Self-host AFFiNE: https://docs.affine.pro/self-host-affine/
- Docker Compose de referência: https://docs.affine.pro/self-host-affine/references/docker-compose-yml
