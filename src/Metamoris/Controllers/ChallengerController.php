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
use PayPal\Api\Amount;
use PayPal\Api\Details;
use PayPal\Api\Item;
use PayPal\Api\ItemList;
use PayPal\Api\Payer;
use PayPal\Api\Payment;
use PayPal\Api\RedirectUrls;
use PayPal\Api\Transaction;


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
        $activeTab,
        $token = null
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
                'activeTab' => $activeTab,
                'token' => $token
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
            $app['session']->getFlashBag()->set(
                'alert',
                "We've sent you an email, please verify your email then continue"
            );
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

        if (!$app['user']) {
            return $app->redirect($app['url_generator']->generate('challenger.tabs.login'));
        }

        $customFields = $app['user']->getCustomFields();

        if (array_key_exists('gender', $customFields)
            && $customFields['gender'] === 'Female') {
            $citiesSql = "
        SELECT * from challenger_cities
        WHERE id NOT IN ( SELECT c.id
        FROM challenger_user_class_city map
        LEFT JOIN challenger_cities c
        ON map.city_id = c.id
        WHERE weight_class_id = 7
        GROUP BY city_id
        HAVING COUNT(*) > 15 ORDER BY c.name)";

        } elseif (array_key_exists('gender', $customFields)
            && $customFields['gender'] === 'Male') {
            $citiesSql = "
        SELECT * from challenger_cities
        WHERE id NOT IN (
          SELECT c.id
          FROM challenger_user_class_city map
          LEFT JOIN challenger_cities c
          ON map.city_id = c.id
          WHERE weight_class_id IN (1,3,4,5,6)
          GROUP BY city_id
          HAVING COUNT(*) > 79
          ORDER BY c.name)";
        } else {
            $citiesSql = "
        SELECT * from challenger_cities
        WHERE id NOT IN (
          SELECT c.id
          FROM challenger_user_class_city map
          LEFT JOIN challenger_cities c
          ON map.city_id = c.id
          GROUP BY city_id
          HAVING COUNT(*) > 95
          ORDER BY c.name)";
        }


        $cities = $app['db']->fetchAll($citiesSql);
        $paymentData = $request->request->all();
        if (array_key_exists('step', $paymentData) === true) {



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
                    $app['user.mailer']->sendSuccessMessage($app['user'], $location, $class);

                } else {
                    $error = 'There was an issue during charging of your credit card.
                    Please provide another credit card data.';
                }
            } elseif  ($data['method'] === 'paypal') {

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
            if ($app['user']->hasCustomField('gender')
                && $app['user']->getCustomField('gender') == 'Female') {
                $classesSql = "
                SELECT *
                FROM challenger_weight_classes
                WHERE id = 7";
                $classes = $app['db']->fetchAll($classesSql);
            } elseif ($app['user']->hasCustomField('gender')
                && $app['user']->getCustomField('gender') == 'Male') {
                $classesSql = "
                                 SELECT *
                FROM challenger_weight_classes
                WHERE id NOT IN (
                 SELECT c.id
          FROM challenger_user_class_city map
          LEFT JOIN challenger_weight_classes c
          ON map.weight_class_id = c.id
          WHERE map.city_id = ?
          GROUP BY weight_class_id
          HAVING COUNT(*) > 15
          ORDER BY c.name
                ) AND id != 7";
                $classes = $app['db']->fetchAll($classesSql, [(int) $city]);
            }

            //$classes = $app['db']->fetchAll($classesSql, [(int)$city]);
        } else {
            $classes = null;
        }

        return new JsonResponse($classes);
    }

    public function resetPasswordAction(
        Application $app,
        Request $request,
        $token
    ) {

        $tokenExpired = false;

        /**
         * @var User $user
         */
        $user = $app['user.manager']->findOneBy(array('confirmationToken' => $token));
        if (!$user) {
            $tokenExpired = true;
        } else {
            if ($user->isPasswordResetRequestExpired($app['user.options']['passwordReset']['tokenTTL'])) {
                $tokenExpired = true;
            }
        }

        if ($tokenExpired) {
            $app['session']->getFlashBag()->set('alert',
                'Sorry, your password reset link has expired.');

            return $app->redirect($app['url_generator']->generate('user.login'));
        }

        $error = '';
        if ($request->isMethod('POST')) {
            // Validate the password
            $password = $request->request->get('password');
            if ($password != $request->request->get('confirm_password')) {
                $error = 'Passwords don\'t match.';
            } else {
                if ($error = $app['user.manager']->validatePasswordStrength($user,
                    $password)
                ) {
                    ;
                } else {
                    // Set the password and log in.
                    $app['user.manager']->setUserPassword($user, $password);
                    $user->setConfirmationToken(null);
                    $user->setEnabled(true);
                    $app['user.manager']->update($user);

                    $app['user.manager']->loginAsUser($user);

                    $app['session']->getFlashBag()->set('alert',
                        'Your password has been reset and you are now signed in.');

                    return $app->redirect($app['url_generator']->generate('challenger.registration'));
                }
            }
        }

        return $this->tabFormsAction($request, $app, 'reenter', $token);
    }
}
