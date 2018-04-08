<?php

final class IndexController extends ControllerBase
{
    public function indexAction()
    {
    }

    public function page404Action()
    {
        $this->view->disable();
        $this->response->setStatusCode(404, 'Not Found');
        echo '<p>404 - Page Not Found</p>';
    }

    public function page403Action()
    {
        $this->view->disable();
        $this->response->setStatusCode(403, 'Forbidden');
    }
}
