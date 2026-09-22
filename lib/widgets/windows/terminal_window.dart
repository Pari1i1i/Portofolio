import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/url_helper.dart';
import '../../data/models/window_model.dart';
import '../../data/portfolio_data.dart';
import '../../state/window_manager.dart';

class TerminalWindow extends StatefulWidget {
  final WindowManager windowManager;

  const TerminalWindow({super.key, required this.windowManager});

  @override
  State<TerminalWindow> createState() => _TerminalWindowState();
}

class _TerminalWindowState extends State<TerminalWindow> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final List<String> _history = [
    'Last login: Tue Sep 22 2026 20:00:00 on ttys001',
    'Fachri Achmad Portfolio Shell v2.6.0 (darwin-arm64)',
    'Type "help" to see available commands or "neofetch" for system summary.',
    '',
  ];

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleCommand(String rawInput) {
    final input = rawInput.trim();
    if (input.isEmpty) {
      setState(() {
        _history.add('fachri@macbook-pro ~ % ');
      });
      _scrollToBottom();
      return;
    }

    setState(() {
      _history.add('fachri@macbook-pro ~ % $input');
      final parts = input.split(' ');
      final cmd = parts[0].toLowerCase();
      final arg = parts.length > 1 ? parts.sublist(1).join(' ').toLowerCase() : '';

      switch (cmd) {
        case 'help':
          _history.addAll([
            'Available commands:',
            '  help         - Show this guide',
            '  whoami       - Display current user identity',
            '  about        - View Fachri Achmad bio',
            '  projects     - List all 6 projects with descriptions',
            '  achievements - View Akademik & Partisipan achievements',
            '  contact      - Display email & social profiles',
            '  neofetch     - Display system info & ASCII art',
            '  open <app>   - Launch a window (e.g. open projects, open about)',
            '  date         - Print current system date',
            '  clear        - Clear terminal screen',
          ]);
          break;

        case 'whoami':
          _history.addAll([
            'fachri (Fachri Achmad)',
            'Role: Software Engineer & Flutter Developer',
            'Location: Jakarta, Indonesia',
          ]);
          break;

        case 'about':
          _history.addAll([
            'About Fachri Achmad:',
            AppStrings.bio,
          ]);
          break;

        case 'projects':
          _history.add('--- 6 Main Projects ---');
          for (var i = 0; i < PortfolioData.projects.length; i++) {
            final p = PortfolioData.projects[i];
            _history.add('${i + 1}. ${p.title} [${p.category}]');
            _history.add('   ${p.subtitle}');
            _history.add('   Tech: ${p.techStack.join(', ')}');
            _history.add('   Repo: ${p.githubUrl}');
          }
          break;

        case 'achievements':
          _history.addAll([
            '--- Achievements (Sub-Folders) ---',
            '[Akademik]:',
            '  1. LKS ITSSB 3rd Place in Jakarta Timur 2026',
            '  2. TOEIC Score 895 2026',
            '  3. Sertifikat Website dari Dicoding 2026',
            '  4. Sertifikat JS dari Dicoding 2026',
            '  5. Java Foundation Class 2026',
            '',
            '[Partisipan]:',
            '  1. KSR 2025 Bidang MTK',
            '  2. Bootcamp Innovation 2023 Generasi Terampil (UNICEF)',
            '  3. Kegiatan Pasar Modal di IDX 2026',
            '  4. Literasi Numerasi UNJ 2024',
          ]);
          break;

        case 'contact':
          _history.addAll([
            '--- Contact & Socials ---',
            'Email:     ${AppStrings.email}',
            'GitHub:    ${AppStrings.githubUrl}',
            'LinkedIn:  ${AppStrings.linkedinUrl}',
            'Instagram: ${AppStrings.instagramUrl}',
          ]);
          break;

        case 'neofetch':
        case 'fastfetch':
          _history.addAll([
            '       .:\'          fachri@macbook-pro',
            '     _ :\'_          ------------------',
            '  .\'`_`-\'_\'`\'.      OS: macOS Sonoma 14.5 (Flutter Web Emulation)',
            ' :________.-. :     Host: MacBook Pro 16" (M3 Max)',
            ' : ________: : :    Kernel: Darwin 23.5.0',
            '  : -._____.- :     Uptime: 24 days, 7 hours',
            '   `-._____.-`      Packages: 6 projects, 9 achievements',
            '                    Shell: zsh 5.9',
            '                    Terminal: Mac Terminal (Flutter Engine)',
            '                    CPU: Apple M3 Max (16-core)',
            '                    Memory: 36 GB Unified RAM',
          ]);
          break;

        case 'date':
          _history.add(DateTime.now().toLocal().toString());
          break;

        case 'open':
          if (arg.isEmpty) {
            _history.add('Usage: open <app> (e.g. open projects, open achievements, open about)');
          } else if (arg.contains('project')) {
            widget.windowManager.openWindow(WindowType.projects);
            _history.add('Opening Projects window...');
          } else if (arg.contains('achieve')) {
            widget.windowManager.openWindow(WindowType.achievements);
            _history.add('Opening Achievement window...');
          } else if (arg.contains('about')) {
            widget.windowManager.openWindow(WindowType.about);
            _history.add('Opening About Me window...');
          } else if (arg.contains('contact') || arg.contains('mail')) {
            UrlHelper.openEmail(AppStrings.email);
            _history.add('Launching default mail client...');
          } else if (arg.contains('github')) {
            UrlHelper.openUrl(AppStrings.githubUrl);
            _history.add('Opening GitHub in browser...');
          } else {
            _history.add('Unknown app: $arg. Type "help" for options.');
          }
          break;

        case 'clear':
          _history.clear();
          break;

        default:
          _history.add('zsh: command not found: $cmd. Type "help" for a list of commands.');
      }
    });

    _inputController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        color: const Color(0xFF141416),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final line = _history[index];
                  final isPrompt = line.startsWith('fachri@macbook-pro');
                  return SelectableText(
                    line,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      height: 1.4,
                      color: isPrompt ? const Color(0xFF38BDF8) : const Color(0xFFE2E8F0),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text(
                  'fachri@macbook-pro ~ % ',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF38BDF8),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    focusNode: _focusNode,
                    autofocus: true,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      color: Colors.white,
                    ),
                    cursorColor: const Color(0xFF38BDF8),
                    cursorWidth: 8,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    onSubmitted: _handleCommand,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
