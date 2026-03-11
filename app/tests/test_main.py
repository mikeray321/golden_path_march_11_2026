import pytest
from app.main import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_hello_world(client):
    """Test the base route returns a 200 and correct JSON."""
    response = client.get('/')
    data = response.get_json()

    assert response.status_code == 200
    assert data['message'] == "Welcome to the Golden Path!"
    assert data['status'] == "Healthy"
