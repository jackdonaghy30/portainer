# Laya AI Playground

O Laya AI Playground é uma interface web para testar e explorar recursos de IA em um ambiente auto-hospedado. Este diretório segue o mesmo padrão do repositório e permite subir o serviço com Docker Compose.

## Como usar

1. Copie o arquivo de variáveis de ambiente:

```bash
cp .env.example .env
```

2. Ajuste os valores no arquivo `.env`, especialmente `LAYA_IMAGE`, `LAYA_PORT` e `LAYA_API_KEY`.

3. Inicie o serviço:

```bash
cd laya-ai
docker compose up -d
```

4. Acesse o playground em:

```text
http://<seu-host>:8080
```

## Variáveis de ambiente

| Variável | Padrão | Descrição |
|---|---|---|
| `TZ` | `America/Sao_Paulo` | Fuso horário do container |
| `LAYA_HOST` | `0.0.0.0` | Endereço de bind do serviço |
| `LAYA_PORT` | `8080` | Porta exposta no host |
| `LAYA_IMAGE` | `ghcr.io/laya-ai/playground:latest` | Imagem Docker a ser usada |
| `LAYA_API_KEY` | `replace-with-secure-token` | Token opcional para autenticação |

## Comandos úteis

```bash
# Subir em background
docker compose up -d

# Ver logs
docker compose logs -f

# Parar e remover os containers
docker compose down
```

## Segurança

- Nunca commite o arquivo `.env` com valores reais.
- Use uma `LAYA_API_KEY` forte e não reutilizada.
- Em produção, exponha o serviço via HTTPS usando o Nginx Proxy Manager.
- Não exponha portas internas de APIs sem proteção.

## Links

- Playground Laya AI: https://laya-ai.com/#playground
- Documentação oficial: https://laya-ai.com/
