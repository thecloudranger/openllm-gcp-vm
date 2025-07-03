import requests
import time

API_URL = "http://127.0.0.1:3000/v1/completions"

payload = {
    "prompt": "Explain how LLM inference works.",
    "max_tokens": 100
}

NUM_REQUESTS = 5

def main():
    total_tokens = 0
    start = time.time()
    for i in range(NUM_REQUESTS):
        resp = requests.post(API_URL, json=payload)
        data = resp.json()
        tokens = data['usage']['total_tokens']
        print(f"Run {i+1}: {tokens} tokens")
        total_tokens += tokens
    end = time.time()
    duration = end - start
    print(f"\nTotal time: {duration:.2f}s")
    print(f"Total tokens: {total_tokens}")
    print(f"Tokens/sec: {total_tokens/duration:.2f}")

if __name__ == "__main__":
    main()
