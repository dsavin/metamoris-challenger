<?php
if (!defined('ROOT_DIR')) {
    define('ROOT_DIR', dirname(dirname(__FILE__)));
}
require_once ROOT_DIR . '/vendor/autoload.php';
require_once ROOT_DIR . '/app/config/prod.php';

use Silex\Application;
use Silex\Provider;
use Symfony\Component\Config\FileLocator;
use Symfony\Component\Routing\Loader\YamlFileLoader;
use Symfony\Component\Routing\RouteCollection;
use Symfony\Component\Debug\Debug;

$app = new Application();


# Providers

$app->register(new Provider\TwigServiceProvider(), $conf['twig']);


if (APPLICATION_ENV === 'dev') {
    Debug::enable();
    $app['debug'] = true;

    $app->register(new Provider\WebProfilerServiceProvider(), array(
        'profiler.cache_dir' => ROOT_DIR . '/var/cache/profiler',
    ));
    $conf['monolog']['monolog.level'] = Monolog\Logger::DEBUG;

    $app->register(new Provider\MonologServiceProvider(), $conf['monolog']);

}


$app['conf'] = $conf;


$app['twig'] = $app->extend('twig', function ($twig, $app) {
    // add custom globals, filters, tags, ...

    $twig->addFunction(new \Twig_SimpleFunction('asset',
        function ($asset) use ($app) {
            return $app['request_stack']->getMasterRequest()->getBasepath() . '/' . ltrim($asset,
                '/');
        }));

    return $twig;
});


// Register assetic and set up CSSMin
$app->register(new SilexAssetic\AsseticServiceProvider(), $conf['assetic']);

$app->extend('assetic.filter_manager', function ($fm, $app) {
    $fm->set('cssmin', new Assetic\Filter\MinifyCssCompressorFilter());
    $fm->set('jsmin', new \Assetic\Filter\JSMinFilter());

    return $fm;
});

// Do we want to dump all our assets? Only if in debug mode!
if ($app['assetic.options']['auto_dump_assets']) {
    $dumper = $app['assetic.dumper'];
    if (isset($app['twig'])) {
        $dumper->addTwigAssets();
    }
    $dumper->dumpAssets();
}
//$app['user.manager'] = new \SimpleUser\UserManager($app['db'], $app);
//$app['user.mailer'] = new \SimpleUser\Mailer($app['mailer'])

return $app;
