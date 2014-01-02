package;


import flash.display.Sprite;
import flash.display.Bitmap;
import flash.filters.ColorMatrixFilter;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.Lib;

import openfl.Assets;

import ru.zzzzzzerg.linden.StartApp;


class Main extends Sprite {

  public static var GRAYSCALE_FILTER = new ColorMatrixFilter (
      [1 - (1 / 3.0 * 2), 1 / 3.0, 1 / 3.0, 0, 0,
       1 / 3.0, 1 - (1 / 3.0 * 2), 1 / 3.0, 0, 0,
       1 / 3.0, 1 / 3.0, 1 - (1 / 3.0 * 2), 0, 0,
       0, 0, 0, 1, 0]);

  var _splash : Btn;
  var _interstitial : Btn;
  var _interstitialBackButton : Btn;
  var _showBanner : Btn;
  var _hideBanner : Btn;

  public function new () {

    super ();

    StartApp.start("112325663", "201504408", false);

    _splash = new Btn("assets/btn1.png", "Show Splash");
    _interstitial = new Btn("assets/btn2.png", "Show Interstitial");
    _interstitialBackButton = new Btn("assets/btn3.png", "Show Interstitial (BackButton)");
    _showBanner = new Btn("assets/btn4.png", "Show Banner");
    _hideBanner = new Btn("assets/btn4.png", "Hide Banner");

    _splash.addEventListener(MouseEvent.CLICK, showSplashScreen);
    _splash.x = 50;
    _splash.y = 50;

    _interstitial.addEventListener(MouseEvent.CLICK, showInterstitial);
    _interstitial.x = 50;
    _interstitial.y = 150;

    _interstitialBackButton.addEventListener(MouseEvent.CLICK, showInterstitialBackButton);
    _interstitialBackButton.x = 50;
    _interstitialBackButton.y = 250;

    _showBanner.addEventListener(MouseEvent.CLICK, showBanner);
    _showBanner.x = 50;
    _showBanner.y = 350;

    _hideBanner.addEventListener(MouseEvent.CLICK, hideBanner);
    _hideBanner.x = 250;
    _hideBanner.y = 350;

    addChild(_splash);
    addChild(_interstitial);
    addChild(_interstitialBackButton);
    addChild(_showBanner);
    addChild(_hideBanner);

    //stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
  }

  function onKeyUp(event : KeyboardEvent)
  {
    switch(event.keyCode)
    {
      case Keyboard.ESCAPE:
        Lib.exit();
    }
  }


  function showSplashScreen(e : MouseEvent)
  {
    StartApp.showSplashScreen();
  }

  function showInterstitial(e : MouseEvent)
  {
    StartApp.showInterstitial();
  }

  function showInterstitialBackButton(e : MouseEvent)
  {
    StartApp.showInterstitialBackButton();
  }

  function showBanner(e : MouseEvent)
  {
    StartApp.showBanner(Gravity.TOP | Gravity.CENTER_HORIZONTAL);
  }

  function hideBanner(e : MouseEvent)
  {
    StartApp.hideBanner();
  }


}

class Btn extends Sprite
{
  public var enabled : Bool;
  public var icon : Sprite;
  public var label : TextField;
  var bitmap : Bitmap;

  public function new(img : String, text : String, ?enabled : Bool = true)
  {
    super();

    this.enabled = enabled;

    this.bitmap = new Bitmap(Assets.getBitmapData(img));

    this.icon = new Sprite();
    this.icon.addChild(this.bitmap);
    this.icon.useHandCursor = true;
    if(!enabled)
    {
      this.bitmap.bitmapData.applyFilter(this.bitmap.bitmapData,
          this.bitmap.bitmapData.rect, new Point(0, 0), Main.GRAYSCALE_FILTER);
    }

    this.label = new TextField();
    this.label.text = text;
    this.label.x = this.icon.width + 5;
    this.label.y = this.icon.height / 2.0;

    addChild(this.icon);
    addChild(this.label);
  }
}

