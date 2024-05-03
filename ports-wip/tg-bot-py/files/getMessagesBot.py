import http.client
import json
import time

TOKEN = 'input your bot token'
HOST = "api.telegram.org"
URL_BASE = "/bot{}/".format(TOKEN)

def get_updates(last_update_id=None):
    conn = http.client.HTTPSConnection(HOST)
    url = URL_BASE + "getUpdates?timeout=100"
    if last_update_id:
        url += "&offset={}".format(last_update_id + 1)
    conn.request("GET", url)
    response = conn.getresponse()
    content = response.read()
    conn.close()
    return json.loads(content.decode('utf-8'))

def main():
    last_update_id = None
    while True:
        updates = get_updates(last_update_id)
        if updates['result']:
            for item in updates['result']:
                print(item)  # Process each update here
                last_update_id = item['update_id']

        time.sleep(1)  # Sleep for a short time to avoid flooding with requests

if __name__ == "__main__":
    main()

