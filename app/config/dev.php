<?php
$conf['db']['db.options'] = array(
    'driver' => 'pdo_mysql',
    'host' => 'localhost',
    'dbname' => 'Meta3DB',
    'user' => 'root',
    'password' => 'pass',
);

// enable the debug mode
$conf['twig']['twig.options']['debug'] = true;
$conf['twig']['twig.options'] = [
    'cache' => ROOT_DIR . '/var/cache/twig_dev'
];

$conf['monolog']['monolog.logfile'] = ROOT_DIR . '/var/logs/dev.log';

$conf['assetic'] = [
    'assetic.path_to_web' => ROOT_DIR . '/web/assets',
    'assetic.options' => [
        'debug' => true,
        'auto_dump_assets' => false
    ],
    'assetic.path_to_cache' => ROOT_DIR . '/var/cache/assetic',
    'assetic.path_to_source' => ROOT_DIR . '/resources'
];

$conf['assets_url'] = '/assets/';
/*
define("AUTHORIZENET_API_LOGIN_ID", "8Hg44h4NeUFK");
define("AUTHORIZENET_TRANSACTION_KEY", "88YV7aN32bysA5fW");
define("AUTHORIZENET_SANDBOX", true);

*/
