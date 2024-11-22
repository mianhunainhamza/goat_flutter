import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../models/golf_course/golf_course_model.dart';

class GolfCourseController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<GolfCourseModel> golfCourses = <GolfCourseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchGolfCourses();
  }

  Future<void> fetchGolfCourses() async {
    isLoading.value = true;
    try {
      DatabaseReference reference = FirebaseDatabase.instance.ref('golf-courses');
      DataSnapshot snapshot = await reference.get();

      if (snapshot.exists && snapshot.value is List) {
        List<dynamic> courses = snapshot.value as List;
        golfCourses.value = courses
            .where((course) => course != null)
            .map((course) => GolfCourseModel.fromMap(Map<String, dynamic>.from(course)))
            .toList();
      } else {
        print("Unexpected data structure: ${snapshot.value}");
      }
    } catch (e) {
      print("Error fetching golf courses: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String? getBookingUrl(String courseName) {
    const golfCourses = [
      {
        'courseName': 'Ravisloe Country Club - Weekends after 11am (8 Spots daily)',
        'bookingUrl':
        'https://www.golfnow.com/tee-times/facility/5345-ravisloe-country-club/search',
      },
      {
        'courseName': 'ThunderHawk Golf Club- Weekends after 1pm (8 spots daily)',
        'bookingUrl':
        'https://sc.cps.golf/ThunderhawkV3/(S(kepwnerfpjmuvdtslfgsw0nl))/Home/nIndex',
      },
      {
        'courseName': 'Countryside Prairie - Weekends after 11am (8 spots daily)',
        'bookingUrl':
        'https://sc.cps.golf/CountrysideV3/(S(ybfi05iwx25nsdrl1xqpi1az))/Home/nIndex/',
      },
      {
        'courseName': 'Golf Club of Illinois- Weekends after 10am (2 Foursomes daily)',
        'bookingUrl': 'https://golfclubofil.com/teetimes/',
      },
      {
        'courseName': 'Prairie Isle Golf Club- No restrictions (8 spots daily)',
        'bookingUrl':
        'https://www.golfnow.com/tee-times/facility/5645-prairie-isle-golf-club/search',
      },
      {
        'courseName': 'Hilldale Golf Club- Weekends after 11am (8 spots daily)',
        'bookingUrl': 'https://www.hilldalegolf.com/tee-times-2/',
      },
      {
        'courseName': 'Countryside Traditional - Weekends after 11am (8 spots daily)',
        'bookingUrl':
        'https://sc.cps.golf/CountrysideV3/(S(ybfi05iwx25nsdrl1xqpi1az))/Home/nIndex/',
      },
      {
        'courseName':
        'White Pines Golf Club - East and West Course - Weekends after 10am (8 spots daily)',
        'bookingUrl':
        'https://www.golfnow.com/tee-times/facility/7002-white-pines-golf-club-west-course/search',
      },
      {
        'courseName': 'White Tail Ridge Golf Club - Weekends after 10am (1 Foursome daily)',
        'bookingUrl':
        'https://foreupsoftware.com/index.php/booking/21036/6628#/teetimes',
      },
      {
        'courseName':
        'Glenview Park Golf Club - Weekends after 12pm (4 Spots daily, minimum of 2)',
        'bookingUrl': 'https://glenviewparks.org/gpgc-book-a-tee-time/',
      },
      {
        'courseName': 'Old Orchard Country Club - Weekends after 12pm (1 Foursome daily)',
        'bookingUrl':
        'https://www.golfnow.com/tee-times/facility/7082-old-orchard-country-club/search',
      },
      {
        'courseName': 'Ruffled Feathers Golf Club - Weekends after 1pm (1 Foursome daily)',
        'bookingUrl':
        'https://www.golfnow.com/tee-times/facility/945-ruffled-feathers-golf-club/search',
      },
      {
        'courseName':
        'Big Run Golf Club- Mon-Fri (4 Spots) Sat-Sun (1 Foursome) Weekends after 11am',
        'bookingUrl':
        'https://www.golfnow.com/tee-times/facility/11160-big-run-golf-club/search',
      },
      {
        'courseName':
        'Boone Creek Golf Club – 27 Holes - No restrictions (8 spots daily)',
        'bookingUrl':
        'https://www.golfnow.com/tee-times/facility/9958-boone-creek-golf-club/search',
      },
      {
        'courseName': 'Hickory Hills Country Club - no restrictions ( 2 Foursomes daily)',
        'bookingUrl':
        'https://www.golfnow.com/tee-times/facility/12212-hickory-hills-country-club-south-course/search',
      },
      {
        'courseName': 'Calumet Country Club- no restrictions (8 spots daily)',
        'bookingUrl':
        'https://www.golfnow.com/tee-times/facility/15834-calumet-country-club/search',
      },
    ];

    for (var course in golfCourses) {
      if (course['courseName'] == courseName) {
        return course['bookingUrl'];
      }
    }
    return null;
  }
}
