<?php

namespace Metamoris\Controllers;

use Symfony\Component\HttpFoundation\Response;
use Silex\Application;

class ChallengerController
{
    public function homeAction(Application $app)
    {
        return $app['twig']->render('index.html.twig');
    }

    public function helloAction(Application $app, $name)
    {
        return new Response("Hello" . $app->escape($name));
    }
}