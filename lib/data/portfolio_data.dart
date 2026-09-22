import '../core/constants/app_assets.dart';
import '../core/constants/app_strings.dart';
import 'models/achievement_model.dart';
import 'models/project_model.dart';

class PortfolioData {
  // 6 Projects as strictly requested
  static final List<ProjectModel> projects = [
    const ProjectModel(
      id: 'eventifyweb',
      title: 'eventifyweb',
      category: 'Web Platform',
      subtitle: 'Comprehensive Event Management & Ticketing Web System',
      description:
          'Platform web terintegrasi untuk eksplorasi event, registrasi peserta, transaksi e-ticket instan, dan dasbor analitik bagi event creator. Didesain secara responsif untuk performa tinggi di browser desktop maupun mobile.',
      techStack: ['Flutter Web', 'Dart', 'REST API', 'Responsive UI', 'Provider'],
      role: 'Flutter Web Developer',
      accentColor: 0xFF0A84FF,
      githubUrl: '${AppStrings.githubUrl}/eventifyweb',
      demoUrl: AppStrings.githubUrl,
      imagePath: AppAssets.projectEventifyWeb,
      screenshots: [
        AppAssets.projectEventifyWeb,
        AppAssets.wallpaperSonoma,
        AppAssets.wallpaperSequoia,
      ],
      keyFeatures: [
        'Katalog event dinamis dengan multi-kategori dan filter interaktif',
        'Sistem reservasi tiket dan checkout online yang aman',
        'Dasbor analitik organizer untuk memantau penjualan tiket real-time',
        'Validasi tiket digital berbasis QR Code scanning',
      ],
    ),
    const ProjectModel(
      id: 'eventifymobile',
      title: 'eventifymobile',
      category: 'Mobile Application',
      subtitle: 'Native-feel Event Companion & QR Ticket Scanner',
      description:
          'Aplikasi mobile pendamping event yang mempermudah pengunjung menemukan konser, seminar, dan festival terdekat, menyimpan e-ticket ke dalam dompet digital aplikasi, serta dilengkapi scanner QR ultra-cepat bagi panitia di pintu masuk.',
      techStack: ['Flutter', 'Dart', 'QR Scanner', 'Camera', 'Clean Architecture'],
      role: 'Mobile App Developer',
      accentColor: 0xFF5856D6,
      githubUrl: '${AppStrings.githubUrl}/eventifymobile',
      demoUrl: AppStrings.githubUrl,
      imagePath: AppAssets.projectEventifyMobile,
      screenshots: [
        AppAssets.projectEventifyMobile,
        AppAssets.wallpaperSequoia,
        AppAssets.wallpaperMacDark,
      ],
      keyFeatures: [
        'Tiket offline dengan QR Code terenkripsi',
        'Pemindai tiket cepat dengan indikator audio dan visual validasi',
        'Notifikasi pengingat jadwal acara secara push notification',
        'Mode gelap & terang adaptif sesuai preferensi perangkat',
      ],
    ),
    const ProjectModel(
      id: 'pelarikalcer',
      title: 'pelarikalcer',
      category: 'Mobile & IoT',
      subtitle: 'Modern Running Community, GPS & Activity Tracker',
      description:
          'Aplikasi khusus komunitas lari urban yang mengombinasikan pelacakan rute GPS real-time, metrik performa (pace, jarak, estimasi kalori, cadence), papan peringkat mingguan, dan feed sosial interaktif untuk berbagi pencapaian lari.',
      techStack: ['Flutter', 'Dart', 'GPS Tracking', 'Google Maps API', 'Sensors'],
      role: 'Flutter Developer — GPS & IoT',
      accentColor: 0xFF30D158,
      githubUrl: '${AppStrings.githubUrl}/pelarikalcer',
      demoUrl: AppStrings.githubUrl,
      imagePath: AppAssets.projectPelariKalcer,
      screenshots: [
        AppAssets.projectPelariKalcer,
        AppAssets.wallpaperMacDark,
        AppAssets.wallpaperSequoia,
      ],
      keyFeatures: [
        'Live tracking rute lari dengan peta interaktif dan penanda waypoint',
        'Kalkulasi metrik lari otomatis (Pace, Split Kilometer, Heart Rate)',
        'Leaderboard komunitas untuk memacu semangat antar pelari',
        'Fitur pembuatan event lari bersama (Virtual & On-ground Run)',
      ],
    ),
    const ProjectModel(
      id: 'tokokita',
      title: 'tokokita',
      category: 'E-Commerce',
      subtitle: 'End-to-End Modern E-Commerce Marketplace Solution',
      description:
          'Solusi marketplace belanja online modern dengan antarmuka cepat, manajemen varian produk lengkap, keranjang belanja dinamis, kalkulator ongkos kirim multi-kurir, dan simulasi pembayaran multi-channel.',
      techStack: ['Flutter', 'Dart', 'State Management', 'REST API', 'Payment Flow'],
      role: 'Full-Stack Flutter Developer',
      accentColor: 0xFFFF9500,
      githubUrl: '${AppStrings.githubUrl}/tokokita',
      demoUrl: AppStrings.githubUrl,
      imagePath: AppAssets.projectTokoKita,
      screenshots: [
        AppAssets.projectTokoKita,
        AppAssets.wallpaperSonoma,
        AppAssets.wallpaperMacDark,
      ],
      keyFeatures: [
        'Pencarian produk cerdas dengan filter harga, rating, dan kategori',
        'Manajemen keranjang belanja dengan sinkronisasi instan',
        'Kalkulasi estimasi ongkos kirim otomatis berdasarkan alamat tujuan',
        'Halaman pelacakan status pesanan dari proses dikemas hingga sampai',
      ],
    ),
    const ProjectModel(
      id: 'properti24',
      title: 'properti24',
      category: 'Real Estate',
      subtitle: 'Property Listing, Virtual Showcase & Mortgage Calculator',
      description:
          'Platform jual-beli dan sewa properti terkemuka. Menyajikan listing rumah, apartemen, dan tanah dengan detail komprehensif, tur virtual foto sudut lebar, simulasi kalkulator KPR interaktif, dan penghubung langsung ke agen resmi via WhatsApp.',
      techStack: ['Flutter', 'Dart', 'Geolocation', 'Form Calculation', 'UI Kit'],
      role: 'UI/UX & Flutter Developer',
      accentColor: 0xFF5E5CE6,
      githubUrl: '${AppStrings.githubUrl}/properti24',
      demoUrl: AppStrings.githubUrl,
      imagePath: AppAssets.projectProperti24,
      screenshots: [
        AppAssets.projectProperti24,
        AppAssets.wallpaperSonoma,
        AppAssets.wallpaperSequoia,
      ],
      keyFeatures: [
        'Kalkulator simulasi KPR interaktif (bunga flat & floating, tenor, DP)',
        'Pencarian properti berdasarkan radius radius lokasi sekitar pengguna',
        'Galeri visual beresolusi tinggi dengan navigasi swipe intuitif',
        'Integrasi tombol satu-klik kontak agen properti melalui pesan instan',
      ],
    ),
    const ProjectModel(
      id: 'kimikosweets',
      title: 'kimikosweets',
      category: 'Food & Beverage',
      subtitle: 'Artisan Bakery Catalog & Custom Dessert Ordering App',
      description:
          'Aplikasi pemesanan dessert manis dan kue artisan premium dengan pengalaman visual yang memanjakan mata (aesthetic pastel UI), animasi mikro yang halus, kustomisasi topping kue khusus acara, dan sistem review pelanggan.',
      techStack: ['Flutter', 'Dart', 'Micro-Animations', 'Responsive Layout', 'Cart Flow'],
      role: 'Front-End Developer (Flutter)',
      accentColor: 0xFFFF2D55,
      githubUrl: '${AppStrings.githubUrl}/kimikosweets',
      demoUrl: AppStrings.githubUrl,
      imagePath: AppAssets.projectKimikoSweets,
      screenshots: [
        AppAssets.projectKimikoSweets,
        AppAssets.wallpaperSequoia,
        AppAssets.wallpaperSonoma,
      ],
      keyFeatures: [
        'Katalog pastry & cake dengan animasi transisi hero yang memukau',
        'Customizer kue ulang tahun (pilih base cake, filling, pesan ucapan)',
        'Jadwal pengiriman fleksibel (same-day delivery & pre-order calendar)',
        'Program loyalitas voucher diskon dan reward pelanggan setia',
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
    'Mobile & Front-End': [
      'Flutter',
      'Dart',
      'State Management (Provider, Bloc)',
      'Responsive Web Design',
      'HTML5 & CSS3',
      'JavaScript ES6+',
    ],
    'Architecture & Back-End': [
      'Clean Architecture',
      'RESTful APIs',
      'JSON Serialization',
      'Firebase & Supabase',
      'Java & OOP',
      'Database (SQL & NoSQL)',
    ],
    'Tools & Workflow': [
      'Git & GitHub',
      'VS Code & Android Studio',
      'Figma & UI Prototyping',
      'Postman',
      'CI/CD Workflows',
      'macOS & Linux Terminal',
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
