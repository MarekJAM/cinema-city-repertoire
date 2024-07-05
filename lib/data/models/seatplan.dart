final class Seatplan {
  final int totalSeats;

  Seatplan({required this.totalSeats});

  factory Seatplan.fromJson(Map<String, dynamic> json) {
    final rows = json['S']['1']['G']['0']['R'] as Map<String, dynamic>;
    int seatCount = 0;
    for (final row in rows.entries) {
      seatCount += (row.value['S'] as Map<String, dynamic>).length;  
    }
    return Seatplan(
      totalSeats: seatCount,
    );
  }
}