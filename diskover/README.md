# Diskover Community

Indexador de arquivos com interface web, powered by Elasticsearch e Redis.

- Pasta: `diskover/`
- Arquivos: `docker-compose.yml`, `.env.example`

---

## Por que o Elasticsearch é necessário?

O **Diskover** usa o Elasticsearch como seu mecanismo de busca e armazenamento de metadados. Cada arquivo e diretório indexado é armazenado como um documento no Elasticsearch, o que permite:

- Buscas por nome, tamanho, data, tipo de arquivo, tags e metadados personalizados.
- Filtros e agregações em tempo real sobre grandes volumes de dados (milhões de arquivos).
- Interface web rápida e responsiva mesmo com datasets massivos.

Sem o Elasticsearch, o Diskover não consegue armazenar nem pesquisar o índice de arquivos.

---

## Serviços incluídos

| Serviço           | Imagem                                               | Descrição                           |
|-------------------|------------------------------------------------------|-------------------------------------|
| `elasticsearch`   | `docker.elastic.co/elasticsearch/elasticsearch:7.17.10` | Motor de busca e armazenamento do índice |
| `redis`           | `redis:7-alpine`                                     | Fila de tarefas do indexador        |
| `diskover`        | `lscr.io/linuxserver/diskover:latest`                | Interface web + indexador de arquivos |

---

## Portas expostas

| Serviço         | Porta padrão | Variável          |
|-----------------|:------------:|-------------------|
| Diskover Web UI | `8000`       | `DISKOVER_PORT`   |
| Elasticsearch   | `9200`       | `ES_PORT`         |

> O Redis **não** expõe porta para o host — ele só é acessível internamente pela rede `diskover`.

---

## Como subir a stack

### Via `docker compose` (linha de comando)

```bash
# 1. Clone o repositório e entre na pasta
cd diskover/

# 2. Copie o arquivo de variáveis e ajuste conforme necessário
cp .env.example .env

# 3. Suba os containers
docker compose up -d

# 4. Verifique se todos estão rodando
docker compose ps
```

### Via Portainer

1. Acesse o Portainer (ex.: `http://<host>:9000`).
2. Vá em **Stacks → + Add stack**.
3. Dê um nome à stack (ex.: `diskover`).
4. Escolha **Upload** e selecione o `docker-compose.yml`, **ou** cole o conteúdo diretamente no editor.
5. Em **Environment variables**, adicione as variáveis do `.env.example` que desejar customizar (ex.: `DATA_LOCATION`, `ES_HEAP_SIZE`, `TZ`).
6. Clique em **Deploy the stack**.

---

## Como apontar o diretório a ser indexado

Defina a variável `DATA_LOCATION` no arquivo `.env` (ou nas variáveis de ambiente do Portainer) com o caminho **absoluto** do diretório no host que deseja indexar:

```env
DATA_LOCATION=/mnt/nas/dados
```

Esse caminho será montado como `/data` (somente leitura) dentro do container `diskover`. Ao iniciar o indexador pela interface web, aponte para `/data` como raiz da varredura.

> **Dica:** o volume é montado como `:ro` (read-only) para garantir que o Diskover não modifique seus arquivos.

---

## Configuração do Elasticsearch (memória)

O Elasticsearch pode consumir bastante RAM. Ajuste o heap conforme sua máquina:

```env
# .env
ES_HEAP_SIZE=1g   # recomendado: metade da RAM disponível
                  # ex: 512m para 1 GB RAM, 1g para 2 GB RAM, 4g para 8 GB RAM
                  # máximo recomendado: 32g
```

Em hosts com pouca memória (ex.: 2 GB de RAM), use `512m`. Em servidores dedicados, pode-se usar `4g` ou mais.

---

## Credenciais e observações

- A segurança do Elasticsearch está **desabilitada** (`xpack.security.enabled=false`) para facilitar o setup local. A porta 9200 está vinculada a `127.0.0.1` por padrão — **não altere para `0.0.0.0` nem exponha essa porta na internet sem autenticação.**
- A variável `ES_PASS=changeme` existe no compose mas não tem efeito enquanto `xpack.security` está desativado. Se você habilitar segurança, atualize essa variável.
- A interface web do Diskover não tem autenticação por padrão na imagem LinuxServer — use um proxy reverso (ex.: Nginx Proxy Manager) para protegê-la se necessário.

---

## Como verificar a saúde dos serviços

```bash
# Status geral dos containers
docker compose ps

# Saúde do Elasticsearch
curl -s http://localhost:9200/_cluster/health | python3 -m json.tool

# Logs do Diskover
docker compose logs -f diskover

# Logs do Elasticsearch
docker compose logs -f elasticsearch
```

O Elasticsearch retorna `"status": "green"` ou `"yellow"` quando saudável. Status `"red"` indica problema.

---

## Estrutura de volumes

| Volume        | Conteúdo                                       |
|---------------|------------------------------------------------|
| `esdata`      | Dados persistentes do Elasticsearch            |
| `redis-data`  | Dados persistentes do Redis                    |
| `CONFIG_LOCATION` | Configurações do Diskover (padrão: `./config`) |
| `DATA_LOCATION`   | Diretório do host a ser indexado               |

---

## Recursos

- [Diskover Community — Documentação](https://docs.diskoverdata.com/)
- [LinuxServer Diskover Image](https://docs.linuxserver.io/images/docker-diskover)
- [Elasticsearch 7.x Docs](https://www.elastic.co/guide/en/elasticsearch/reference/7.17/index.html)
