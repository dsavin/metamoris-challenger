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
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

$app = new Application();


# Providers
$app->register(new Provider\SecurityServiceProvider());
$app->register(new Provider\RoutingServiceProvider());
$app->register(new Provider\ValidatorServiceProvider());
$app->register(new Provider\ServiceControllerServiceProvider());
$app->register(new Provider\HttpFragmentServiceProvider());
$app->register(new Provider\TwigServiceProvider(), $conf['twig']);
$app->register(new Provider\DoctrineServiceProvider(), $conf['db']);
$app->register(new Provider\FormServiceProvider());
$app->register(new Provider\LocaleServiceProvider());
$app->register(new Silex\Provider\TranslationServiceProvider(), [
    'locale_fallbacks' => array('en')
]);

$app->register(new Provider\RememberMeServiceProvider());
$app->register(new Provider\SessionServiceProvider());
$app->register(new Provider\SwiftmailerServiceProvider(), $conf['swiftmailer']);


$simpleUserProvider = new SimpleUser\UserServiceProvider();
$app->register($simpleUserProvider, $conf['user']);


$app['security.firewalls'] = array(
    /* // Ensure that the login page is accessible to all, if you set anonymous => false below.
    'login' => array(
        'pattern' => '^/user/login$',
    ), */
    'secured_area' => array(
        'anonymous' => false,
        'pattern' => '^/challenger/registration',
        'remember_me' => array(),
        'form' => array(
            'login_path' => '/challenger/login',
            'check_path' => '/challenger/registration/login_check',
            'default_target_path' => '/challenger/registration',
            'always_use_default_target_path' => true
        ),
        'logout' => array(
            'logout_path' => '/challenger/logout',
        ),
        'users' => function ($app) {
            return $app['user.manager'];
        },
    ),
);

if (APPLICATION_ENV === 'dev') {
    Debug::enable();
    $app['debug'] = true;

    $app->register(new Provider\WebProfilerServiceProvider(), array(
        'profiler.cache_dir' => ROOT_DIR . '/var/cache/profiler',
    ));
    $conf['monolog']['monolog.level']  = Monolog\Logger::DEBUG;

    $app->register(new Provider\MonologServiceProvider(), $conf['monolog']);

} else {
    $conf['monolog']['monolog.level']  = Monolog\Logger::DEBUG;

    $app->register(new Provider\MonologServiceProvider(), $conf['monolog']);
}
$app->mount('/challenger', $simpleUserProvider->connect($app));


$app['conf'] = $conf;

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
$app->error(function (\Exception $e, Request $request, $code) use ($app) {
    if ($app['debug']) {
        return;
    }

    // 404.html, or 40x.html, or 4xx.html, or error.html
    $templates = array(
        'errors/' . $code . '.html.twig',
        'errors/' . substr($code, 0, 2) . 'x.html.twig',
        'errors/' . substr($code, 0, 1) . 'xx.html.twig',
        'errors/default.html.twig',
    );

    return new Response($app['twig']->resolveTemplate($templates)->render(array('code' => $code)),
        $code);
});

return $app;
