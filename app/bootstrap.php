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
$app->register(new Provider\RoutingServiceProvider());
$app->register(new Provider\ValidatorServiceProvider());
$app->register(new Provider\ServiceControllerServiceProvider());
$app->register(new Provider\HttpFragmentServiceProvider());
$app->register(new Provider\TwigServiceProvider(), $conf['twig']);

if (APPLICATION_ENV === 'dev') {
    Debug::enable();
    $app['debug'] = true;

    $app->register(new Provider\WebProfilerServiceProvider(), array(
        'profiler.cache_dir' => ROOT_DIR . '/var/cache/profiler',
    ));
    $conf['monolog']['monolog.level']  = Monolog\Logger::DEBUG;

    $app->register(new Provider\MonologServiceProvider(), $conf['monolog']);

}



$app['routes'] = $app->extend('routes', function (RouteCollection $routes, Application $app) {
    $loader     = new YamlFileLoader(new FileLocator(ROOT_DIR . '/app/config'));
    $collection = $loader->load('routes.yml');
    $routes->addCollection($collection);

    return $routes;
});


$app['twig'] = $app->extend('twig', function ($twig, $app) {
    // add custom globals, filters, tags, ...

    $twig->addFunction(new \Twig_SimpleFunction('asset', function ($asset) use ($app) {
        return $app['request_stack']->getMasterRequest()->getBasepath().'/'.ltrim($asset, '/');
    }));

    return $twig;
});

return $app;