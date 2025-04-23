class NotificationMessage {
  String? title;
  String? body;
  String? icon;
  DateTime? sendTime;
  bool? isImportant;

  NotificationMessage({
    this.title,
    this.body,
    this.icon,
    this.sendTime,
    this.isImportant,
  });

  NotificationMessage clone() {
    return NotificationMessage(
      title: this.title,
      body: this.body,
      icon: this.icon,
      sendTime: this.sendTime,
      isImportant: this.isImportant,
    );
  }

  void display() {
    print("🔔 $title");
    print("   $body");
    if (icon != null) print("Іконка: $icon");
    if (sendTime != null) print("Час: $sendTime");
    if (isImportant == true) print(" Важливе повідомлення");
  }
}

abstract class NotificationBuilder {
  void reset();
  void setTitle(String title);
  void setBody(String body);
  void setIcon(String icon);
  void setSendTime(DateTime time);
  void markAsImportant(bool value);
  NotificationMessage build();
}

class DefaultNotificationBuilder implements NotificationBuilder {
  late NotificationMessage _message;

  DefaultNotificationBuilder() {
    reset();
  }

  @override
  void reset() {
    _message = NotificationMessage();
  }

  @override
  void setTitle(String title) {
    _message.title = title;
  }

  @override
  void setBody(String body) {
    _message.body = body;
  }

  @override
  void setIcon(String icon) {
    _message.icon = icon;
  }

  @override
  void setSendTime(DateTime time) {
    _message.sendTime = time;
  }

  @override
  void markAsImportant(bool value) {
    _message.isImportant = value;
  }

  @override
  NotificationMessage build() => _message;
}

class NotificationDirector {
  NotificationBuilder? builder;

  void buildSpotifyNewAlbumNotification(String artist) {
    builder?.reset();
    builder?.setTitle("Новий альбом від $artist");
    builder?.setBody("Прослухайте вже зараз!");
    builder?.setIcon("🎵");
    builder?.setSendTime(DateTime.now());
    builder?.markAsImportant(false);
  }

  void buildInstagramMessageNotification(String userName) {
    builder?.reset();
    builder?.setTitle("Нове повідомлення");
    builder?.setBody("Ви отримали повідомлення від $userName.");
    builder?.setIcon("✉️");
    builder?.setSendTime(DateTime.now());
    builder?.markAsImportant(true);
  }
}

class NotificationTemplateRegistry {
  final Map<String, NotificationMessage> _templates = {};

  void register(String key, NotificationMessage message) {
    _templates[key] = message;
  }

  NotificationMessage? clone(String key) {
    return _templates[key]?.clone();
  }
}

void main() {
  var builder = DefaultNotificationBuilder();
  var director = NotificationDirector();
  director.builder = builder;

  director.buildSpotifyNewAlbumNotification("Imagine Dragons");
  var spotifyNotif = builder.build();
  spotifyNotif.display();

  var registry = NotificationTemplateRegistry();
  registry.register("spotify", spotifyNotif);

  var cloned = registry.clone("spotify");
  cloned?.title = "Новий альбом від Arctic Monkeys";
  cloned?.display();

  director.buildInstagramMessageNotification("user_id");
  var instaNotif = builder.build();
  instaNotif.display();
}
