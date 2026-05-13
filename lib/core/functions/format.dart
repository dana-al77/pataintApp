String formatDate(String? date) {
  if (date == null) return "";

  final d = DateTime.parse(date);
  return "${d.day}/${d.month}/${d.year}";
}