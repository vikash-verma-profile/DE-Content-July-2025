import asyncio
import aiohttp
import logging
import json
from datetime import datetime

# Logging Setup
logger = logging.getLogger("api_logger")
logger.setLevel(logging.INFO)
handler = logging.FileHandler("api_log.jsonl")
formatter = logging.Formatter('%(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)

BASE_URL = "https://jsonplaceholder.typicode.com"
ENDPOINTS = ["/posts", "/comments", "/users"]

async def fetch(session, endpoint):
    url = BASE_URL + endpoint
    log_entry = {
        "timestamp": datetime.utcnow().isoformat(),
        "endpoint": endpoint
    }

    try:
        async with session.get(url) as response:
            log_entry["status_code"] = response.status
            if response.status == 200:
                data = await response.json()
                log_entry["records_fetched"] = len(data)
            else:
                log_entry["records_fetched"] = 0
                log_entry["error"] = "Non-200 response"
    except Exception as e:
        log_entry["status_code"] = 0
        log_entry["records_fetched"] = 0
        log_entry["error"] = str(e)

    logger.info(json.dumps(log_entry))

async def main():
    async with aiohttp.ClientSession() as session:
        await asyncio.gather(*[fetch(session, ep) for ep in ENDPOINTS])

if __name__ == "__main__":
    asyncio.run(main())
