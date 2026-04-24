// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - NS-02: Khấu trừ và theo dõi BHXH/BHYT/BHTN
// ============================================================================

import 'package:equatable/equatable.dart';

class KhauTruBaoHiem extends Equatable {
  final String id;
  final String nguoiLaoDongId;
  final String thangNam;
  final double luongTinhBhxh;
  final double tyLeBhxhNld;
  final double tyLeBhytNld;
  final double tyLeBhtnNld;
  final double bhxhNld;
  final double bhytNld;
  final double bhtnNld;
  final double tongNld;
  final double tyLeBhxhHkd;
  final double tyLeBhytHkd;
  final double tyLeBhtnHkd;
  final double bhxhHkd;
  final double bhytHkd;
  final double bhtnHkd;
  final double tongHkd;
  final double tongPhaiNop;
  final DateTime createdAt;

  const KhauTruBaoHiem({
    required this.id,
    required this.nguoiLaoDongId,
    required this.thangNam,
    required this.luongTinhBhxh,
    required this.tyLeBhxhNld,
    required this.tyLeBhytNld,
    required this.tyLeBhtnNld,
    required this.bhxhNld,
    required this.bhytNld,
    required this.bhtnNld,
    required this.tongNld,
    required this.tyLeBhxhHkd,
    required this.tyLeBhytHkd,
    required this.tyLeBhtnHkd,
    required this.bhxhHkd,
    required this.bhytHkd,
    required this.bhtnHkd,
    required this.tongHkd,
    required this.tongPhaiNop,
    required this.createdAt,
  });

  static const double defaultBhxhNld = 0.08;
  static const double defaultBhytNld = 0.015;
  static const double defaultBhtnNld = 0.01;
  static const double defaultBhxhHkd = 0.17;
  static const double defaultBhytHkd = 0.03;
  static const double defaultBhtnHkd = 0.01;

  factory KhauTruBaoHiem.calculate({
    required String id,
    required String nguoiLaoDongId,
    required String thangNam,
    required double luongTinhBhxh,
    double tyLeBhxhNld = defaultBhxhNld,
    double tyLeBhytNld = defaultBhytNld,
    double tyLeBhtnNld = defaultBhtnNld,
    double tyLeBhxhHkd = defaultBhxhHkd,
    double tyLeBhytHkd = defaultBhytHkd,
    double tyLeBhtnHkd = defaultBhtnHkd,
  }) {
    final bhxhNld = luongTinhBhxh * tyLeBhxhNld;
    final bhytNld = luongTinhBhxh * tyLeBhytNld;
    final bhtnNld = luongTinhBhxh * tyLeBhtnNld;
    final tongNld = bhxhNld + bhytNld + bhtnNld;
    final bhxhHkd = luongTinhBhxh * tyLeBhxhHkd;
    final bhytHkd = luongTinhBhxh * tyLeBhytHkd;
    final bhtnHkd = luongTinhBhxh * tyLeBhtnHkd;
    final tongHkd = bhxhHkd + bhytHkd + bhtnHkd;
    return KhauTruBaoHiem(
      id: id,
      nguoiLaoDongId: nguoiLaoDongId,
      thangNam: thangNam,
      luongTinhBhxh: luongTinhBhxh,
      tyLeBhxhNld: tyLeBhxhNld,
      tyLeBhytNld: tyLeBhytNld,
      tyLeBhtnNld: tyLeBhtnNld,
      bhxhNld: bhxhNld,
      bhytNld: bhytNld,
      bhtnNld: bhtnNld,
      tongNld: tongNld,
      tyLeBhxhHkd: tyLeBhxhHkd,
      tyLeBhytHkd: tyLeBhytHkd,
      tyLeBhtnHkd: tyLeBhtnHkd,
      bhxhHkd: bhxhHkd,
      bhytHkd: bhytHkd,
      bhtnHkd: bhtnHkd,
      tongHkd: tongHkd,
      tongPhaiNop: tongNld + tongHkd,
      createdAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        nguoiLaoDongId,
        thangNam,
        luongTinhBhxh,
        tyLeBhxhNld,
        tyLeBhytNld,
        tyLeBhtnNld,
        bhxhNld,
        bhytNld,
        bhtnNld,
        tongNld,
        tyLeBhxhHkd,
        tyLeBhytHkd,
        tyLeBhtnHkd,
        bhxhHkd,
        bhytHkd,
        bhtnHkd,
        tongHkd,
        tongPhaiNop,
        createdAt,
      ];
}