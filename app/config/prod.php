<?php

// configure your app for the production environment

$conf['twig']['twig.path'] = [
    ROOT_DIR . '/src/Metamoris/views'
];
$conf['twig']['twig.options'] = [
    'cache' => ROOT_DIR . '/var/cache/twig_prod'
];

$conf['monolog']['monolog.logfile'] = ROOT_DIR . '/var/logs/prod.log';

if (APPLICATION_ENV === 'dev') {
    require_once ROOT_DIR . '/app/config/dev.php';
}
