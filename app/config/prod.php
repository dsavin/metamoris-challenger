<?php
$conf['db']['db.options'] = array(
    'driver' => 'pdo_mysql',
    'host' => 'e98c6e56d5a5fa289ece47d5f735ef95a2c8cc04.rackspaceclouddb.com',
    'dbname' => 'Meta3DB',
    'user' => 'admin2',
    'password' => 'Gjjkingsong3',
);

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

$conf['user']['user.options'] = [
    'emailConfirmation' =>
        [
            'required' => true,
            'template' => 'email/confirm-email.twig'
        ],
    'mailer' => [
        'fromEmail' => [
            'address' => 'info@metamoris.com',
            'name' => 'Metamoris',
        ],
    ],
];

$conf['swiftmailer'] = [
    'swiftmailer.transport' => new \Swift_MailTransport(),
    'swiftmailer.use_spool' => false,
    'swiftmailer.logging' => true,
];

if (APPLICATION_ENV === 'dev') {
    require_once ROOT_DIR . '/app/config/dev.php';
}
