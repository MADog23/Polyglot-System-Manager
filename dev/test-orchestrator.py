import requests

print("Testing orchestrator (placeholder)...")

# Replace with real endpoint once implemented
try:
    r = requests.get("http://localhost:5000/health")
    print("Response:", r.text)
except Exception as e:
    print("Error:", e)
