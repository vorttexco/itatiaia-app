import 'package:flutter/material.dart';
import 'package:itatiaia_app/features/notifications_settings/notifications_settings.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';

abstract class NotificationsSettingsViewModel
    extends State<NotificationsSettings> {
  final Map<String, bool> notificationOptions = {};
  bool updatedPreferences = false;

  @override
  void initState() {
    super.initState();

    _getOptions();
  }

  void _getOptions() async {
    context.loaderOverlay.show();

    final tags = await OneSignal.User.getTags();

    final options = [
      {"label": "Urgente"},
      {"label": "Agro"},
      {"label": "Atlético"},
      {"label": "Brasil e Mundo"},
      {"label": "Cidades"},
      {"label": "Cruzeiro"},
      {"label": "Entretenimento"},
      {"label": "Política"},
      {"label": "Saúde"},
      {"label": "Tudo de Esportes"},
      {"label": "Vôlei"},
    ];

    for (var option in options) {
      final label = option["label"];

      if (label == null) continue;

      final bool value = bool.tryParse(tags[label]?.toString() ?? '') ?? true;

      notificationOptions[label] = value;
    }

    setState(() {
      notificationOptions;
      updatedPreferences = true;
    });

    context.loaderOverlay.hide();
  }

  void onSavePreferences() async {
    context.loaderOverlay.show();

    try {
      await OneSignal.User.addTags(
        notificationOptions.map(
          (key, value) => MapEntry(
            key,
            value.toString(),
          ),
        ),
      );
    } on Exception {
      //
    }

    context.loaderOverlay.hide();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
