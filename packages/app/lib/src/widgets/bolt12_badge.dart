import 'package:flutter/material.dart';

/// A compact capability marker for the still-uncommon BOLT12 payout path.
class Bolt12Badge extends StatelessWidget {
  const Bolt12Badge({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final iconSize = compact ? 10.0 : 12.0;
    final fontSize = compact ? 9.0 : 10.0;

    return Semantics(
      label: 'BOLT12',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6 : 8,
          vertical: compact ? 2 : 3,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFA500), Color(0xFF008000)],
          ),
          borderRadius: BorderRadius.circular(999),
          //border: Border.all(color: const Color(0xCCFFFFFF), width: 0.7),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF004000).withValues(alpha: 0.38),
              blurRadius: compact ? 6 : 9,
              spreadRadius: compact ? 0 : 0.5,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bolt_rounded, size: iconSize, color: Colors.white),
            const SizedBox(width: 2),
            Text(
              'BOLT12',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                height: 1,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
