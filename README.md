# Local LLM Chat Docker Compose

Run a local LLM chat environment using Docker Compose.

## Services

| Service | Description | Port |
|---------|-------------|------|
| [Ollama](https://ollama.ai/) | LLM Server | 11434 |
| [Open WebUI](https://github.com/open-webui/open-webui) | Chat UI | 3030 |
| [SearXNG](https://github.com/searxng/searxng) | Meta Search Engine | 8080 |

## Requirements

- Docker & Docker Compose
- **GPU version**: NVIDIA GPU + NVIDIA Container Toolkit
- **CPU version**: 8GB+ RAM recommended

## Quick Start

### 1. Start Services

```bash
# GPU version (requires NVIDIA GPU)
docker-compose up -d

# CPU version
docker-compose -f docker-compose-cpu.yml up -d
```

### 2. Install Models

Available models can be found at [Ollama Library](https://ollama.ai/library).

```bash
docker exec ollama-chat ollama pull <model-name>
```

Recommended setup:

| Model | Use Case | RAM |
|-------|----------|-----|
| gemma2:2b | Ultra-light (testing) | 4GB |
| gemma2:9b | Light, strong Japanese support (daily use) | 8GB |
| qwen2.5:14b | High performance, RAG-ready (document analysis) | 16GB+ |
| gpt-oss:20b | High performance, general purpose | 24GB+ |

### 3. Start Using

Open your browser and go to:

http://localhost:3030

### 4. Stop Services

```bash
docker-compose down
```

To delete all stored data and models:

```
docker compose down -v
```

## File Structure

```
.
├── docker-compose.yml        # GPU version (NVIDIA GPU)
├── docker-compose-cpu.yml    # CPU version
└── config/
    └── searxng/
        └── settings.yml      # SearXNG configuration
```

Data is stored in Docker volumes:

- ollama-data
    - Ollama models and cache
- open-webui-data
    - Open WebUI files

## Additional Notes

### Web Search

To enable web search, either obtain API keys from cloud services or use the local SearXNG container endpoint:

```
http://searxng:8080
```

### Embedding Model (for RAG)

If you want to use RAG (Retrieval-Augmented Generation), install an embedding model:

```bash
docker exec ollama-chat ollama pull mxbai-embed-large
```
