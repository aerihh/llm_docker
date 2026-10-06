from fastapi.testclient import TestClient

# Assuming your FastAPI instance is defined in a file named main.py
from main import app

# Create the test client instance
client = TestClient(app)

def test_health_endpoint():
    """Test that the /health route returns a 200 OK and the correct status json."""
    # Act: Make a GET request to the endpoint
    response = client.get("/health")
    
    # Assert: Validate the response status code and JSON payload
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}