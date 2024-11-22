<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class WorkerAuthController extends Controller
{
    public function index()
    {
        return view("worker.index");
    }

    public function login(Request $request)
    {
        $form_data = $request->only("email", "password");
        if (!Auth::guard("worker")->attempt($form_data)) {
            return back()->withErrors([
                "error" => "メールアドレスまたはパスワードが正しくありません"
            ]);
        }
        return redirect(route("worker.dashboard"));
    }

    public function logout()
    {
        
    }
}
