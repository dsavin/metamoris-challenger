<?php
// everything relative to the root directory
chdir(  dirname( dirname(__FILE__))  );
define('APPLICATION_ENV', 'dev');
ini_set('display_errors', 0);

$app = require 'app/bootstrap.php';

$app->run();
