<?php

use \Phalcon\Config\Adapter\Ini as ConfigIni;
use \Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use \Phalcon\DI\FactoryDefault;
use \Phalcon\Events\Manager as EventsManager;
use \Phalcon\Loader;
use \Phalcon\Mvc\Dispatcher as MvcDispatcher;
use \Phalcon\Mvc\Dispatcher\Exception as DispatchException;
use \Phalcon\Mvc\View;
use \Phalcon\Mvc\View\Engine\Volt;
use \Phalcon\Mvc\Router;
use \Phalcon\Text;

final class Config
{
    private static $di_;

    public static function init($root_dir)
    {
        $config = new ConfigIni($root_dir.'app/config/config.ini');

        // loader
        $loader = new Loader();
        $loader->registerDirs(array(
            $root_dir.'app/controllers/',
            $root_dir.'app/models/',
        ));
        $loader->register();

        self::$di_ = new FactoryDefault();

        // router
        self::$di_->set('router', function() {
            $router = new Router(false);
            $router->add('/', array(
                'controller' => 'index',
                'action' => 'index',
            ));
            $router->add('/([a-z0-9_]+)', array(
                'controller' => 1,
                'action' => 'index',
            ));
            $router->add('/([a-z0-9_]+)/([a-z0-9_]+)/:params', array(
                'controller' => 1,
                'action' => 2,
                'params' => 3,
            ))->convert('action', function($action) {
                return lcfirst(Text::camelize($action));
            });

            $router->notFound(array(
                'controller' => 'index',
                'action' => 'page404',
            ));
            return $router;
        });

        // dispatcher
        self::$di_->set('dispatcher', function() {
            $events_manager = new EventsManager();
            $events_manager->attach("dispatch:beforeException",
                function($event, $dispatcher, $exception) {
                    if ($exception instanceof DispatchException) { 
                        $dispatcher->forward(array(
                            'controller' => 'index',
                            'action'     => 'page404'
                        ));
                        return false;
                    }
                });
            $dispatcher = new MvcDispatcher();
            $dispatcher->setEventsManager($events_manager);
            return $dispatcher;
        });

        // view
        self::$di_->set('view', function() use ($root_dir) {
            $view = new View();
            $view->setViewsDir($root_dir.'app/views/');
            $view->registerEngines(array(
                '.volt' => 'volt'
            ));
            return $view;
        });

        // volt
        self::$di_->set('volt', function($view, $di) use ($config) {
            $volt = new Volt($view, $di);
            $volt->setOptions(array(
                'compiledPath' => $config->app->volt_cache_dir,
                'compiledSeparator' => '_'
            ));
            return $volt;
        });
    }

    public static function getDI()
    {
        return self::$di_;
    }
}
