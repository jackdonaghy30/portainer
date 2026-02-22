# ncdu-web-viewer

Interface web para visualizar e navegar pelos resultados do [ncdu](https://dev.yorhel.nl/ncdu) (analisador de uso de disco).

- **GitHub**: https://github.com/abes-esr/ncdu-web-viewer
- **Docker Hub**: https://hub.docker.com/r/abesesr/ncdu-web-viewer

## Como usar

### 1. Preparar o `.env`

```bash
cp .env.example .env
# Edite .env e ajuste os caminhos e variáveis
```

### 2. Subir o container

```bash
docker compose up -d
```

### 3. Acessar

Abra o navegador em:

```
http://<seu-ip>:3000
```

---

## Modos de operação

### Modo `folder` (padrão) — escanear uma pasta

O ncdu escaneia a pasta `/folder-to-scan/` dentro do container. Monte a pasta desejada do host neste caminho.

Exemplo: analisar a pasta `/applis/` do host:

```bash
FOLDER_TO_SCAN=/applis
NCDU_WEB_VIEWER_SCAN_FROM=folder
NCDU_WEB_VIEWER_READONLY=no
```

Acesse: `http://<seu-ip>:3000`

### Modo `dump` — visualizar um dump pré-calculado

Gere o dump no servidor a ser analisado:

```bash
ncdu -o /tmp/ncdu-dump.json /applis/
```

Copie o dump e configure:

```bash
NCDU_DUMP_FILE=/opt/ncdu-dump.json
NCDU_WEB_VIEWER_SCAN_FROM=dump
```

Acesse: `http://<seu-ip>:3000/wetty/`

---

## Variáveis de Ambiente

| Variável                       | Padrão      | Descrição                                                   |
|--------------------------------|-------------|-------------------------------------------------------------|
| `NCDU_WEB_VIEWER_SCAN_FROM`    | `folder`    | Modo de operação: `folder` ou `dump`                       |
| `NCDU_WEB_VIEWER_READONLY`     | `yes`       | Somente-leitura (`yes`/`no`), usado com `SCAN_FROM=folder` |
| `FOLDER_TO_SCAN`               | `./folder-to-scan` | Pasta do host a ser montada em `/folder-to-scan`   |
| `NCDU_DUMP_FILE`               | `./ncdu-dump.json` | Arquivo de dump do host a ser montado em `/ncdu-dump.json` |
| `PORT`                         | `3000`      | Porta exposta no host                                       |

## Comandos Úteis

```bash
# Subir em background
docker compose up -d

# Ver logs
docker compose logs -f ncdu-web-viewer

# Parar
docker compose down

# Reiniciar
docker compose restart ncdu-web-viewer
```
