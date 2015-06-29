<?php

namespace Metamoris\Controllers;

use Symfony\Component\HttpFoundation\Response;
use Silex\Application;

class ChallengerController
{
    public function homeAction(Application $app)
    {
        return $app['twig']->render('challenger/tab_forms.html.twig');
    }

    public function tabFormsAction(Application $app, $name)
    {
        return $app['twig']->render('challenger/tab_forms.html.twig');
    }
}