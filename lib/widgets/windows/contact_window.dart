import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/url_helper.dart';
import '../../state/window_manager.dart';

class ContactWindow extends StatefulWidget {
  final WindowManager windowManager;

  const ContactWindow({super.key, required this.windowManager});

  @override
  State<ContactWindow> createState() => _ContactWindowState();
}

class _ContactWindowState extends State<ContactWindow> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String? _statusMessage;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    setState(() {
      _statusMessage = '$label disalin ke clipboard!';
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _statusMessage = null);
    });
  }

  void _sendEmail() {
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();
    UrlHelper.openEmail(AppStrings.email, subject: subject, body: message);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.windowManager.isDarkMode;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 650;

        return Column(
          children: [
            // Status banner if copied
            if (_statusMessage != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                color: AppColors.accentGreen.withValues(alpha: 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_rounded, size: 14, color: AppColors.accentGreen),
                    const SizedBox(width: 8),
                    Text(
                      _statusMessage!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.accentGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            Expanded(
              child: isNarrow
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildSocialCards(isDark),
                          const SizedBox(height: 20),
                          _buildEmailForm(isDark),
                        ],
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Left Pane: Social Channels
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF18181A) : const Color(0xFFE4E4E8),
                              border: Border(
                                right: BorderSide(
                                  color: isDark ? const Color(0x22FFFFFF) : const Color(0x18000000),
                                  width: 0.8,
                                ),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: _buildSocialCards(isDark),
                            ),
                          ),
                        ),
                        // Right Pane: Compose Email
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: _buildEmailForm(isDark),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSocialCards(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect with me',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Feel free to reach out for collaborations, project inquiries, or simply to say hello!',
          style: TextStyle(
            fontSize: 12,
            height: 1.4,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 18),

        // Email Card
        _buildContactTile(
          icon: Icons.mail_rounded,
          iconColor: Colors.redAccent,
          title: 'Email',
          subtitle: AppStrings.email,
          onTap: () => UrlHelper.openEmail(AppStrings.email),
          onCopy: () => _copyToClipboard(AppStrings.email, 'Email'),
          isDark: isDark,
        ),
        const SizedBox(height: 10),

        // GitHub Card
        _buildContactTile(
          iconWidget: const FaIcon(FontAwesomeIcons.github, size: 18),
          title: 'GitHub Profile',
          subtitle: 'github.com/Pari1i1i',
          onTap: () => UrlHelper.openUrl(AppStrings.githubUrl),
          onCopy: () => _copyToClipboard(AppStrings.githubUrl, 'URL GitHub'),
          isDark: isDark,
        ),
        const SizedBox(height: 10),

        // LinkedIn Card
        _buildContactTile(
          iconWidget: const FaIcon(FontAwesomeIcons.linkedin, size: 18, color: Color(0xFF0A66C2)),
          title: 'LinkedIn',
          subtitle: 'linkedin.com/in/fachriii/',
          onTap: () => UrlHelper.openUrl(AppStrings.linkedinUrl),
          onCopy: () => _copyToClipboard(AppStrings.linkedinUrl, 'URL LinkedIn'),
          isDark: isDark,
        ),
        const SizedBox(height: 10),

        // Instagram Card
        _buildContactTile(
          iconWidget: const FaIcon(FontAwesomeIcons.instagram, size: 18, color: Color(0xFFE4405F)),
          title: 'Instagram',
          subtitle: '@achmadfachrii__',
          onTap: () => UrlHelper.openUrl(AppStrings.instagramUrl),
          onCopy: () => _copyToClipboard(AppStrings.instagramUrl, 'URL Instagram'),
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildContactTile({
    IconData? icon,
    Widget? iconWidget,
    Color? iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required VoidCallback onCopy,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.contentCardDark : AppColors.contentCardLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? const Color(0x1FFFFFFF) : const Color(0x15000000),
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: isDark ? const Color(0x28FFFFFF) : const Color(0x12000000),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: iconWidget ?? Icon(icon, size: 18, color: iconColor),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onCopy,
            icon: const Icon(Icons.copy_rounded, size: 15),
            tooltip: 'Copy',
            splashRadius: 16,
          ),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.open_in_new_rounded, size: 15),
            tooltip: 'Open',
            splashRadius: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildEmailForm(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Compose Email',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 14),
        // To recipient
        Row(
          children: [
            Text(
              'To: ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                AppStrings.email,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentBlue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Subject input
        TextField(
          controller: _subjectController,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            labelText: 'Subject',
            labelStyle: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
            filled: true,
            fillColor: isDark ? const Color(0xFF28282C) : const Color(0xFFF2F2F7),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Message input
        Expanded(
          child: TextField(
            controller: _messageController,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Type your message here...',
              hintStyle: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
              ),
              filled: true,
              fillColor: isDark ? const Color(0xFF28282C) : const Color(0xFFF2F2F7),
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Send button
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: _sendEmail,
            icon: const Icon(Icons.send_rounded, size: 15),
            label: const Text('Send Email'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }
}
