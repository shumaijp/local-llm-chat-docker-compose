.PHONY: up down init init-embedding-model clean list logs

up:
	docker-compose up -d

down:
	docker-compose down

init:
	docker-compose up -d ollama
	@echo "Waiting for Ollama to start..."
	@sleep 5
	docker exec ollama ollama pull gemma2:9b
	docker exec ollama ollama pull qwen2.5:14b
	# 軽量・日本語強い（普段使い）
	# 軽量モデル（8GB RAM、高速）
	docker exec ollama ollama pull gemma2:9b
	# 高性能・RAG向き（資料分析）
	# 高性能モデル（16GB+ RAM推奨）
	docker exec ollama ollama pull qwen2.5:14b
	# 超軽量（テスト用）
	docker exec ollama ollama pull gemma2:2b
	@echo "All models ready!"

init-embedding-model:
	docker exec ollama ollama pull mxbai-embed-large

# インストール済みモデル一覧
list:
	docker exec ollama ollama list

# モデル削除
clean:
	docker exec ollama ollama rm gemma2:9b
	docker exec ollama ollama rm qwen2.5:14b
	docker exec ollama ollama rm gemma2:2b

logs:
	docker-compose logs -f
