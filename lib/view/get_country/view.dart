import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/design/app_image.dart';
import 'package:weather_app/core/logic/helper_methods.dart';
import 'package:weather_app/view/weather/view.dart';
part 'item_model.dart';

class CountryPickerView extends StatelessWidget {
  const CountryPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: AppImage(
            'weather_country.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
        ),
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30.h,),
              Text("اختر الدولة", style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w900
              ),),
              Spacer(),
              Padding(
                padding:  EdgeInsets.all(20.r),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          "اختيار الدولة",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w900
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20.r),
                          backgroundColor: Colors.black12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.sp),
                              side: BorderSide(
                                  color: Colors.grey
                              )
                          ),
                        ),
                        onPressed: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: false,
                            onSelect: (Country country) async {
                              final cityName =ItemModel.getCityFromCountryName(country.name);
                              if (cityName == 'London' &&
                                  country.name.toLowerCase() != 'united kingdom') {
                                await Future.delayed(const Duration(seconds: 0));
                              }
                              navigateTo(
                                WeatherView(countryName: country.name, cityName: cityName),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    )
      ],
    );
  }

}
