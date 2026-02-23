# PicoClaw

**PicoClaw** é um assistente de IA ultra-leve e de código aberto, escrito em Go. Consome menos de 10MB de RAM e inicializa em menos de 1 segundo — ideal para rodar em servidores modestos ou hardware barato (como Raspberry Pi e similares). Suporta múltiplos provedores de LLM (OpenRouter, OpenAI, Anthropic, Gemini, Groq) e pode se integrar ao Telegram e ao Discord.

> **Pergunta frequente:** "Dá pra usar o GitHub Copilot CLI junto com o PicoClaw?"
> Sim! O GitHub Copilot CLI é uma ferramenta de linha de comando que roda localmente na sua máquina (ou dentro de um container como o `code-server`). O PicoClaw é um servidor de IA auto-hospedado. Eles se complementam: enquanto o Copilot CLI ajuda diretamente no editor/terminal via nuvem do GitHub, o PicoClaw oferece um agente de IA local e privado, sem depender de subscrição externa.

## Recursos

- Consumo de memória < 10MB
- Inicialização em menos de 1 segundo
- Suporte a múltiplos provedores de LLM
- Integração com Telegram e Discord
- Modo gateway (serviço persistente) e modo agent (consulta única)
- Interface HTTP com endpoint `/health`
- Dados e configuração persistidos em volume local

## Como usar

### 1. Preparar o `.env`

```bash
cp .env.example .env
# Edite .env e defina pelo menos uma chave de API de LLM
```

### 2. Preparar o diretório de configuração

```bash
mkdir -p config
```

### 3. Subir o serviço gateway (modo persistente)

```bash
docker compose --profile gateway up -d
```

### 4. Verificar os logs

```bash
docker compose logs -f picoclaw-gateway
```

### 5. Verificar saúde do serviço

```bash
curl http://localhost:18790/health
```

## Modo Agent (consulta única)

Use o modo agent para perguntas pontuais sem subir um serviço persistente:

```bash
# Fazer uma pergunta direta
docker compose --profile agent run --rm picoclaw-agent -m "O que é Docker Compose?"

# Modo interativo
docker compose --profile agent run --rm picoclaw-agent
```

## Variáveis de Ambiente

| Variável               | Padrão            | Descrição                                                   |
|------------------------|-------------------|-------------------------------------------------------------|
| `TZ`                   | `America/Sao_Paulo` | Fuso horário                                              |
| `PICOCLAW_PORT`        | `18790`           | Porta exposta no host para a API/gateway                    |
| `CONFIG_DIR`           | `./config`        | Diretório de configuração persistida no host                |
| `PICOCLAW_MODEL`       | `gpt4`            | Modelo LLM padrão a ser usado                               |
| `OPENROUTER_API_KEY`   | *(recomendado)*   | Chave da API do OpenRouter (https://openrouter.ai/keys)     |
| `OPENAI_API_KEY`       | *(opcional)*      | Chave da API da OpenAI                                      |
| `TELEGRAM_BOT_TOKEN`   | *(opcional)*      | Token do bot Telegram para integração                       |
| `DISCORD_BOT_TOKEN`    | *(opcional)*      | Token do bot Discord para integração                        |

## Comandos Úteis

```bash
# Subir o gateway em background
docker compose --profile gateway up -d

# Ver logs do gateway
docker compose logs -f picoclaw-gateway

# Parar o gateway
docker compose --profile gateway down

# Consulta rápida com o agent
docker compose --profile agent run --rm picoclaw-agent -m "Sua pergunta aqui"

# Reiniciar o gateway
docker compose --profile gateway restart
```

## Segurança

- Nunca exponha sua chave de API (`OPENROUTER_API_KEY`, `OPENAI_API_KEY`) diretamente na internet.
- Use o **Nginx Proxy Manager** para proteger o endpoint com HTTPS e autenticação.
- O token do Telegram/Discord dá acesso ao seu bot — mantenha-o privado.
- Não faça commit do arquivo `.env` (já protegido pelo `.gitignore`).

## Usando com Nginx Proxy Manager

1. Remova (ou comente) a seção `ports` do serviço `picoclaw-gateway` no `docker-compose.yml`.
2. No Nginx Proxy Manager, crie um **Proxy Host** apontando para `picoclaw-gateway:18790`.

## Recursos e Documentação

- **GitHub oficial**: https://github.com/sipeed/picoclaw
- **Documentação**: https://github.com/sipeed/picoclaw/blob/main/docs
- **Imagem Docker**: `ghcr.io/sipeed/picoclaw`
- **Provedores LLM suportados**: OpenRouter, OpenAI, Anthropic, Gemini, Groq, Zhipu
