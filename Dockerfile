# ==========================================
# ETAPA 1: Builder (Genera TODOS los wheels)
# ==========================================
FROM python:3.14-slim AS builder

WORKDIR /app

COPY requirements.txt .

# 1. Actualizamos pip para asegurar la compatibilidad.
# 2. Quitamos "--no-deps" para que descargue FastAPI + Starlette + todo lo necesario.
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip wheel --no-cache-dir --wheel-dir /app/wheels -r requirements.txt

# ==========================================
# ETAPA 2: Imagen Final (Limpia, exacta y segura)
# ==========================================
FROM python:3.14-slim

WORKDIR /app

# Copiamos la colección completa de wheels (.whl)
COPY --from=builder /app/wheels /wheels

# Instalamos de forma local y atómica. Al no usar `--no-index`, si por alguna extraña
# razón faltase algo, pip puede salir a internet a buscarlo, asegurando que el build no falle.
RUN pip install --no-cache-dir --find-links=/wheels /wheels/* && \
    rm -rf /wheels && \
    # pip y setuptools solo sirven para construir: sus copias vendidas internas
    # (msgpack/urllib3/setuptools en pip, jaraco.context/wheel en setuptools)
    # disparan falsos positivos HIGH en Trivy. La app solo corre uvicorn.
    rm -rf /usr/local/lib/python3.14/site-packages/pip* \
           /usr/local/lib/python3.14/site-packages/setuptools* \
           /usr/local/lib/python3.14/site-packages/_distutils_hack

# Copiar el código de tu aplicación
COPY main.py .

EXPOSE 8000

ENTRYPOINT ["uvicorn"]
CMD ["main:app", "--host", "0.0.0.0", "--port", "8000"]
