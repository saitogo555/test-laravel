<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserAuthController extends Controller
{
    public function index()
    {
        return view("admin.index");
    }

    public function login(Request $request)
    {
        $form_data = $request->only("email", "password");
        if (!Auth::attempt($form_data)) {
            return back()->withErrors([
                "error" => "メールアドレスまたはパスワードが正しくありません"
            ]);
        }
        return redirect(route("admin.dashboard"));
    }

    public function logout()
    {
        
    }
}
