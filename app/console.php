<?php

use Symfony\Component\Console\Application;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputOption;

$console = new Application('My Silex Application', 'n/a');
$console->getDefinition()->addOption(new InputOption('--env', '-e', InputOption::VALUE_REQUIRED, 'The Environment name.', 'dev'));
$console->setDispatcher($app['dispatcher']);
$console
    ->register('my-command')
    ->setDefinition(array(
        // new InputOption('some-option', null, InputOption::VALUE_NONE, 'Some help'),
    ))
    ->setDescription('My command description')
    ->setCode(function (InputInterface $input, OutputInterface $output) use ($app) {
        // do something
    })
;
$console
    ->register('assetic:dump')
    ->setDescription('Dumps all assets to the filesystem')
    ->setCode(function (InputInterface $input, OutputInterface $output) use (
        $app
    ) {
        $dumper = $app['assetic.dumper'];
        if (isset($app['twig'])) {
            $dumper->addTwigAssets();
        }
        $dumper->dumpAssets();
        $output->writeln('<info>Dump finished</info>');
    });
$console
    ->register('assetic:dump-one')
    ->setDescription('Dumps one asset to the filesystem')
    ->addArgument('name', InputArgument::REQUIRED, 'The name of the asset')
    ->setCode(function (InputInterface $input, OutputInterface $output) use (
        $app
    ) {
        $name = $input->getArgument('name');
        $dumper = $app['assetic.dumper'];
        if (isset($app['twig'])) {
            $dumper->addTwigAssets();
        }
        $dumper->dumpAsset($name, $output);
        $output->writeln('<info>Dump finished</info>');
    });
if (isset($app['cache.path'])) {
    $console
        ->register('cache:clear')
        ->setDescription('Clears the cache')
        ->setCode(function (InputInterface $input, OutputInterface $output) use
        (
            $app
        ) {
            $cacheDir = $app['cache.path'];
            $finder = Finder::create()->in($cacheDir)->notName('.gitkeep');
            $filesystem = new Filesystem();
            $filesystem->remove($finder);
            $output->writeln(sprintf("%s <info>success</info>", 'cache:clear'));
        });
}
return $console;
