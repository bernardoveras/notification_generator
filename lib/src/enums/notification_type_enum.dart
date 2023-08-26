enum NotificationIcon {
  braip('Braip', 'braip'),
  kiwify('Kiwify', 'kiwify'),
  kirvano('Kirvano', 'kirvano'),
  monetizze('Monetizze', 'monetizze'),
  hotmart('Hotmart', 'hotmart');

  final String title;
  final String identifier;

  const NotificationIcon(this.title, this.identifier);
}
