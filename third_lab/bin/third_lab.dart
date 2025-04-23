abstract class ThemeStrategy {
  void applyTheme();
}

class LightTheme implements ThemeStrategy {
  @override
  void applyTheme() => print("Світла тема застосована");
}

class DarkTheme implements ThemeStrategy {
  @override
  void applyTheme() => print("Темна тема застосована");
}

abstract class SettingsObserver {
  void update(String key, dynamic value);
}

class LanguageWidget implements SettingsObserver {
  @override
  void update(String key, value) {
    if (key == "language") {
      print("Мову змінено на: $value");
    }
  }
}

class SettingsManager {
  final List<SettingsObserver> _observers = [];

  void addObserver(SettingsObserver observer) => _observers.add(observer);

  void changeSetting(String key, dynamic value) {
    print("🔧 Зміна $key на $value");
    for (final observer in _observers) {
      observer.update(key, value);
    }
  }
}

abstract class SettingsCommand {
  void execute();
  void undo();
}

class ChangeLanguageCommand implements SettingsCommand {
  final String previousLang;
  final String newLang;

  ChangeLanguageCommand(this.previousLang, this.newLang);

  @override
  void execute() => print("Мова змінена на $newLang");

  @override
  void undo() => print("Повернено мову $previousLang");
}

void main() {
  ThemeStrategy theme = DarkTheme();
  theme.applyTheme();

  theme = LightTheme();
  theme.applyTheme();

  final SettingsManager settingsManager = SettingsManager();
  final languageWidget = LanguageWidget();

  settingsManager.addObserver(languageWidget);
  settingsManager.changeSetting("language", "Українська");

  settingsManager.changeSetting("language", "English");

  final commandHistory = <SettingsCommand>[];

  final langCommand = ChangeLanguageCommand("English", "Deutsch");
  langCommand.execute();
  commandHistory.add(langCommand);

  commandHistory.last.undo();
}
