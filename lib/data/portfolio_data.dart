import '../core/constants/app_assets.dart';
import '../core/constants/app_strings.dart';
import 'models/achievement_model.dart';
import 'models/project_model.dart';

class PortfolioData {
  // 6 Projects as strictly requested
  static final List<ProjectModel> projects = [
    const ProjectModel(
      id: 'eventifyweb',
      title: 'Eventify Web',
      category: 'Web Platform',
      subtitle: 'Admin Dashboard Management untuk Platform Eventify',
      description:
          'Dashboard manajemen berbasis web untuk platform Eventify — mengelola organizer, user, event, tiket, kehadiran, keuangan, laporan, notifikasi, keamanan, dan pengaturan sistem. Dibangun dengan React 19, TypeScript, Vite, Tailwind CSS bergaya Neobrutalism, serta Axios untuk komunikasi dengan backend API.',
      techStack: [
        'React',
        'TypeScript',
        'Vite',
        'Tailwind CSS',
        'Axios',
        'Recharts',
        'React Router',
      ],
      role: 'Front-End Developer (React & TypeScript)',
      accentColor: 0xFF0A84FF,
      githubUrl: '${AppStrings.githubUrl}/Eventify-Web',
      demoUrl: AppStrings.githubUrl,
      logoPath: AppAssets.projectEventifyLogo,
      imagePath: AppAssets.projectEventifyWeb,
      screenshots: [
        AppAssets.projectEventifyWeb,
        AppAssets.projectEventifyWeb2,
        AppAssets.projectEventifyWeb3,
      ],
      keyFeatures: [
        'Dashboard statistik pendapatan, tiket terjual, kehadiran, dan grafik (Recharts)',
        'Manajemen organiser, user, event, dan approval status (publish/draft/ended)',
        'Modul tiket & check-in peserta, keuangan/monitoring order, dan laporan kehadiran',
        'Broadcast notifikasi & tiket support, audit log, sesi login, dan role sub-admin',
      ],
    ),
    const ProjectModel(
      id: 'eventifymobile',
      title: 'Eventify Mobile',
      category: 'Mobile Application',
      subtitle: 'Event Discovery, Booking & QR Check-In Companion',
      description:
          'Aplikasi mobile pendamping platform Eventify untuk menemukan event, booking & pembayaran tiket, menyimpan e-ticket dengan kode QR, serta scanner check-in cepat bagi panitia di pintu masuk. Dibangun dengan Flutter berarsitektur Feature-First dan Riverpod.',
      techStack: [
        'Flutter',
        'Riverpod',
        'Dio',
        'go_router',
        'QR Code',
        'Clean Architecture',
        'Firebase',
      ],
      role: 'Mobile App Developer (Flutter)',
      accentColor: 0xFF5856D6,
      githubUrl: '${AppStrings.githubUrl}/Eventify_Mobile',
      demoUrl: AppStrings.githubUrl,
      logoPath: AppAssets.projectEventifyLogo,
      imagePath: AppAssets.projectEventifyMobile,
      screenshots: [
        AppAssets.projectEventifyMobile,
        AppAssets.projectEventifyMobile2,
        AppAssets.projectEventifyMobile3,
      ],
      keyFeatures: [
        'Autentikasi login, register, dan Google Sign-In dengan secure storage',
        'Eksplorasi event, halaman detail, booking & checkout pembayaran tiket',
        'E-tiket digital dengan QR code (qr_flutter) dan scanner check-in (mobile_scanner)',
        'Dashboard organizer: manajemen CRUD event, tier, dan banner',
      ],
    ),
    const ProjectModel(
      id: 'pelarikalcer',
      title: 'Pelari Kalcer',
      category: 'Mobile Application',
      subtitle: 'Running Community dengan Realtime Leaderboard',
      description:
          'Aplikasi Android untuk komunitas lari yang menampilkan papan peringkat komunitas secara realtime, fitur add friends, dan pelacakan aktivitas lari. Dibangun dengan Kotlin, Jetpack Compose, Material 3, dan Supabase (Auth, PostgreSQL, Realtime) berarsitektur MVVM & Clean Architecture.',
      techStack: [
        'Kotlin',
        'Jetpack Compose',
        'Material 3',
        'Supabase',
        'MVVM',
        'Clean Architecture',
        'Coroutines & Flow',
      ],
      role: 'Android Developer (Kotlin & Compose)',
      accentColor: 0xFF30D158,
      githubUrl: '${AppStrings.githubUrl}/PelariKalcer',
      demoUrl: AppStrings.githubUrl,
      logoPath: AppAssets.projectPelariKalcerLogo,
      imagePath: AppAssets.projectPelariKalcer,
      screenshots: [
        AppAssets.projectPelariKalcer,
        AppAssets.projectPelariKalcer2,
        AppAssets.projectPelariKalcer3,
      ],
      keyFeatures: [
        'Papan peringkat komunitas realtime dengan Supabase Realtime',
        'Add friends dan pantau progres lari antar pelari',
        'Arsitektur MVVM + Clean Architecture dengan Coroutines & Flow',
        'Autentikasi dan penyimpanan data via Supabase (Auth, PostgreSQL)',
      ],
    ),
    const ProjectModel(
      id: 'tokokita',
      title: 'TokoKita',
      category: 'E-Commerce',
      subtitle: 'Marketplace dengan Chat Realtime & Multi-Role Dashboard',
      description:
          'Platform e-commerce lengkap dengan dashboard multi-role (user, admin, superadmin), layanan chat realtime berbasis Node.js, wishlist, voucher, flash sale, verifikasi OTP, review produk, keranjang & pesanan. Backend dibangun dengan PHP & MySQL, notifikasi email via PHPMailer.',
      techStack: [
        'PHP',
        'MySQL',
        'Node.js',
        'JavaScript',
        'WebSocket',
        'PHPMailer',
        'REST API',
      ],
      role: 'Full-Stack Web Developer (PHP & Node.js)',
      accentColor: 0xFFFF9500,
      githubUrl: '${AppStrings.githubUrl}/tokokita',
      demoUrl: AppStrings.githubUrl,
      logoPath: AppAssets.projectTokoKitaLogo,
      imagePath: AppAssets.projectTokoKita,
      screenshots: [
        AppAssets.projectTokoKita,
        AppAssets.projectTokoKita2,
        AppAssets.projectTokoKita3,
      ],
      keyFeatures: [
        'Dashboard multi-role: user, admin, dan superadmin',
        'Layanan chat realtime berbasis Node.js',
        'Wishlist, voucher, flash sale, verifikasi OTP, dan review produk',
        'Manajemen keranjang, pesanan, dan notifikasi email (PHPMailer)',
      ],
    ),
    const ProjectModel(
      id: 'properti24',
      title: 'Properti24',
      category: 'Web Platform',
      subtitle: 'Digital Asset & Booking Management System',
      description:
          'Sistem manajemen aset digital berbasis web: katalog aset dengan filter, cart multi-peminjaman, dokumentasi bukti foto via kamera WebRTC, auto-expiry booking, laporan return & kerusakan, alur perbaikan workshop, hingga dashboard KPI admin. Dibangun dengan Java Spring Boot 3.3.4, Vaadin Flow 24.5.1, dan MySQL.',
      techStack: [
        'Java',
        'Spring Boot',
        'Vaadin Flow',
        'MySQL',
        'WebRTC',
        'OTP Email',
      ],
      role: 'Full-Stack Developer (Java & Vaadin)',
      accentColor: 0xFF5E5CE6,
      githubUrl: '${AppStrings.githubUrl}/properti24',
      demoUrl: AppStrings.githubUrl,
      logoPath: AppAssets.projectProperti24Logo,
      imagePath: AppAssets.projectProperti24,
      screenshots: [
        AppAssets.projectProperti24,
        AppAssets.projectProperti242,
        AppAssets.projectProperti243,
      ],
      keyFeatures: [
        'Katalog aset dengan filter, cart multi-peminjaman, dan approval booking',
        'Kamera berbasis WebRTC untuk dokumentasi bukti foto kondisi aset',
        'Auto-expiry booking, return & damage report, serta alur perbaikan workshop',
        'Dashboard admin KPI, CRUD aset, user management, dan auth OTP email',
      ],
    ),
    const ProjectModel(
      id: 'kimikosweets',
      title: 'Kimiko Sweet',
      category: 'Food & Beverage',
      subtitle: 'Choux Pastry Ordering dengan Realtime Order Tracking',
      description:
          'Aplikasi pemesanan choux pastry yang menampilkan katalog 13 varian, keranjang, checkout, validasi pickup, dan status pesanan realtime. Didesain offline-first memanfaatkan LocalStorage serta dibangun dengan Next.js 14, TypeScript, Tailwind CSS (Neobrutalism pastel), dan Firebase (Firestore, Auth, Hosting).',
      techStack: [
        'Next.js',
        'TypeScript',
        'Tailwind CSS',
        'Firebase',
        'LocalStorage',
        'Offline-First',
      ],
      role: 'Full-Stack Web Developer (Next.js)',
      accentColor: 0xFFFF2D55,
      githubUrl: '${AppStrings.githubUrl}/KimikoSweet',
      demoUrl: AppStrings.githubUrl,
      logoPath: AppAssets.projectKimikoLogo,
      imagePath: AppAssets.projectKimikoSweets,
      screenshots: [
        AppAssets.projectKimikoSweets,
        AppAssets.projectKimikoSweets2,
        AppAssets.projectKimikoSweets3,
      ],
      keyFeatures: [
        'Katalog 13 varian choux pastry dengan mode offline (LocalStorage)',
        'Keranjang, checkout, dan validasi pickup order',
        'Status pesanan realtime dengan Firebase dan dinding review pelanggan',
        'Dashboard admin: rekap produksi dan pendapatan',
      ],
    ),
  ];

