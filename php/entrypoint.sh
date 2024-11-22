#!/bin/bash

set -e

# 色変数
RED="\033[31m"
GREEN="\033[0;32m"
BLUE="\033[34m"
YELLOW="\033[0;33m"

# プロジェクトルートのフォルダパス
directory=/var/www/laravel-app

# Laravelプロジェクトを作成
echo -e "${BLUE}Laravelプロジェクトの作成を開始します。"
if [ -z "$(ls -A $directory)" ]; then
  sudo composer create-project laravel/laravel "$directory"
  echo -e "${GREEN}Laravelプロジェクトの作成が完了しました。"
else
  echo -e "${YELLOW}プロジェクトが既に存在しているためLaravelプロジェクトの作成をスキップしました。"
fi

# PHPパッケージのインストール
echo -e "${BLUE}PHPパッケージのインストールを開始します。"
if [ -f "$directory/composer.json" ]; then
  sudo composer install
  echo -e "${GREEN}PHPパッケージのインストールが完了しました。"
else
  echo -e "${RED}composer.jsonが存在しないためPHPパッケージのインストールに失敗しました。"
fi

# .envファイルの作成
echo -e "${BLUE}.envの作成を開始します。"
if [ -f "$directory/.env" ]; then
  echo -e "${YELLOW}既に.envが作成済みのため.envの作成をスキップしました。"
elif [ -f "$directory/.env.local" ]; then
  sudo cp .env.local .env;
  echo -e "${GREEN}.env.localから.envの作成が完了しました。"
elif [ -f "$directory/.env.example" ]; then
  sudo cp .env.example .env;
  echo -e "${GREEN}.env.exampleから.envの作成が完了しました。"
else
  echo -e "${RED}.envの作成に失敗しました。"
fi

# API_KEYの生成
echo -e "${BLUE}API_KEYの生成を開始します。"
if [ ! -f .env ] || ! grep -q '^APP_KEY=' .env || [ "$(grep '^APP_KEY=' $directory/.env | cut -d '=' -f2)" = "" ]; then
  sudo php artisan key:generate
  echo -e "${GREEN}API_KEYの生成が完了しました。"
else
  echo -e "${YELLOW}既にAPI_KEYが生成済みのためAPI_KEYの生成をスキップしました。"
fi

# データベースのマイグレート
echo -e "${BLUE}データベースのマイグレートを開始します。"
php artisan migrate
echo -e "${GREEN}データベースのマイグレートが完了しました。"

# プロジェクトフォルダ内の全てのファイルの所有者とグループをwww-dataに変更
sudo chown -R www-data:www-data /var/www/laravel-app

# .envファイルが存在する場合、.envファイルのメールの設定を変更
echo -e "${BLUE}.envのメール設定の変更を開始します。"
if [ -f "$directory/.env" ]; then
  # .envファイルのMAIL_MAILERの設定を変更
  sed -i 's/^MAIL_MAILER=.*$/MAIL_MAILER=smtp/' $directory/.env 
  echo -e "${GREEN}.envのMAIL_MAILERの設定を変更しました。"
  
  # .envファイルのMAIL_HOSTの設定を変更
  sed -i 's/^MAIL_HOST=.*$/MAIL_HOST=mailhog/' $directory/.env
  echo -e "${GREEN}.envのMAIL_HOSTの設定を変更しました。"
  
  # .envファイルのMAIL_PORTの設定を変更
  sed -i 's/^MAIL_PORT=.*$/MAIL_PORT=1025/' $directory/.env
  echo -e "${GREEN}.envのMAIL_PORTの設定を変更しました。"
  
  # .envファイルのMAIL_FROM_ADDRESSの設定を変更
  sed -i 's/^MAIL_FROM_ADDRESS=.*$/MAIL_FROM_ADDRESS="admin@example.com"/' $directory/.env
  echo -e "${GREEN}.envのMAIL_ADDRESSの設定を変更しました。"
else
  echo -e "${BLUE}.envが存在しないため.envのメール設定の変更に失敗しました。"
fi

# プロジェクトフォルダ内の全てのファイルの権限を755にする
sudo chmod -R 755 $directory

# Apacheを実行
exec apache2-foreground
