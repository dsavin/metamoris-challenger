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
        return $app['twig']->render(
            'challenger/landing_page.html.twig'
        );
    }

    public function tabFormsAction(
        Request $request,
        Application $app,
        $activeTab
    )
    {
        $authException = $app['user.last_auth_exception']($request);
        $activeTab = ($activeTab) ?: 'register';
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
                $activeTab = 'login';
            }
        }

        //var_dump($app['user.mailer']);die;
        return $app['twig']->render(
            'challenger/tab_forms.html.twig',
            [
                'error' => $authException ? $authException->getMessageKey() : null,
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

    public function registrationAction(Request $request, Application $app)
    {
        if (!$app['user']) {
            return $app->redirect($app['url_generator']->generate('challenger.tabs.login'));
        }

        $personalData = $request->request->all();
        if (array_key_exists('step', $personalData) === true) {
            // form submitted
            $personalData['phone'] = implode('', $personalData['phone']);
            $app['user']->setCustomFields($personalData);
            $app['user.manager']->update($app['user']);

            return $app->redirect($app['url_generator']->generate('challenger.registration.payment'));

        }
        return $app['twig']->render(
            'challenger/registration.html.twig',
            [
            ]
        );
    }

    public function paymentAction(Request $request, Application $app)
    {
        $citiesSql = "
        SELECT c.*
        FROM challenger_cities c
        LEFT JOIN  challenger_user_class_city map
        ON c.id = map.city_id
        WHERE map.id IS NULL";
        $cities = $app['db']->fetchAll($citiesSql);

        if (!$app['user']) {
            return $app->redirect($app['url_generator']->generate('challenger.tabs.login'));
        }

        $paymentData = $request->request->all();
        if (array_key_exists('step', $paymentData) === true) {

            $customFields = $app['user']->getCustomFields();

            $customFields = array_merge($customFields, $paymentData);
            // form submitted
            $app['user']->setCustomFields($customFields);
            $app['user.manager']->update($app['user']);

            $data = $app['user']->getCustomFields();

            $citiesSql = "
        SELECT *
        FROM challenger_cities
        ";

            $cities = $app['db']->fetchAll($citiesSql);
            foreach ($cities as $city) {
                if ((int)$city['id'] === (int)$data['location']) {
                    $location = $city;
                    break;
                }
            }

            $classSql = "SELECT * FROM challenger_weight_classes WHERE id = ?";

            $class = $app['db']->fetchAssoc($classSql,
                [(int)$data['weight_class']]);


            return $app['twig']->render(
                'challenger/confirmation.html.twig',
                [
                    'data' => $data,
                    'location' => $location,
                    'class' => $class,
                    'user' => $app['user']

                ]
            );


        }

        return $app['twig']->render(
            'challenger/payment.html.twig',
            [
                'cities' => $cities
            ]
        );
    }

    public function confirmationAction(Request $request, Application $app)
    {
        $error = null;

        $citiesSql = "
        SELECT *
        FROM challenger_cities
        ";

        $cities = $app['db']->fetchAll($citiesSql);

        $data = $app['user']->getCustomFields();

        foreach ($cities as $city) {
            if ((int)$city['id'] === (int)$data['location']) {
                $location = $city;
                break;
            }
        }

        $classSql = "SELECT * FROM challenger_weight_classes WHERE id = ?";

        $class = $app['db']->fetchAssoc(
            $classSql,
            [(int)$data['weight_class']]
        );


        if (array_key_exists('confirmation_id', $data) === false) {
            if ($data['method'] === 'cc') {
                $order = new \AuthorizeNetAIM();
                $order->amount = "125.00";
                $order->card_num = $data['card_number'];
                $order->exp_date = $data['card_month'] . '/' . $data['card_year'];


                $response = $order->authorizeAndCapture();
                if ($response->approved) {
                    $transaction_id = $response->transaction_id;
                    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
                    $charactersLength = strlen($characters);
                    $randomString = '';
                    for ($i = 0; $i < 10; $i++) {
                        $randomString .= $characters[rand(0,
                            $charactersLength - 1)];
                    }
                    $data['authorizenet_transaction_id'] = $transaction_id;
                    $data['confirmation_id'] = $randomString;
                    $app['user']->setCustomFields($data);
                    $app['user.manager']->update($app['user']);

                    $app['db']->insert(
                        'challenger_user_class_city',
                        [
                            'user_id' => $app['user']->getId(),
                            'weight_class_id' => (int)$data['weight_class'],
                            'city_id' => $data['location']
                        ]
                    );

                } else {
                    $error = 'There was an issue during charging of your credit card.
                    Please provide another credit card data.';
                }
            }
        }


        return $app['twig']->render(
            'challenger/confirmation_result.html.twig',
            [
                'error' => ($error) ? $error : null,
                'data' => $data,
                'location' => $location,
                'class' => $class,
                'user' => $app['user']
            ]
        );
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

    public function fetchWeightClassesAction(
        Request $request,
        Application $app
    ) {
        if ($request->isXmlHttpRequest() === true) {
            $city = $request->request->get('city');
            $classesSql = "
            SELECT c.*
            FROM challenger_weight_classes c
            LEFT JOIN  challenger_user_class_city map
            ON c.id = map.weight_class_id AND map.city_id = ?
            WHERE map.id IS NULL";

            $classes = $app['db']->fetchAll($classesSql, [(int)$city]);
        } else {
            $classes = null;
        }

        return new JsonResponse($classes);
    }
}
