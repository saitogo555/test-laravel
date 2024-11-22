<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
  Worker
  <p style="color: red;">{{ $errors->first() }}</p>
  <form action="{{ route("worker.login") }}" method="post">
    @csrf
    <div>
      <label for="email">
        email:
        <input type="email" name="email" id="email">
      </label>
    </div>
    <div>
      <label for="password">
        password:
        <input type="password" name="password" id="password">
      </label>
    </div>
    <div>
      <button type="submit">ログイン</button> 
    </div>
  </form>
</body>
</html>