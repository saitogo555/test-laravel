# Docker Laravel Dev

このリポジトリはLaravelの開発環境をDockerで構築したものです。

phpMyAdminとMailhogが導入済みのため、それぞれブラウザからデータベースとメールを確認することが出来ます。

## 必須環境

- Docker (Docker Desktop, Docker Engine)
- Hyper-V (Windowsのみ)
- WSL2 (Windowsのみ)

※Hyper-VとWSL2はどちらか一方がセットアップされている必要があります。

## セットアップ手順

1. `git clone https://github.com/saitogo555/docker-laravel-dev.git`を実行してリポジトリをクローンする
2. `cd docker-laravel-dev`を実行してプロジェクトフォルダに移動する。
3. `docker compose up -d`を実行してコンテナを起動する。

## サービス一覧

| サービス名                 | 概要                                |
|---------------------------|-------------------------------------|
| [php](#php)               | ApacheとComposer                    |
| [mariadb](#mariadb)       | リレーショナルデータベース            |
| [phpmyadmin](#phpmyadmin) | ブラウザベースのデータベース管理ツール |
| [mailhog](#mailhog)       | メール送受信テスト用ツール            |

## php

### Laravel

初回起動時にホスト側のsrcフォルダ内が空であれば自動的に最新バージョンのLaravelプロジェクトをセットアップします。

`http://localhost:8080`でLaravelのサイトにアクセス出来ます。

### composer & artisan

composerやartisanコマンドを使用するにはphpコンテナ内で実行する必要があります。

方法は以下の2通りあります。

1. phpコンテナ内に入ってから任意のコマンドを実行する。
    ```sh
    docker compose exec php bash
    php artisan migrate
    ```

2. ホスト側からexecコマンドで任意のコマンドを実行する。
    ```sh
    docker compose exec php php artisan migrate
    ```

### .envファイル

リモートリポジトリからpullしたとき、.envファイルはLaravelプロジェクトに含まれてません。

コンテナ起動時にsrcフォルダ直下に.env.local又は.env.exampleが存在する場合、それらのファイルから自動的に.envを生成します。

.env.localと.env.exampleでは.env.localの方が優先度が高いです。

また、メールの送受信はmailhogを行うため、メールの設定を自動でmailhogの設定に置き換わります。

### データベース

MariaDBを使用する場合は以下の設定を.envファイルに記述してください。

| Key           | Value       |
|---------------|-------------|
| DB_CONNECTION | mysql       |
| DB_HOST       | mariadb     |
| DB_PORT       | 3306        |
| DB_DATABASE   | laravel_app |
| DB_USERNAME   | root        |
| DB_PASSWORD   | root        |

## mariadb

phpMyAdminからデータベースの管理を行うことが出来ます。

直接コマンドでデータベースを操作する場合は下記の手順でMariaDBにログイン出来ます。

1. `docker compose exec mariadb bash`を実行してmariadbコンテナに入る。
2. `mysql -u root -p laravel_app`を実行してパスワード入力画面に遷移する。
3. パスワード`root`を入力し、Enterを押してMariaDBにログインする。

## phpmyadmin

`http://localhost:8081`でデータベースの管理画面にアクセス出来ます。

## mailhog

phpからのメール送信は全てMailhogにリダイレクトされます。

`http://localhost:8025`でメールの確認画面にアクセス出来ます。
