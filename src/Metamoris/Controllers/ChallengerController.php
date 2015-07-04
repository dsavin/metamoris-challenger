<?php

namespace Metamoris\Controllers;

use SimpleUser\User;
use SimpleUser\UserManager;
use Symfony\Component\Form\Form;
use Symfony\Component\Form\FormError;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Silex\Application;
use Symfony\Component\Validator\Constraints\Email;

class ChallengerController
{
    /**
     * @var Form
     */
    protected $registerForm;

    public function homeAction(Request $request, Application $app)
    {
        return $this->tabFormsAction($request, $app);
    }

    public function tabFormsAction(Request $request, Application $app)
    {
        $activeTab = 'register';
        $this->registerForm = $app['form.factory']
            ->createNamedBuilder('register_form', 'form')
            ->add(
                'email',
                'email',
                [

                    'required' => true,
                    'constraints' => new  Email(),
                    'attr' => [
                        'placeholder' => 'Email',
                        'type' => 'email',
                        'id' => 'email'
                    ]

                ]
            )
            ->add(
                'password',
                'repeated',
                [
                    'type' => 'password',
                    'invalid_message' => 'The password fields must match.',
                    'required' => true,
                    'first_options' => [
                        'label' => false,
                        'attr' => [
                            'placeholder' => 'Password',
                            'id' => 'password'
                        ]
                    ],
                    'second_options' => [
                        'label' => false,
                        'attr' => [
                            'placeholder' => 'Repeat your password',
                            'id' => 'password-repeat'
                        ]
                    ]
                ]
            )
            ->add(
                'newsletter',
                'checkbox',
                ['required' => false]
            )
            ->getForm();

        if ($request->getMethod() === 'POST') {
            $this->registerForm->handleRequest($request);
            if ($this->registerForm->isSubmitted() === true) {
                $this->register($app);
            }
        }

        //var_dump($app['user.mailer']);die;
        return $app['twig']->render(
            'challenger/tab_forms.html.twig',
            [
                'registerForm' => $this->registerForm->createView(),
                'activeTab' => $activeTab
            ]
        );
    }

    private function register($app)
    {
        $registerData = $this->registerForm->getData();
        try {
            /**  @var User $user */
            $user = $app['user.manager']->createUser(
                $registerData['email'],
                $registerData['password'],
                null,
                ['ROLE_CHALLENGER']
            );

            if ($error =
                $app['user.manager']->validatePasswordStrength(
                    $user,
                    $registerData['password']
                )
            ) {

                $error = new FormError($error);
                $this->registerForm->get('password')->addError($error);
                throw new \InvalidArgumentException($error);
            }

            $user->setEnabled(false);
            $user->setConfirmationToken($app['user.tokenGenerator']->generateToken());
            $user->setCustomField(
                'newsletter',
                $registerData['newsletter']
            );
            $app['user.manager']->insert($user);
            $app['user.mailer']->sendConfirmationMessage($user);

        } catch (\InvalidArgumentException $e) {
            //$error = $e->getMessage();
        }
    }

    public function checkEmailAction(Request $request, Application $app)
    {

        if ($request->isXmlHttpRequest() === true) {
            $count = $app['user.manager']->findCount(
                [
                    'email' => $request->request->get('register_form')['email']
                ]
            );
            if ($count === 0) {
                return new JsonResponse(true);
            }
        }

        return new JsonResponse(false);
    }

}
