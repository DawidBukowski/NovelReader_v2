// lib/core/router/stub_screens.dart
// Temporary stubs — deleted and replaced by real screens in Step 5.

import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Library — coming in Step 5')));
}

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key, this.articleId});
  final int? articleId;
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Player — coming in Step 5')));
}

class VoiceManagerScreen extends StatelessWidget {
  const VoiceManagerScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Voice Manager — coming in Step 5')));
}

class AddUrlScreen extends StatelessWidget {
  const AddUrlScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Add URL — coming in Step 5')));
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Settings — coming in Step 5')));
}