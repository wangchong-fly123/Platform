<?php

final class Captcha
{
    public $width = 80;
    public $height = 30;
    public $text_length = 4;
    public $text_chars = '0123456789';
    public $text_font = 'arial.ttf';
    public $text_colors = array(
        array(255, 0, 0),
        array(0, 0, 255),
        array(0, 0, 0),
    );
    public $background_color = array(255, 255, 255);

    private $text_ = '';
    private $img_ = null;

    public function __construct()
    {
    }

    public function build()
    {
        $this->createImage();
        $this->createCaptchaText();
        $this->writeCaptchaText();
        $this->writeLine(5);
    }

    public function getCaptchaText()
    {
        return $this->text_;
    }

    public function sendImage()
    {
        header('Content-type: image/png');
        imagepng($this->img_, null);
    }

    private function createImage()
    {
        if ($this->img_ !== null) {
            imagedestory($this->img_);
        }

        $this->img_ = imagecreatetruecolor($this->width, $this->height);

        // background_color
        $gd_color = imagecolorallocate($this->img_,
            $this->background_color[0],
            $this->background_color[1],
            $this->background_color[2]);
        imagefilledrectangle($this->img_,
            0, 0, $this->width, $this->height, $gd_color);
    }

    private function createCaptchaText()
    {
        $this->text_ = '';
        $count = strlen($this->text_chars);

        for ($i = 0; $i < $this->text_length; ++$i) {
            $this->text_ .=
                substr($this->text_chars, mt_rand(0, $count - 1), 1);
        }
    }

    private function writeCaptchaText()
    {
        for ($i = 0; $i < $this->text_length; ++$i) {
            $color = $this->text_colors[
                mt_rand(0, count($this->text_colors) - 1)];
            $gd_color = imagecolorallocate($this->img_,
                $color[0], $color[1], $color[2]);
            imagettftext($this->img_,
                         mt_rand(15, 18),
                         mt_rand(-15, 15),
                         $i * 20 + mt_rand(0, 3),
                         20 + mt_rand(0, 3), $gd_color,
                         __DIR__.'/../fonts/'.$this->text_font, $this->text_[$i]);
        }
    }

    private function writeLine($count)
    {
        for ($i = 0; $i < $count; ++$i) {
            $color = $this->text_colors[
                mt_rand(0, count($this->text_colors) - 1)];
            $gd_color = imagecolorallocate($this->img_,
                $color[0], $color[1], $color[2]);
            $x1 = mt_rand(0, $this->width);
            $y1 = mt_rand(0, $this->height);
            $x2 = mt_rand(0, $this->width);
            $y2 = mt_rand(0, $this->height);
            imageline($this->img_, $x1, $y1, $x2, $y2, $gd_color);
        }
    }

    private function blur()
    {
        imagefilter($this->img_, IMG_FILTER_GAUSSIAN_BLUR);
    }
}
