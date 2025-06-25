part of 'view.dart';
class ItemModel{
 static  String getCityFromCountryName(String? countryName) {
    final Map<String, String> countryToCity = {
      'Egypt': 'Cairo',
      'saudi arabia': 'Riyadh',
      'united states': 'Washington',
      'france': 'Paris',
      'germany': 'Berlin',
      'united kingdom': 'London',
    };

    return countryToCity[countryName?.trim().toLowerCase()] ?? 'London';
  }

}