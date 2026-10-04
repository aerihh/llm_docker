"""
llm_docker - a tiny FastAPI service for practicing Docker.

Project description
===================
This project is a hands-on sandbox for learning Docker fundamentals.
It packages a minimal FastAPI application (a single /health endpoint)
into a container image, so the whole Docker workflow can be practiced
end to end:

    1. Write a Dockerfile that installs the app and its dependencies.
    2. Build an image:            docker build -t llm_docker .
    3. Run a container:           docker run -p 8000:8000 llm_docker
    4. Verify it works:           curl http://localhost:8000/health

The application itself is intentionally tiny -- one health check route --
because the goal is to focus on Docker (images, layers, port mapping,
container lifecycle) rather than on application logic.
"""

from fastapi import FastAPI

app = FastAPI(
    title="llm_docker",
    description="A tiny FastAPI app used to practice building Docker images.",
    version="0.1.0",
)


@app.get("/health")
def health() -> dict:
    """Liveness probe: reports that the service is up and running."""
    return {"status": "ok"}
