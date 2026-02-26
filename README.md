# neutralino-sample

NeutralinoJSのサンプルアプリケーション。

## 前提条件

- Node.js
- [neu CLI](https://neutralino.js.org/docs/cli/neu-cli)

```bash
npm install -g @neutralinojs/neu
```

## 開発

```bash
neu run
```

ホットリロードが有効なため、`resources/` 以下のファイルを編集すると自動で反映される。

## ビルド

```bash
./build.sh
```

以下のバイナリが `dist/` に出力される：

| ファイル | プラットフォーム |
|---|---|
| `neutralino-sample-mac_arm64.app` | macOS (Apple Silicon) |
| `neutralino-sample-mac_x64.app` | macOS (Intel) |
| `neutralino-sample-win_x64.exe` | Windows (x64) |

各バイナリはリソース埋め込み済みの単体実行ファイル。

## Neutralinoの更新

```bash
neu update
```

更新後、`bin/` にLinux/universal用バイナリが復活するが、`./build.sh` 実行時に自動で削除される。

## プロジェクト構成

```
resources/
  index.html       メインHTML
  styles.css        スタイルシート
  js/main.js        アプリケーションロジック
  js/neutralino.js  Neutralinoクライアントライブラリ
neutralino.config.json  アプリ設定
build.sh                ビルドスクリプト
```
