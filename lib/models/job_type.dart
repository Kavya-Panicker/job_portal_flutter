enum EmploymentType {
  fullTime,
  partTime,
  freelance,
  internship,
  contract,
  remote
}

class JobType {
  final EmploymentType type;
  final bool isRemote;
  final bool isHybrid;
  final int? hoursPerWeek;
  final String? contractDuration;
  final Map<String, String> localizedNames;

  JobType({
    required this.type,
    required this.isRemote,
    this.isHybrid = false,
    this.hoursPerWeek,
    this.contractDuration,
    required this.localizedNames,
  });

  String getLocalizedName(String languageCode) {
    return localizedNames[languageCode] ?? localizedNames['en'] ?? type.toString();
  }

  static Map<String, String> getDefaultLocalizedNames(EmploymentType type) {
    return {
      'en': _getEnglishName(type),
      'hi': _getHindiName(type),
      'gu': _getGujaratiName(type),
      'ml': _getMalayalamName(type),
    };
  }

  static String _getEnglishName(EmploymentType type) {
    switch (type) {
      case EmploymentType.fullTime:
        return 'Full-Time';
      case EmploymentType.partTime:
        return 'Part-Time';
      case EmploymentType.freelance:
        return 'Freelance';
      case EmploymentType.internship:
        return 'Internship';
      case EmploymentType.contract:
        return 'Contract';
      case EmploymentType.remote:
        return 'Remote';
    }
  }

  static String _getHindiName(EmploymentType type) {
    switch (type) {
      case EmploymentType.fullTime:
        return 'पूर्णकालिक';
      case EmploymentType.partTime:
        return 'अंशकालिक';
      case EmploymentType.freelance:
        return 'फ्रीलांस';
      case EmploymentType.internship:
        return 'इंटर्नशिप';
      case EmploymentType.contract:
        return 'अनुबंध';
      case EmploymentType.remote:
        return 'रिमोट';
    }
  }

  static String _getGujaratiName(EmploymentType type) {
    switch (type) {
      case EmploymentType.fullTime:
        return 'પૂર્ણ સમય';
      case EmploymentType.partTime:
        return 'પાર્ટ ટાઈમ';
      case EmploymentType.freelance:
        return 'ફ્રીલાન્સ';
      case EmploymentType.internship:
        return 'ઇન્ટર્નશિપ';
      case EmploymentType.contract:
        return 'કોન્ટ્રાક્ટ';
      case EmploymentType.remote:
        return 'રિમોટ';
    }
  }

  static String _getMalayalamName(EmploymentType type) {
    switch (type) {
      case EmploymentType.fullTime:
        return 'പൂർണ്ണ സമയം';
      case EmploymentType.partTime:
        return 'പാർട്ട് ടൈം';
      case EmploymentType.freelance:
        return 'ഫ്രീലാൻസ്';
      case EmploymentType.internship:
        return 'ഇന്റേൺഷിപ്പ്';
      case EmploymentType.contract:
        return 'കരാർ';
      case EmploymentType.remote:
        return 'റിമോട്ട്';
    }
  }
} 