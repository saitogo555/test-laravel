<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
  <h1>Worker ダッシュボード</h1>
  <form action="{{ route("worker.logout") }}" method="post">
    <button type="submit">ログアウト</button>
  </form>
</body>
</html>