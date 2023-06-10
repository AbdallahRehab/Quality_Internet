import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MapsAppBar extends StatefulWidget {
  const MapsAppBar({
    Key? key,
    required this.onBackPress,
    required this.text,
    required this.onFieldSubmitted,
  }) : super(key: key);

  final Function onBackPress;
  final String text;
  final Function(String query) onFieldSubmitted;

  @override
  State<MapsAppBar> createState() => _MapsAppBarState();
}

class _MapsAppBarState extends State<MapsAppBar> {
  bool isExpanded = false;
  final TextEditingController search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Stack(
        children: [
          Row(
            children: [
              if (!isExpanded)
                GestureDetector(
                  onTap: () => widget.onBackPress(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              if (!isExpanded) const Spacer(),
              if (!isExpanded)
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              if (!isExpanded) const Spacer(),
              if (!isExpanded) const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }

  final outlineBorder = const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(
      Radius.circular(14),
    ),
  );

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}
