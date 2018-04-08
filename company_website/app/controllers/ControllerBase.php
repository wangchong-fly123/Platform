<?php

use \Phalcon\Mvc\Controller;

class ControllerBase extends Controller
{
    protected function initialize()
    {
        $this->view->setTemplateAfter('main');
    }

    protected function forward($controller, $action='index', $params=array())
    {
        return $this->dispatcher->forward(array(
            'controller' => $controller,
            'action' => $action,
            'params' => $params
        ));
    }

    protected function gotoIndex()
    {
        return $this->response->redirect('');
    }

    protected function gotoPage403()
    {
        return $this->response->redirect('index/page403');
    }
}
