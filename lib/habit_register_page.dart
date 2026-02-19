import 'package:characters/characters.dart';
import 'package:flutter/material.dart';



class HabitRegisterPage extends StatefulWidget {
  const HabitRegisterPage({super.key});

  @override
  State<HabitRegisterPage> createState() => _HabitRegisterPageState();
}

class _HabitRegisterPageState extends State<HabitRegisterPage> {
  final _habitNameCtrl = TextEditingController();
  final _flowerNameCtrl = TextEditingController();

  int _selectedColorIndex = 0;
  int _selectedIconIndex = 0;

  // 화면처럼 "파스텔 3색"
  final List<Color> _cardColors = const [
    Color(0xFFFFF3C4), // light yellow
    Color(0xFFEFFFD0), // light green
    Color(0xFFE9F2FF), // light blue
  ];

  // 선택 시 살짝 더 진하게(효과용)
  final List<Color> _cardColorsSelected = const [
    Color(0xFFFFE39A),
    Color(0xFFD8FF8A),
    Color(0xFFBFE2FF),
  ];

  final List<_IconOption> _icons = const [
    _IconOption(icon: Icons.wb_sunny_rounded, color: Color(0xFFFFC84D)),
    _IconOption(icon: Icons.water_drop_rounded, color: Color(0xFF4A90E2)),
    _IconOption(icon: Icons.cloud_rounded, color: Color(0xFFA9C8FF)),
  ];

  bool get _isValid =>
      _habitNameCtrl.text.trim().isNotEmpty &&
      _flowerNameCtrl.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _habitNameCtrl.addListener(_onChanged);
    _flowerNameCtrl.addListener(_onChanged);
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _habitNameCtrl.dispose();
    _flowerNameCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final result = {
      "habitName": _habitNameCtrl.text.trim(),
      "flowerName": _flowerNameCtrl.text.trim(),
      "cardColorIndex": _selectedColorIndex,
      "iconIndex": _selectedIconIndex,
    };

    // TODO: DB 저장/서버 호출 연결
    // 지금은 뒤로가며 결과 반환 형태로 해둠
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Stack(
        children: [
          // 배경의 옅은 스트라이프 느낌(스크린샷 분위기용)
          Positioned.fill(
            child: Row(
              children: [
                Container(width: 10, color: const Color(0xFFF6A6B8).withOpacity(0.25)),
                const Expanded(child: SizedBox()),
                Container(width: 10, color: const Color(0xFFF6A6B8).withOpacity(0.25)),
              ],
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // 상단 바 (X + 타이틀)
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.close),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            "습관 등록하기",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // 가운데 정렬 맞추기용
                    ],
                  ),
                ),

                // 폼 영역
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 16),
                    child: Column(
                      children: [
                        _SectionCard(
                          child: _LabeledTextField(
                            label: "습관명",
                            hint: "10분씩 영어공부",
                            controller: _habitNameCtrl,
                            maxLen: 10,
                          ),
                        ),
                        const SizedBox(height: 12),

                        _SectionCard(
                          child: _LabeledTextField(
                            label: "꽃 이름",
                            hint: "민들레",
                            controller: _flowerNameCtrl,
                            maxLen: 6,
                          ),
                        ),
                        const SizedBox(height: 12),

                        _SectionCard(
                          child: _LabelAndBody(
                            label: "카드 컬러 선택",
                            body: Row(
                              children: List.generate(3, (i) {
                                final selected = _selectedColorIndex == i;
                                final fillColor = selected
                                    ? _cardColorsSelected[i]
                                    : _cardColors[i];

                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: i == 2 ? 0 : 12),
                                    child: GestureDetector(
                                      onTap: () => setState(() => _selectedColorIndex = i),
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 160),
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color: fillColor,
                                          borderRadius: BorderRadius.circular(14),
                                          border: Border.all(
                                            color: selected
                                                ? const Color(0xFFB7D86A)
                                                : const Color(0xFFE7E9EE),
                                            width: selected ? 1.8 : 1.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        _SectionCard(
                          child: _LabelAndBody(
                            label: "아이콘 선택",
                            body: Row(
                              children: List.generate(_icons.length, (i) {
                                final selected = _selectedIconIndex == i;
                                final opt = _icons[i];

                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: i == 2 ? 0 : 12),
                                    child: GestureDetector(
                                      onTap: () => setState(() => _selectedIconIndex = i),
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 160),
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: selected
                                              ? const Color(0xFFF6FFE7)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                            color: selected
                                                ? const Color(0xFFB7D86A)
                                                : const Color(0xFFE7E9EE),
                                            width: selected ? 1.8 : 1.2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            opt.icon,
                                            size: 26,
                                            color: opt.color,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),
                      ],
                    ),
                  ),
                ),

                // 하단 고정 버튼
                Padding(
                  padding: EdgeInsets.fromLTRB(18, 0, 18, 12 + bottomInset),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isValid ? _submit : null,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFD7EA7E),
                        disabledBackgroundColor: const Color(0xFFD7EA7E).withOpacity(0.45),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        "미션 등록하기",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Color(0xFF1C1C1C),
                        ),
                      ),
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDEFF4)),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(0.04),
          )
        ],
      ),
      child: child,
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  const _LabeledTextField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.maxLen,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLen;

  @override
  Widget build(BuildContext context) {
    final len = controller.text.characters.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF9AA0AA))),
            const Spacer(),
            Text(
              "$len/$maxLen",
              style: const TextStyle(fontSize: 12, color: Color(0xFFB2B7C2)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLength: maxLen,
          decoration: InputDecoration(
            hintText: hint,
            counterText: "",
            hintStyle: const TextStyle(
              color: Color(0xFFD0D5DD),
              fontWeight: FontWeight.w600,
            ),
            isDense: true,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE7E9EE)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFB7D86A), width: 1.6),
            ),
          ),
          style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _LabelAndBody extends StatelessWidget {
  const _LabelAndBody({required this.label, required this.body});

  final String label;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF9AA0AA))),
        const SizedBox(height: 10),
        body,
      ],
    );
  }
}

class _IconOption {
  const _IconOption({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}
