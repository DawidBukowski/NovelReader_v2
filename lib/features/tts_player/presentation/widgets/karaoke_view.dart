// lib/features/tts_player/presentation/widgets/karaoke_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/player_state.dart';
import '../../domain/entities/sentence_segment.dart';

class KaraokeView extends ConsumerStatefulWidget {
  const KaraokeView({
    super.key,
    required this.playerState,
    required this.onSegmentTap,
  });

  final TtsPlayerState playerState;
  final void Function(int segmentIndex) onSegmentTap;

  @override
  ConsumerState<KaraokeView> createState() => _KaraokeViewState();
}

class _KaraokeViewState extends ConsumerState<KaraokeView> {
  final _scrollController = ScrollController();

  // One GlobalKey per segment to measure its position for auto-scroll.
  late List<GlobalKey> _keys;

  @override
  void initState() {
    super.initState();
    _keys = List.generate(
      widget.playerState.segments.length,
          (_) => GlobalKey(),
    );
  }

  @override
  void didUpdateWidget(KaraokeView old) {
    super.didUpdateWidget(old);

    // Regenerate keys if the segment count changed (new article loaded).
    if (widget.playerState.segments.length != old.playerState.segments.length) {
      _keys = List.generate(
        widget.playerState.segments.length,
            (_) => GlobalKey(),
      );
    }

    // Auto-scroll to the active segment whenever it changes.
    final newIndex = widget.playerState.activeSegmentIndex;
    final oldIndex = old.playerState.activeSegmentIndex;
    if (newIndex != oldIndex && newIndex >= 0) {
      _scrollToActive(newIndex);
    }
  }

  void _scrollToActive(int index) {
    if (index >= _keys.length) return;
    final key = _keys[index];
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      alignment: 0.3, // keep the active sentence in the upper third
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final segments = widget.playerState.segments;
    final activeIndex = widget.playerState.activeSegmentIndex;
    final theme = Theme.of(context);

    if (segments.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: segments.length,
      itemBuilder: (context, index) {
        final segment = segments[index];
        final isActive = index == activeIndex;
        final isPast = index < activeIndex;

        return _SegmentChip(
          key: _keys[index],
          segment: segment,
          isActive: isActive,
          isPast: isPast,
          onTap: () => widget.onSegmentTap(index),
          theme: theme,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _SegmentChip extends StatelessWidget {
  const _SegmentChip({
    super.key,
    required this.segment,
    required this.isActive,
    required this.isPast,
    required this.onTap,
    required this.theme,
  });

  final SentenceSegment segment;
  final bool isActive;
  final bool isPast;
  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    Color textColor;
    FontWeight fontWeight;
    Color? backgroundColor;
    double opacity;

    if (isActive) {
      textColor = theme.colorScheme.onPrimaryContainer;
      fontWeight = FontWeight.w600;
      backgroundColor = theme.colorScheme.primaryContainer;
      opacity = 1.0;
    } else if (isPast) {
      textColor = theme.colorScheme.onSurface;
      fontWeight = FontWeight.w400;
      backgroundColor = null;
      opacity = 0.45;
    } else {
      textColor = theme.colorScheme.onSurface;
      fontWeight = FontWeight.w400;
      backgroundColor = null;
      opacity = 0.85;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: isActive
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
            : const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Opacity(
          opacity: opacity,
          child: Text(
            segment.text,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: textColor,
              fontWeight: fontWeight,
              height: 1.65,
              fontSize: isActive ? 17 : 16,
            ),
          ),
        ),
      ),
    );
  }
}