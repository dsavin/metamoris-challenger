<?php

// configure your app for the production environment

$conf['twig']['twig.path'] = [
    ROOT_DIR . '/src/Metamoris/views'
];
$conf['twig']['twig.options'] = [
    'cache' => ROOT_DIR . '/var/cache/twig_prod'
];

$conf['assetic'] = [
    'assetic.path_to_web' => ROOT_DIR . '/web/assets',
    'assetic.options' => [
        'debug'              => false,
        'auto_dump_assets' => false
    ],

    'assetic.path_to_cache' => ROOT_DIR  . '/var/cache/assetic',
    'assetic.path_to_source' => ROOT_DIR . '/resources'
];
$conf['monolog']['monolog.logfile'] = ROOT_DIR . '/var/logs/prod.log';

$conf['assets_url'] = '/challenger/web/assets/';

if (APPLICATION_ENV === 'dev') {
    require_once ROOT_DIR . '/app/config/dev.php';
}
