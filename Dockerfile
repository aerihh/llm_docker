# ==========================================
# ETAPA 1: Builder (Solo descarga y compila)
# ==========================================
FROM python:3.14-slim AS builder

WORKDIR /app

COPY requirements.txt .

# En lugar de instalar con --prefix, creamos "wheels" (binarios empaquetados)
# Esto descarga e incluye las versiones EXACTAS de tu requirements.txt
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt

# ==========================================
# ETAPA 2: Imagen Final (Limpia y segura)
# ==========================================
FROM python:3.14-slim

WORKDIR /app

# Traemos únicamente los paquetes empaquetados (.whl) de la etapa anterior
COPY --from=builder /app/wheels /wheels

# Forzamos a la imagen final a actualizar sus herramientas base e instalar 
# tus dependencias sobreescribiendo CUALQUIER versión previa del sistema.
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir --no-index --find-links=/wheels /wheels/* && \
    rm -rf /wheels

# Copiar el código de tu aplicación
COPY main.py .

EXPOSE 8000

ENTRYPOINT ["uvicorn"]
CMD ["main:app", "--host", "0.0.0.0", "--port", "8000"]