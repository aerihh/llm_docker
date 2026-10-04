#gets the base image for python, name it "builder" so stage 2 can copy from it
FROM python:3.14-slim AS builder

#assings the current directory for the source files
WORKDIR /app

#copies the requirements dependencies for the image
COPY requirements.txt .

#Installs the dependencies into a local folder instead of system-wide,
#so stage 2 can copy just that folder over (no pip/cache left behind)
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

#final image: start fresh from the same slim base, without any build leftovers
FROM python:3.14-slim

WORKDIR /app

#brings over only the installed packages from the builder stage
COPY --from=builder /install /usr/local

COPY main.py .

EXPOSE 8000

ENTRYPOINT ["uvicorn"]

CMD ["main:app", "--host", "0.0.0.0", "--port", "8000"]
