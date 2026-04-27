// lib/features/tts_player/presentation/screens/player_screen.dart
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../library/presentation/providers/library_providers.dart';
import '../../domain/entities/player_state.dart';
import '../../domain/entities/sentence_segment.dart';
import '../providers/tts_providers.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  const PlayerScreen({super.key, this.articleId});
  final int? articleId;

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  final _scrollController = ScrollController();
  bool _articleLoaded = false;

  @override
  void initState() {
    super.initState();
    // Load article once after the first frame so providers are ready.
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadArticle());
  }

  Future<void> _loadArticle() async {
    if (_articleLoaded || widget.articleId == null) return;
    _articleLoaded = true;

    final article =
    await ref.read(articleByIdProvider(widget.articleId!).future);
    if (article == null || !mounted) return;

    final useCase =
    await ref.read(loadArticleUseCaseProvider.future);
    await useCase(
      text: article.plainText,
      title: article.title,
      sourceUrl: article.sourceUrl,
      articleId: article.id,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(playerStateProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context, stateAsync),
      body: stateAsync.when(
        loading: () =>
        const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (state) => Column(
          children: [
            Expanded(child: _KaraokeView(
              state: state,
              scrollController: _scrollController,
            )),
            _PlayerControls(state: state),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, AsyncValue<TtsPlayerState> stateAsync) {
    final title = stateAsync.valueOrNull?.articleTitle ?? '';
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        onPressed: () => context.pop(),
      ),
      title: Column(
        children: [
          Text(
            'Now Playing',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.record_voice_over_outlined),
          tooltip: 'Change Voice',
          onPressed: () => context.push(AppRoutes.voiceManager),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KARAOKE VIEW — scrollable article with active sentence highlighted
// ─────────────────────────────────────────────────────────────────────────────

class _KaraokeView extends ConsumerWidget {
  const _KaraokeView({
    required this.state,
    required this.scrollController,
  });

  final TtsPlayerState state;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.segments.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      itemCount: state.segments.length,
      itemBuilder: (context, index) {
        final segment = state.segments[index];
        final isActive = index == state.activeSegmentIndex;

        // Auto-scroll to active segment.
        if (isActive) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToActive(scrollController, index);
          });
        }

        return _SegmentTile(
          segment: segment,
          isActive: isActive,
          onTap: () async {
            final useCase =
            await ref.read(seekToSegmentUseCaseProvider.future);
            await useCase(index);
          },
        );
      },
    );
  }

  void _scrollToActive(ScrollController controller, int index) {
    if (!controller.hasClients) return;
    // Each segment tile is roughly 60px; scroll to keep it centred.
    final targetOffset = (index * 60.0) -
        (controller.position.viewportDimension / 2) + 30;
    controller.animateTo(
      targetOffset.clamp(0.0, controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class _SegmentTile extends StatelessWidget {
  const _SegmentTile({
    required this.segment,
    required this.isActive,
    required this.onTap,
  });

  final SentenceSegment segment;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? theme.colorScheme.primaryContainer.withOpacity(0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          segment.text,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.7,
            color: isActive
                ? theme.colorScheme.onPrimaryContainer
                : segment.synthesisState == SegmentSynthesisState.error
                ? theme.colorScheme.error.withOpacity(0.6)
                : theme.colorScheme.onSurface.withOpacity(
              segment.index < (segment.index) ? 0.4 : 0.85,
            ),
            fontWeight:
            isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PLAYER CONTROLS — play/pause, skip, speed
// ─────────────────────────────────────────────────────────────────────────────

class _PlayerControls extends ConsumerWidget {
  const _PlayerControls({required this.state});
  final TtsPlayerState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isPlaying = state.status == TtsPlaybackStatus.playing;
    final isLoading = state.status == TtsPlaybackStatus.loading;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius:
        const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag handle ──────────────────────────────────────────────
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // ── Progress bar ─────────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: state.readProgress,
              minHeight: 3,
              backgroundColor: theme.colorScheme.surfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${state.activeSegmentIndex + 1} / ${state.segments.length}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '${(state.readProgress * 100).round()}%',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Transport controls ────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Skip previous
              IconButton(
                iconSize: 36,
                icon: const Icon(Icons.skip_previous_rounded),
                color: state.canSkipPrev
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurface.withOpacity(0.3),
                onPressed: state.canSkipPrev
                    ? () async {
                  final uc = await ref
                      .read(skipPreviousUseCaseProvider.future);
                  await uc();
                }
                    : null,
              ),
              const SizedBox(width: 16),

              // Play / Pause — main button
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: isLoading
                    ? Padding(
                  padding: const EdgeInsets.all(18),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: theme.colorScheme.onPrimary,
                  ),
                )
                    : IconButton(
                  iconSize: 32,
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: theme.colorScheme.onPrimary,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      final uc = await ref
                          .read(pauseUseCaseProvider.future);
                      await uc();
                    } else {
                      final uc = await ref
                          .read(playUseCaseProvider.future);
                      await uc();
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),

              // Skip next
              IconButton(
                iconSize: 36,
                icon: const Icon(Icons.skip_next_rounded),
                color: state.canSkipNext
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurface.withOpacity(0.3),
                onPressed: state.canSkipNext
                    ? () async {
                  final uc = await ref
                      .read(skipNextUseCaseProvider.future);
                  await uc();
                }
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Speed slider ──────────────────────────────────────────────
          _SpeedSlider(currentSpeed: state.speed),
        ],
      ),
    );
  }
}

class _SpeedSlider extends ConsumerWidget {
  const _SpeedSlider({required this.currentSpeed});
  final double currentSpeed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          '0.5×',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Expanded(
          child: Slider(
            value: currentSpeed.clamp(0.5, 3.0),
            min: 0.5,
            max: 3.0,
            divisions: 25,
            label: '${currentSpeed.toStringAsFixed(1)}×',
            onChanged: (value) async {
              final uc =
              await ref.read(setSpeedUseCaseProvider.future);
              await uc(value);
            },
          ),
        ),
        Text(
          '3×',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '${currentSpeed.toStringAsFixed(1)}×',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}