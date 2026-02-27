# Ollama + Open WebUI

**Ollama** é uma plataforma para executar modelos de linguagem (LLMs) localmente no seu servidor. Este compose inclui também o **Open WebUI**, uma interface web para interagir com os modelos diretamente pelo navegador.

## Recursos

- Execução local de LLMs (Llama, Mistral, Phi, Gemma e muito mais)
- Interface web intuitiva via Open WebUI
- Suporte a GPU NVIDIA (opcional)
- Dados e modelos persistidos em volume local
- Integra com Nginx Proxy Manager para HTTPS

## Como usar

### 1. Preparar o `.env`

```bash
cp .env.example .env
# Edite .env e defina as variáveis necessárias
```

### 2. Subir os containers

```bash
docker compose up -d
```

### 3. Baixar um modelo

```bash
docker exec -it ollama ollama pull llama3.2
```

### 4. Acessar o Open WebUI

Abra o navegador em:

```
http://<seu-ip>:3000
```

Na primeira vez, crie uma conta de administrador.

## Variáveis de Ambiente

| Variável            | Padrão                | Descrição                                           |
|---------------------|-----------------------|-----------------------------------------------------|
| `OLLAMA_PORT`       | `11434`               | Porta da API do Ollama no host                      |
| `OLLAMA_KEEP_ALIVE` | `24h`                 | Tempo que os modelos ficam carregados na memória    |
| `OLLAMA_DATA`       | `./ollama-data`       | Diretório para armazenar modelos no host            |
| `WEBUI_PORT`        | `3000`                | Porta do Open WebUI no host                         |
| `WEBUI_SECRET_KEY`  | *(obrigatório)*       | Chave secreta para sessões do Open WebUI            |
| `WEBUI_DATA`        | `./webui-data`        | Diretório de dados do Open WebUI no host            |
| `TZ`                | `America/Sao_Paulo`   | Fuso horário                                        |

## Comandos Úteis

```bash
# Subir em background
docker compose up -d

# Ver logs
docker compose logs -f ollama
docker compose logs -f open-webui

# Listar modelos instalados
docker exec -it ollama ollama list

# Baixar um modelo
docker exec -it ollama ollama pull mistral

# Remover um modelo
docker exec -it ollama ollama rm mistral

# Parar
docker compose down

# Reiniciar
docker compose restart
```

## Habilitando GPU NVIDIA

Descomente o bloco `deploy` no serviço `ollama` do `docker-compose.yml`:

```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: all
          capabilities: [gpu]
```

Certifique-se de que o [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) está instalado no host.

## Usando com Nginx Proxy Manager

1. Remova (ou comente) a seção `ports` do serviço `open-webui`.
2. No Nginx Proxy Manager, crie um **Proxy Host** apontando para `open-webui:8080`.

## Segurança

- Defina sempre um valor forte e aleatório para `WEBUI_SECRET_KEY`.
- Não exponha a porta da API do Ollama (`11434`) diretamente na internet.
- Use o **Nginx Proxy Manager** para expor o Open WebUI com HTTPS e domínio próprio.

## Recursos e Documentação

- **Ollama**: https://ollama.com
- **Modelos disponíveis**: https://ollama.com/library
- **Open WebUI**: https://github.com/open-webui/open-webui
- **Imagem Ollama Docker**: https://hub.docker.com/r/ollama/ollama
