<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\UserAuthController;
use App\Http\Controllers\WorkerAuthController;
use Illuminate\Support\Facades\Route;

Route::prefix("admin")->as("admin.")->group(function() {
  Route::get("/login", [UserAuthController::class, "index"])->name("index");
  Route::post("/login", [UserAuthController::class, "login"])->name("login");
  Route::post("/logout", [UserAuthController::class, "logout"])->name("logout");

  Route::middleware("auth")->group(function() {
    Route::get("/dashboard", [AdminController::class, "index"])->name("dashboard");
  });
});

Route::prefix("worker")->as("worker.")->group(function() {
  Route::get("/login", [WorkerAuthController::class, "index"])->name("index");
  Route::post("/login", [WorkerAuthController::class, "login"])->name("login");
  Route::post("/logout", [WorkerAuthController::class, "logout"])->name("logout");

  Route::middleware("auth:worker")->group(function() {
    Route::get("/dashboard", [AdminController::class, "index"])->name("dashboard");
  });
});

