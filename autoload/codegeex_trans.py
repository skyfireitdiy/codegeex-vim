#!/usr/bin/env python3

import json
import requests
import argparse
import os

url = "https://tianqi.aminer.cn/api/v2/multilingual_code_translate"


def request_codegeex_trans(prompt, src_lang, dst_lang, apikey, apisecret):
    payload = {
        "prompt": prompt,
        "src_lang": src_lang,
        "dst_lang": dst_lang,
        "apikey": apikey,
        "apisecret": apisecret,
    }
    headers = {"Content-Type": "application/json"}
    try:
        response = requests.post(url,
                                 data=json.dumps(payload),
                                 headers=headers)
        data = json.loads(response.content.decode("utf-8"))
        print("".join(data["result"]["output"]["code"]), end="")
    except Exception:
        pass


def load_key(keyfile):
    with open(keyfile, "r") as f:
        return json.load(f)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--keyfile",
                        default=os.path.join(os.environ["HOME"],
                                             ".tianqi.key"))
    parser.add_argument("src_lang")
    parser.add_argument("dst_lang")
    parser.add_argument("prompt")
    result = parser.parse_args()
    if not os.path.exists(result.keyfile):
        return
    key = load_key(result.keyfile)
    request_codegeex_trans(result.prompt,
                           result.src_lang,
                           result.dst_lang,
                           key["apikey"],
                           key["apisecret"])


if __name__ == "__main__":
    main()
