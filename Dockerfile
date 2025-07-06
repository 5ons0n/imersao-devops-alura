# Use uma imagem oficial do Python como imagem base.
# Usar a versão 'slim' ajuda a manter a imagem final menor.
FROM python:3.11-slim

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Fazer isso antes de copiar o resto do código aproveita o cache do Docker.
COPY requirements.txt .

# Instala as dependências.
# --no-cache-dir reduz o tamanho da imagem.
# --upgrade pip garante que estamos usando a versão mais recente do pip.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta em que a aplicação será executada.
EXPOSE 8000

# Comando para iniciar a aplicação usando o servidor Uvicorn.
# --host 0.0.0.0 é essencial para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]