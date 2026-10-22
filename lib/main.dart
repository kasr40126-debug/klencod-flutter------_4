
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

void main() {
  runApp(const MuslimEncyclopedia());
}

const Color green = Color(0xFF073B32);
const Color gold = Color(0xFFE3BD69);
const Color cream = Color(0xFFF7F4EC);

class MuslimEncyclopedia extends StatelessWidget {
  const MuslimEncyclopedia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'موسوعة المسلم الشاملة',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        appBarTheme: const AppBarTheme(
          backgroundColor: green,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      ('القرآن الكريم', Icons.menu_book, const QuranPage()),
      ('الأذكار اليومية', Icons.wb_sunny_outlined, const AzkarPage()),
      ('الأدعية الإسلامية', Icons.volunteer_activism, const DuaPage()),
      ('المسبحة الإلكترونية', Icons.radio_button_checked, const TasbihPage()),
      ('أركان الإسلام', Icons.mosque, const InfoPage()),
      ('أخلاق المسلم', Icons.favorite, const InfoPage()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('موسوعة المسلم الشاملة')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              children: [
                Icon(Icons.mosque, size: 55, color: gold),
                SizedBox(height: 12),
                Text(
                  'موسوعة المسلم الشاملة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'القرآن والأذكار والأدعية وعلوم الإسلام',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sections.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.12,
            ),
            itemBuilder: (context, index) {
              final item = sections[index];
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => item.$3),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: gold),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.$2, size: 38, color: green),
                      const SizedBox(height: 12),
                      Text(
                        item.$1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: green,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'اللهم علّمنا ما ينفعنا وانفعنا بما علّمتنا',
            textAlign: TextAlign.center,
            style: TextStyle(color: green, fontSize: 17),
          ),
        ],
      ),
    );
  }
}

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('القرآن الكريم')),
      body: ListView.builder(
        itemCount: 114,
        itemBuilder: (context, index) {
          final surah = index + 1;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: green,
              child: Text(
                '$surah',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              quran.getSurahNameArabic(surah),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${quran.getVerseCount(surah)} آية',
              textAlign: TextAlign.right,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SurahPage(surah: surah),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SurahPage extends StatelessWidget {
  final int surah;

  const SurahPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final count = quran.getVerseCount(surah);

    return Scaffold(
      appBar: AppBar(
        title: Text(quran.getSurahNameArabic(surah)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          if (surah != 1 && surah != 9)
            const Text(
              'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: green,
                height: 2,
              ),
            ),
          const Divider(color: gold),
          for (int verse = 1; verse <= count; verse++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                quran.getVerse(
                  surah,
                  verse,
                  verseEndSymbol: true,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 25,
                  height: 2,
                  color: green,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AzkarPage extends StatelessWidget {
  const AzkarPage({super.key});

  static const azkar = [
    ('أذكار الصباح', [
      'أصبحنا وأصبح الملك لله، والحمد لله.',
      'اللهم بك أصبحنا وبك أمسينا وبك نحيا وبك نموت وإليك النشور.',
      'رضيت بالله ربًا، وبالإسلام دينًا، وبمحمد صلى الله عليه وسلم نبيًا.',
      'سبحان الله وبحمده.',
      'أستغفر الله وأتوب إليه.',
      'اللهم صل وسلم على نبينا محمد.',
    ]),
    ('أذكار المساء', [
      'أمسينا وأمسى الملك لله، والحمد لله.',
      'اللهم بك أمسينا وبك أصبحنا وبك نحيا وبك نموت وإليك المصير.',
      'رضيت بالله ربًا، وبالإسلام دينًا، وبمحمد صلى الله عليه وسلم نبيًا.',
      'سبحان الله وبحمده.',
      'أستغفر الله وأتوب إليه.',
    ]),
    ('أذكار بعد الصلاة', [
      'أستغفر الله، أستغفر الله، أستغفر الله.',
      'اللهم أنت السلام ومنك السلام تباركت يا ذا الجلال والإكرام.',
      'سبحان الله.',
      'الحمد لله.',
      'الله أكبر.',
    ]),
    ('أذكار النوم', [
      'باسمك اللهم أموت وأحيا.',
      'اللهم قني عذابك يوم تبعث عبادك.',
      'سبحان الله، والحمد لله، والله أكبر.',
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الأذكار اليومية')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          for (final section in azkar)
            Card(
              color: Colors.white,
              child: ExpansionTile(
                title: Text(
                  section.$1,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),
                children: [
                  for (final zikr in section.$2)
                    ListTile(
                      title: Text(
                        zikr,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.8,
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class DuaPage extends StatelessWidget {
  const DuaPage({super.key});

  static const duas = [
    (
      'دعاء الاستغفار',
      'ربنا ظلمنا أنفسنا وإن لم تغفر لنا وترحمنا لنكونن من الخاسرين.'
    ),
    (
      'دعاء الدنيا والآخرة',
      'ربنا آتنا في الدنيا حسنة وفي الآخرة حسنة وقنا عذاب النار.'
    ),
    (
      'دعاء العلم',
      'رب زدني علمًا.'
    ),
    (
      'دعاء الوالدين',
      'رب ارحمهما كما ربياني صغيرًا.'
    ),
    (
      'دعاء تفريج الهم',
      'لا إله إلا أنت سبحانك إني كنت من الظالمين.'
    ),
    (
      'دعاء الثبات',
      'ربنا لا تزغ قلوبنا بعد إذ هديتنا وهب لنا من لدنك رحمة إنك أنت الوهاب.'
    ),
    (
      'دعاء المغفرة',
      'رب اغفر لي ولوالدي وللمؤمنين يوم يقوم الحساب.'
    ),
    (
      'دعاء التيسير',
      'رب اشرح لي صدري ويسر لي أمري.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الأدعية الإسلامية')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: duas.length,
        itemBuilder: (context, index) {
          final dua = duas[index];
          return Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    dua.$1,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SelectableText(
                    dua.$2,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 21,
                      height: 1.8,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      tooltip: 'نسخ الدعاء',
                      icon: const Icon(Icons.copy, color: green),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'يمكن تحديد الدعاء ونسخه من النص.',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TasbihPage extends StatefulWidget {
  const TasbihPage({super.key});

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المسبحة الإلكترونية')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
              style: TextStyle(fontSize: 25, color: green),
            ),
            const SizedBox(height: 25),
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 65,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                foregroundColor: Colors.white,
                minimumSize: const Size(180, 60),
              ),
              onPressed: () => setState(() => count++),
              child: const Text('سبّح', style: TextStyle(fontSize: 22)),
            ),
            TextButton(
              onPressed: () => setState(() => count = 0),
              child: const Text('تصفير العداد'),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('معلومات إسلامية')),
      body: const ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'أركان الإسلام خمسة:',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: green,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '1. شهادة أن لا إله إلا الله وأن محمدًا رسول الله.\n'
            '2. إقامة الصلاة.\n'
            '3. إيتاء الزكاة.\n'
            '4. صوم رمضان.\n'
            '5. حج البيت لمن استطاع إليه سبيلًا.',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 20, height: 2),
          ),
          Divider(),
          Text(
            'من أخلاق المسلم: الصدق، والأمانة، والرحمة، '
            'والإحسان إلى الوالدين، وحفظ حقوق الناس.',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 20, height: 1.8),
          ),
        ],
      ),
    );
  }
}