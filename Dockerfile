# Use uma imagem oficial do Python como imagem base.
# A versão Alpine é leve, o que é ótimo para produção.
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Desta forma, as dependências só são reinstaladas se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner
EXPOSE 8000

# Comando para iniciar a aplicação usando o servidor Uvicorn.
# O host 0.0.0.0 torna a aplicação acessível externamente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"] 