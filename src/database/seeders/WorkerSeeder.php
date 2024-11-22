<?php

namespace Database\Seeders;

use App\Models\Worker;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class WorkerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Worker::query()->create([
            "name" => "aaa",
            "email" => "a@a.a",
            "password" => Hash::make("aaa")
        ]);
    }
}
