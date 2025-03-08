import requests 
import json
for i in range(1,10000):
    url = f"http://167.71.220.78/api/postcard/{i}/detail"
    headers = {
        "User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36",
        "Referer":f"http://167.71.220.78/postcard/{i}/detail"
    }
    r  = requests.get(url,headers=headers)
    data = json.loads(r.text)

    name = data["postcard"]["name"]
    wishlist = data["postcard"]["wishlist"]
    if name == "Cường":
        print(f"{i}|{name}|{wishlist}")
        print("="*8)
    else:
        continue
