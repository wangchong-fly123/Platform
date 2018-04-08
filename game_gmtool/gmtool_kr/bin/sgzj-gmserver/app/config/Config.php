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
use \Phalcon\Session\Adapter\Files as SessionAdapter;
use \Phalcon\Text;

final class Config
{
    private $di_;

    public function init($root_dir)
    {
        $config = new ConfigIni($root_dir.'../../settings/config.ini');

        // loader
        $loader = new Loader();
        $loader->registerDirs(array(
            $root_dir.'app/controllers/',
            $root_dir.'app/models/',
            $root_dir.'app/lib/',
        ));
        $loader->register();

        $this->di_ = new FactoryDefault();

        // router
        $this->di_->setShared('router', function() {
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
        $this->di_->setShared('dispatcher', function() {
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
        $this->di_->set('view', function() use ($root_dir) {
            $view = new View();
            $view->setViewsDir($root_dir.'app/views/');
            $view->registerEngines(array(
                '.volt' => 'volt',
            ));
            return $view;
        });

        // volt
        $this->di_->setShared('volt', function($view, $di) use ($root_dir) {
            $volt = new Volt($view, $di);
            $volt->setOptions(array(
                'compiledPath' => $root_dir.'cache/',
                'compiledSeparator' => '_',
            ));
            return $volt;
        });

        // session
        $this->di_->setShared('session', function() use ($config) {
            $session = new SessionAdapter(array(
                'uniqueId' => $config->db->dbname,
            ));
            $session->start();
            return $session;
        });

        // db
        $this->di_->setShared('db', function() use ($config) {
            return new DbAdapter(array(
                "host" => $config->db->host,
                "port" => $config->db->port,
                "username" => $config->db->username,
                "password" => $config->db->password,
                "dbname" => $config->db->dbname,
                "charset" => 'utf8',
            ));
        });
    }

    public function getDI()
    {
        return $this->di_;
    }
}
