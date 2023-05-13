class TrainUtils {
  static Map<String, String> _typeNumberTagMap = {
    "246": "FR",
    "235": "RV",
    "197": "REG",
    "196": "REG",
    "205": "EC",
    "214": "IC"
  };

  static String getCategory(String category) {
    category = category.trim();
    List<String> categories = category.split(" ");
    if (categories.length == 1) return category;
    if (categories.length == 2) return categories.first;
    categories.removeLast();
    return categories.join(" ");
  }

  static String getTypeFromNumber(String number) {
    return _typeNumberTagMap[number] ?? "REG";
  }
}
