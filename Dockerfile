#gets the base image for python
FROM python:3.14-slim

#assings the current directory for the source files
WORKDIR /

#copies the requirements dependencies for the image
COPY requirements.txt .

#Runs the install command
RUN pip install --no-cache-dir -r requirements.txt

COPY main.py .

EXPOSE 8000

ENTRYPOINT ["uvicorn"]

CMD ["main:app", "--host", "0.0.0.0", "--port", "8000"]

