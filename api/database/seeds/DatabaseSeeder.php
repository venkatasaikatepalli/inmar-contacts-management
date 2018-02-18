<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // $this->call(UsersTableSeeder::class);
        for ($i=0; $i <= 100 ; $i++) { 
        	# code...
        	DB::table('users')->insert([
        	    'firstname' => str_random(10),
        	    'lastname' => str_random(10),
        	    'email' => str_random(10).'@inmar.com',
        	    'aadharno' => str_random(12),
        	    'password' => bcrypt('secret'),
        	]);
        }
    }
}
