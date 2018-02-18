<?php 

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Origin, Content-Type, Authorization');
header("Content-Type: application/json; charset=UTF-8");

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

// echo "string";
require 'vendor/autoload.php';
require 'db.php';

// instantiate the App object
$app = new \Slim\App();

$app->get('/welcome', function() {
  echo "Welcome to Inmar API";
});

$app->get('/users', function (Request $request, Response $response) {
	$sql = "SELECT * FROM userslists";
	try {
		$db = getDB();
		$stmt = $db->query($sql);  
		$contests = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;

		$key = 'codejunkers';
		$id = 10;
		$key2="";
		$signature = hash_hmac('SHA256',"$key,$id",$key2);

		$data = array('token' => $signature ,'contests' => $contests );
		echo json_encode($data);
	} catch(PDOException $e) {
	//     //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
});


function generatetoken($id){
	$key = 'codejunkers';
	$id = 10;
	$key2="";
	$token = hash_hmac('SHA256',"$key,$id",$key2);
return $token;
}

// Run application
$app->run();

?>