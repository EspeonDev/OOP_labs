abstract class Command {
  void execute();
}

class ClearCacheCommand implements Command {
  @override
  void execute() => print("Кеш очищено");
}

class LogoutCommand implements Command {
  @override
  void execute() => print("Користувач вийшов з акаунту");
}

class RefreshTokenCommand implements Command {
  @override
  void execute() => print("Токен оновлено");
}

// Макрокоманда
class MacroCommand implements Command {
  final List<Command> _commands;

  MacroCommand(this._commands);

  @override
  void execute() {
    for (final command in _commands) {
      command.execute();
    }
  }
}

abstract class UserFlow {
  void executeFlow() {
    validateInput();
    authenticate();
    showMainScreen();
  }

  void validateInput();
  void authenticate();
  void showMainScreen() => print("Перехід на головний екран");
}

class LoginFlow extends UserFlow {
  @override
  void validateInput() => print("Перевірка логіну та пароля");

  @override
  void authenticate() => print("Аутентифікація користувача");
}

class RegisterFlow extends UserFlow {
  @override
  void validateInput() => print("Перевірка даних реєстрації");

  @override
  void authenticate() => print("Реєстрація нового користувача");
}

void main() {
  print("Макрокоманда: Вихід з акаунту");
  final logoutMacro = MacroCommand([
    RefreshTokenCommand(),
    ClearCacheCommand(),
    LogoutCommand(),
  ]);
  logoutMacro.execute();

  print("\nШаблонний метод: Вхід у систему");
  final login = LoginFlow();
  login.executeFlow();

  print("\nШаблонний метод: Реєстрація");
  final register = RegisterFlow();
  register.executeFlow();
}