  // Achievements as requested
  static final List<AchievementModel> achievements = [
    // a. Akademik
    const AchievementModel(
      id: 'lks_itssb_2026',
      title: 'LKS ITSSB 3rd Place in Jakarta Timur 2026',
      category: AchievementCategory.akademik,
      organizer: 'Lomba Kompetensi Siswa (LKS) Jakarta Timur',
      year: '2026',
      badgeText: 'Juara 3 (3rd Place)',
      description:
          'Meraih Juara 3 pada kompetisi bergengsi IT Software Solution for Business (ITSSB) tingkat wilayah Jakarta Timur. Menguji kemahiran membangun arsitektur perangkat lunak bisnis berskala penuh, manajemen database, dan pemecahan studi kasus kompleks di bawah batasan waktu ketat.',
      certificatePath: AppAssets.achLksItssb,
      skills: ['Software Architecture', 'Database Design', 'Problem Solving', 'Enterprise Solutions'],
    ),
    const AchievementModel(
      id: 'toeic_895',
      title: 'TOEIC Score 895 2026',
      category: AchievementCategory.akademik,
      organizer: 'Educational Testing Service (ETS)',
      year: '2026',
      badgeText: 'Skor 895 / 990 (Professional Working)',
      description:
          'Pencapaian skor resmi TOEIC (Test of English for International Communication) sebesar 895 dari total 990. Menunjukkan penguasaan bahasa Inggris tingkat profesional untuk komunikasi teknis internasional, dokumentasi arsitektur perangkat lunak, dan kolaborasi global.',
      certificatePath: AppAssets.achToeic,
      skills: ['English Proficiency', 'International Communication', 'Technical Documentation'],
    ),
    const AchievementModel(
      id: 'dicoding_web_2026',
      title: 'Sertifikat Website dari Dicoding 2026',
      category: AchievementCategory.akademik,
      organizer: 'Dicoding Indonesia',
      year: '2026',
      badgeText: 'Certified Web Developer',
      description:
          'Sertifikasi kelulusan kurikulum pengembangan web modern dari platform edukasi teknologi Dicoding Indonesia. Menguasai standar web W3C, semantic HTML5, CSS3 Grid/Flexbox modern, responsive web design, dan web accessibility (a11y).',
      certificatePath: AppAssets.achDicodingWeb,
      skills: ['HTML5', 'CSS3', 'Responsive Design', 'Web Accessibility', 'Front-End Standards'],
    ),
    const AchievementModel(
      id: 'dicoding_js_2026',
      title: 'Sertifikat JS dari Dicoding 2026',
      category: AchievementCategory.akademik,
      organizer: 'Dicoding Indonesia',
      year: '2026',
      badgeText: 'Certified JavaScript Specialist',
      description:
          'Sertifikasi kompetensi pemrograman JavaScript mendalam dari Dicoding Indonesia. Meliputi fundamental ECMAScript modern, asynchronous programming (Promises & async/await), Object-Oriented Programming (OOP), Functional Programming, modulasi, dan unit testing kode JS.',
      certificatePath: AppAssets.achDicodingJs,
      skills: ['JavaScript ES6+', 'Asynchronous JS', 'OOP', 'Functional Programming', 'Node.js Basics'],
    ),
    const AchievementModel(
      id: 'java_foundation_2026',
      title: 'Java Foundation Class 2026',
      category: AchievementCategory.akademik,
      organizer: 'Oracle Academy Partner / Enterprise Training',
      year: '2026',
      badgeText: 'Certified Java Foundations',
      description:
          'Sertifikat kelulusan Java Foundation Class yang memvalidasi penguasaan konsep dasar pemrograman berorientasi objek (OOP), enkapsulasi, polimorfisme, inheritance, struktur data, algoritma sorting/searching, serta penanganan exception di ekosistem Java.',
      certificatePath: AppAssets.achJavaFoundation,
      skills: ['Java Core', 'Object-Oriented Programming', 'Data Structures', 'Algorithms', 'Exception Handling'],
    ),

    // b. Partisipan
    const AchievementModel(
      id: 'ksr_mtk_2025',
      title: 'KSR 2025 Bidang MTK',
      category: AchievementCategory.partisipan,
      organizer: 'Kompetisi Sains Ruangguru (KSR)',
      year: '2025',
      badgeText: 'Peserta Kompetisi Sains Nasional',
      description:
          'Partisipasi aktif dalam ajang Kompetisi Sains Ruangguru tingkat nasional pada bidang studi Matematika. Melatih ketajaman logika komputasional, penalaran deduktif, kalkulus, kombinatorika, dan pemecahan soal analitis tingkat lanjut.',
      certificatePath: AppAssets.achKsrMtk,
      skills: ['Mathematics', 'Logic & Analytical Thinking', 'Algorithm Analysis', 'Combinatorics'],
    ),
    const AchievementModel(
      id: 'unicef_bootcamp_2023',
      title: 'Bootcamp Innovation 2023 Generasi Terampil (UNICEF)',
      category: AchievementCategory.partisipan,
      organizer: 'UNICEF & Generasi Terampil Indonesia',
      year: '2023',
      badgeText: 'Alumni Bootcamp Inovasi',
      description:
          'Mengikuti serangkaian program intensif Bootcamp Inovasi Generasi Terampil yang diselenggarakan oleh UNICEF. Mengembangkan kemampuan human-centered design thinking, prototyping solusi teknologi berbasis dampak sosial, dan kepemimpinan tim kolaboratif.',
      certificatePath: AppAssets.achUnicefBootcamp,
      skills: ['Design Thinking', 'Social Innovation', 'Team Leadership', 'Prototyping', 'Collaboration'],
    ),
    const AchievementModel(
      id: 'idx_market_2026',
      title: 'Kegiatan Pasar Modal di IDX 2026',
      category: AchievementCategory.partisipan,
      organizer: 'Bursa Efek Indonesia (Indonesia Stock Exchange - IDX)',
      year: '2026',
      badgeText: 'Peserta Edukasi Pasar Modal Terstruktur',
      description:
          'Mengikuti kegiatan literasi dan lokakarya pasar modal terakreditasi di Bursa Efek Indonesia (IDX). Memperdalam pemahaman ekosistem finansial nasional, mekanisme perdagangan saham, analisis teknikal & fundamental, serta manajemen risiko investasi cerdas.',
      certificatePath: AppAssets.achIdxMarket,
      skills: ['Capital Market Literacy', 'Financial Analysis', 'Stock Exchange Mechanism', 'Risk Management'],
    ),
    const AchievementModel(
      id: 'unj_literasi_2024',
      title: 'Literasi Numerasi UNJ 2024',
      category: AchievementCategory.partisipan,
      organizer: 'Universitas Negeri Jakarta (UNJ)',
      year: '2024',
      badgeText: 'Peserta Program Literasi Numerasi',
      description:
          'Partisipasi dalam seminar & lokakarya Penguatan Literasi Numerasi yang diselenggarakan oleh Universitas Negeri Jakarta. Memperkuat kemampuan membaca data kuantitatif, interpretasi visualisasi grafik, dan pengambilan keputusan berbasis data empiris.',
      certificatePath: AppAssets.achUnjLiterasi,
      skills: ['Numerical Literacy', 'Data Interpretation', 'Quantitative Reasoning', 'Critical Thinking'],
    ),
  ];

  // Technical skills
  static const Map<String, List<String>> skills = {
    'Technical Skill': [
      'C# / .NET',
      'Kotlin',
      'Flutter',
      'Dart',
      'Web Dev (HTML, CSS, JS)',
      'REST API & SQL Database',
      'Git & Version Control',
      'Microsoft Office',
      'PHP',
      'Java',
    ],
    'Soft Skill': [
      'Problem Solving & Logic',
      'Teamwork & Collaboration',
      'Time Management',
      'Fast Learner & Adaptability',
    ],
    'Languages': [
      'Bahasa Indonesia (Native)',
      'English',
    ],
  };

  // Quick stats
  static const List<Map<String, String>> stats = [
    {'value': '6+', 'label': 'Featured Projects'},
    {'value': '9+', 'label': 'Achievements & Honors'},
    {'value': '895', 'label': 'TOEIC Score'},
    {'value': '100%', 'label': 'Dedication to Quality'},
  ];
}
