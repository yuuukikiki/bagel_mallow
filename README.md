# アプリケーション名
bagel_mallow

# アプリケーション概要
ベーグルのネット販売のアプリです。

# 利用方法

1 トップページのヘッダーにある「新規登録」ボタンをクリックし、ユーザー登録を行う

[![Image from Gyazo](https://i.gyazo.com/d8b8b1e405c405472177b8a0296d6076.gif)](https://gyazo.com/d8b8b1e405c405472177b8a0296d6076)

2 メニューページで商品を選び、追加する

[![Image from Gyazo](https://i.gyazo.com/4bec8c922afa33b4a7c3036b8c0e85ab.gif)](https://gyazo.com/4bec8c922afa33b4a7c3036b8c0e85ab)

3 カートアイコンの中身を確認し、数量や商品を確認する。

[![Image from Gyazo](https://i.gyazo.com/487d371963e672863c6687a489c1e2f5.gif)](https://gyazo.com/487d371963e672863c6687a489c1e2f5)

4 注文ページで送付先の住所とカード情報を入力する

[![Image from Gyazo](https://i.gyazo.com/63e9bb45e3e65ee7269e2397aa68948a.gif)](https://gyazo.com/63e9bb45e3e65ee7269e2397aa68948a)

5 注文完了ページでログアウトする

[![Image from Gyazo](https://i.gyazo.com/71a7c1479fd2ce1c58a63ea9a12c803f.gif)](https://gyazo.com/71a7c1479fd2ce1c58a63ea9a12c803f)

## 機能一覧

| 機能                         | ログインユーザー | 非ログインユーザー |
|------------------------------|------------------|--------------------|
| 新規登録                 | ❌              | ○                  |
| メニュー閲覧                   | ○                | ○                  |
| 商品注文                    | ○                | ❌               |
| カート閲覧                 | ⭕️              | ❌                  |

## データベース設計




## アプリケーションを作成した背景
友人がベーグル屋さんをオープンするにあたり、ホームページ作成をお願いされました。
ネット販売を主流にしたいとのことで、注文〜決済機能の実装までを必須機能として取り入れました。
ユーザーが使いやすいように、シンプルで分かりやすい、直感的な操作ができるようなアプリを提供したいと考えました。

## 実装予定の機能
・シナリオテストを用意する
  (決済においてどのようなフローが起こりうるか(成功、失敗、離脱、途中で接続が切断されるetc))

・実機でテストを行う
  (複数ブラウザ，スマホなどを利用して、繰り返しテストを行う)

## 開発環境
### 言語・フレームワーク

Ruby 3.2.0

Ruby on Rails 7.0.8.4

### デプロイ環境

AWS

SequelAce:データベース管理

### フロントエンド
HTML

CSS

JavaScript

Google Fonts/Zen Maru Gothic

### 使用エディタ
VS Code


## ローカルでの動作方法
以下のコマンドを順に実行してください。

```bash

 # リポジトリをクローン
% git clone https://github.com/yuuukikiki/bagel_mallow.git

 # プロジェクトディレクトリに移動
% cd bagel_mallow

 # 必要なGemをインストール
% bundle install

 # データベースを作成・マイグレーション
% rails db:create
% rails db:migrate
% rails db:seed

 # JavaScriptパッケージをインストール
% yarn install

 # ローカルサーバーを起動
% rails server

```


## 工夫した点
工夫した点として、ユーザーの使いやすさを重視し、必要最低限の機能に絞って実装しました。
不要なリンクや機能を排除し、シンプルで直感的に操作できるデザインを追求しました。
ページ数や遷移のステップも最小限に抑え、効率的に利用できるよう工夫しています。
友人に実際に利用してもらって、意見を聞きながら改善を行っています。