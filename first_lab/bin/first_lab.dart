abstract class Button {
  void render();
}

class AndroidButton implements Button {
  @override
  void render() => print("Android-style Button");
}

class IOSButton implements Button {
  @override
  void render() => print("iOS-style Button");
}

abstract class Dialog {
  Button createButton();

  void render() {
    Button button = createButton();
    button.render();
  }
}

class AndroidDialog extends Dialog {
  @override
  Button createButton() => AndroidButton();
}

class IOSDialog extends Dialog {
  @override
  Button createButton() => IOSButton();
}

abstract class UIFactory {
  Button createButton();
}

class AndroidUIFactory implements UIFactory {
  @override
  Button createButton() => AndroidButton();
}

class IOSUIFactory implements UIFactory {
  @override
  Button createButton() => IOSButton();
}

void main() {
  String platform = "iOS";

  Dialog dialog = platform == "Android" ? AndroidDialog() : IOSDialog();
  dialog.render();

  UIFactory uiFactory =
      platform == "Android" ? AndroidUIFactory() : IOSUIFactory();
  Button button = uiFactory.createButton();
  button.render();
}
