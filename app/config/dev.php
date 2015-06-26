<?php


// enable the debug mode
$conf['twig']['twig.options']['debug'] = true;
$conf['twig']['twig.options'] = [
    'cache' => ROOT_DIR . '/var/cache/twig_dev'
];
$conf['monolog']['monolog.logfile'] = ROOT_DIR . '/var/logs/dev.log';