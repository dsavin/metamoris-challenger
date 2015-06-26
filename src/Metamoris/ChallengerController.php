<?php

namespace Metamoris;

use Symfony\Component\HttpFoundation\Response;
use Silex\Application;

class ChallengerController
{
    public function homeAction()
    {
        return new Response("ChallengeController::homeAction");
    }

    public function helloAction(Application $app, $name)
    {
        return new Response("Hello" . $app->escape($name));
    }
}