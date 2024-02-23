class DateService {
  static getFormattedDateString(DateTime date) {
    String formattedMonth = date.month.toString().padLeft(2, '0');
    return "${date.day}.$formattedMonth.${date.year}";
  }

  static bool isInNext3DaysOrPast(DateTime dateToCheck) {
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    DateTime threeDaysFromNow =
        currentDate.add(const Duration(days: 3)); // Date 3 days from now

    // Check if target date is in the past or within the next 3 days
    return dateToCheck
            .isBefore(threeDaysFromNow.add(const Duration(days: 1))) ||
        dateToCheck.isBefore(currentDate.add(const Duration(days: 1)));
  }

  static int getDaysUntilExpiry(DateTime expiryDate) {
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    return expiryDate.difference(currentDate).inDays;
  }
}
