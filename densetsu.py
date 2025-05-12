#!/usr/bin/env python
import requests
import sys
import re
import json

API_URL = "https://tools.ic731.net/api/kenshi/takada.php"

def get_kenshi_legend(name=None):
    """Fetches a random Kenshi Takada legend from the API and optionally replaces Kenshi Takada with the given name."""
    try:
        # User-Agentヘッダーを設定
        headers = {
            "User-Agent": "TakadaKenshi-Densetsu-CLI",
            "Accept": "application/json"
        }
        
        # APIリクエスト
        response = requests.get(API_URL, headers=headers)
        response.raise_for_status()  # Raise an HTTPError for bad responses (4xx or 5xx)
        
        # レスポンスをJSONとして解析
        data = response.json()
        
        # APIのレスポンス構造を確認
        if "text" in data:
            legend = data["text"]
        elif isinstance(data, str):
            legend = data
        else:
            # レスポンスの構造が予想と異なる場合、JSONを文字列として表示
            legend = json.dumps(data, ensure_ascii=False)
        
        # 「高田健志」を指定された名前に置き換え
        if name and legend:
            pattern = re.compile(r'高田健志', re.IGNORECASE)
            legend = pattern.sub(name, legend)
        
        return legend

    except requests.exceptions.RequestException as e:
        print(f"APIリクエストエラー: {e}", file=sys.stderr)
        return None
    except json.JSONDecodeError as e:
        print(f"JSONパースエラー: {e}", file=sys.stderr)
        print(f"受信したレスポンス: {response.text[:200]}", file=sys.stderr)
        return None
    except Exception as e:
        print(f"予期せぬエラーが発生しました: {e}", file=sys.stderr)
        return None

if __name__ == "__main__":
    # コマンドライン引数から名前を取得
    name = sys.argv[1] if len(sys.argv) > 1 else None
    
    # 伝説を取得して表示
    legend = get_kenshi_legend(name)
    if legend:
        print(legend)
    else:
        print("高田健志の伝説を取得できませんでした。", file=sys.stderr)
        sys.exit(1)  # 失敗を示す終了コード