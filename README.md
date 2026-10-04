# llm_docker

A tiny FastAPI service used as a hands-on sandbox for practicing Docker.
The app is intentionally minimal — a single `/health` endpoint — so the focus
stays on the Docker workflow: writing a Dockerfile, building an image, running
a container, and mapping ports.

## Project layout

| File               | Purpose                                              |
| ------------------ | ---------------------------------------------------- |
| `main.py`          | FastAPI app with the `/health` route                 |
| `requirements.txt` | Pinned Python dependencies                           |
| `Dockerfile`       | Image recipe (heavily commented for learning)        |
| `.dockerignore`    | Files kept out of the Docker build context           |
| `denv/`            | Local virtualenv for running the app without Docker  |

## Run locally (without Docker)

```bash
source denv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload
```

## Run with Docker

```bash
docker build -t llm_docker .
docker run --rm -p 8000:8000 llm_docker
```

## Test the health endpoint

```bash
curl http://localhost:8000/health
# {"status":"ok"}
```

Interactive API docs: http://localhost:8000/docs
