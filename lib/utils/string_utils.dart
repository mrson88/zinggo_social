class StringUtils {
  static String formatK(int? num) {
    if (num == null) return "0";
    String result = "";
    if (num >= 1000) {
      result = (num / 1000).toString() + "k";
    } else {
      result = num.toString();
    }
    return result;
  }

  static String calcTimePost(DateTime createdAt) {
    final now = DateTime.now();
    if (now.year == createdAt.year) {
      final dif = now.difference(createdAt);
      final nowYear = now.year;
      final nowMonth = now.month;
      final nowDay = now.day;
      final before1Day =
      DateTime(nowYear, nowMonth, nowDay).subtract(const Duration(days: 1));

      final difMinutes = dif.inMinutes;
      if (difMinutes < 60) {
        if (difMinutes == 0) {
          return 'Hiện tại';
        }
        return '${difMinutes.toString()} phút trước';
      }

      final difHours = dif.inHours;
      if (difHours < 24) {
        return '${difHours.toString()} giờ trước';
      }

      final createdAtLocal = createdAt.toLocal();
      final hour = createdAtLocal.hour.toString().padLeft(2, '0');
      final minute = createdAtLocal.minute.toString().padLeft(2, '0');
      final time = '$hour:$minute';
      final difDays = dif.inDays;

      if (difDays < 2 && difHours < now
          .difference(before1Day)
          .inHours) {
        return 'Hôm qua lúc $time';
      }

      return '${createdAtLocal.day} tháng ${createdAtLocal.month} lúc $time';
    }

    // TODO: In the past year
    return '';
  }
}
