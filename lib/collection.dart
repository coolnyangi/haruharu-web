import 'package:flutter/material.dart';

class CollectionItem {
  final String title;
  final String subtitle;
  final DateTime startDate;
  final DateTime endDate;
  final String? assetPath;

  const CollectionItem({
    required this.title,
    required this.subtitle,
    required this.startDate,
    required this.endDate,
    this.assetPath,
  });
}

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});    

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  static const String kFlowerAsset = 'assets/image/Frame 110.png';

  final List<CollectionItem> _items = [
    CollectionItem(
      title: '사용자설정꽃',
      subtitle: '',
      startDate: DateTime(2026, 12, 31),
      endDate: DateTime(2026, 12, 31),
      assetPath: kFlowerAsset,
    ),
    CollectionItem(
      title: '아자아자화이팅',
      subtitle: '일어나자마자물한잔',
      startDate: DateTime(2026, 12, 31),
      endDate: DateTime(2026, 12, 31),
      assetPath: kFlowerAsset,
    ),
    CollectionItem(
      title: '261231',
      subtitle: '',
      startDate: DateTime(2026, 12, 31),
      endDate: DateTime(2026, 12, 31),
      assetPath: kFlowerAsset,
    ),
    CollectionItem(
      title: '개나리',
      subtitle: '',
      startDate: DateTime(2026, 12, 31),
      endDate: DateTime(2026, 12, 31),
      assetPath: kFlowerAsset,
    ),
  ];

  int _navIndex = 1; // 홈=0, 컬렉션=1, 마이페이지=2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F2FF),
              Color(0xFFFFEEF5),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _Header(
                nameText: 'NAME',
                onFilterTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('필터/정렬 기능은 TODO')),
                  );
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _items.isEmpty
                    ? const _EmptyState(assetPath: kFlowerAsset)
                    : _GridState(
                        items: _items,
                        onTapItem: _openDetailSheet,
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _navIndex,
        onTap: (idx) {
          setState(() => _navIndex = idx);
          // TODO: 라우팅 연결 (pushNamed 등)
        },
      ),
    );
  }

  void _openDetailSheet(CollectionItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) {
        return _DetailSheet(
          item: item,
          onClose: () => Navigator.pop(context),
          onDownload: () {
            Navigator.pop(context);
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('다운로드 기능 연결 TODO')),
            );
          },
          onShare: () {
            Navigator.pop(context);
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('공유 기능 연결 TODO')),
            );
          },
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final String nameText;
  final VoidCallback onFilterTap;

  const _Header({
    required this.nameText,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFD7F3A3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              nameText,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onFilterTap,
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String? assetPath;
  const _EmptyState({this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F8),
                borderRadius: BorderRadius.circular(32),
              ),
              child: assetPath == null
                  ? const Icon(
                      Icons.spa_rounded,
                      size: 56,
                      color: Color(0xFF7A8B5A),
                    )
                  : Image.asset(
                      assetPath!,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.spa_rounded,
                        size: 56,
                        color: Color(0xFF7A8B5A),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            const Text(
              '아직 달성한 꽃이 없어요!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              '21일 동안 목표를 달성한 후\n다양한 꽃을 수집해보세요',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridState extends StatelessWidget {
  final List<CollectionItem> items;
  final ValueChanged<CollectionItem> onTapItem;

  const _GridState({
    required this.items,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          childAspectRatio: 0.82,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return _FlowerTile(
            title: item.title,
            assetPath: item.assetPath,
            onTap: () => onTapItem(item),
          );
        },
      ),
    );
  }
}

class _FlowerTile extends StatelessWidget {
  final String title;
  final String? assetPath;
  final VoidCallback onTap;

  const _FlowerTile({
    required this.title,
    required this.onTap,
    this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 86,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: assetPath == null
                    ? const Icon(
                        Icons.local_florist_rounded,
                        size: 40,
                        color: Color(0xFF7A8B5A),
                      )
                    : Image.asset(
                        assetPath!,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.local_florist_rounded,
                          size: 40,
                          color: Color(0xFF7A8B5A),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailSheet extends StatelessWidget {
  final CollectionItem item;
  final VoidCallback onClose;
  final VoidCallback onDownload;
  final VoidCallback onShare;

  const _DetailSheet({
    required this.item,
    required this.onClose,
    required this.onDownload,
    required this.onShare,
  });

  String _fmt(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y.$m.$day';
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 80, 16, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFF3F1E6),
              Color(0xFFEFF6E4),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.subtitle.isEmpty ? ' ' : item.subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _InfoBlock(label: '미션 시작일', value: _fmt(item.startDate)),
                    const SizedBox(width: 20),
                    _InfoBlock(label: '미션 완주일', value: _fmt(item.endDate)),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 230,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white.withOpacity(0.55),
                  ),
                  child: item.assetPath == null
                      ? const Icon(
                          Icons.spa_rounded,
                          size: 110,
                          color: Color(0xFF7A8B5A),
                        )
                      : Image.asset(
                          item.assetPath!,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.spa_rounded,
                            size: 110,
                            color: Color(0xFF7A8B5A),
                          ),
                        ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _PillButton(
                      icon: Icons.download_rounded,
                      text: '다운로드',
                      onTap: onDownload,
                    ),
                    const SizedBox(width: 10),
                    _PillButton(
                      icon: Icons.ios_share_rounded,
                      text: '공유',
                      onTap: onShare,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBlock({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _PillButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _PillButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: Colors.black87),
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.star_rounded), label: '컬렉션'),
        BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: '마이페이지'),
      ],
    );
  }
}
