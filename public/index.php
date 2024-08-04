<?php 
require '../helpers.php';
require basePath('Router.php');

$router = new Router();

// Include routes.php to set up routes for the router instance
require basePath('routes.php');

$uri = $_SERVER['REQUEST_URI'];
$method = $_SERVER['REQUEST_METHOD'];

$router->route($uri, $method);

