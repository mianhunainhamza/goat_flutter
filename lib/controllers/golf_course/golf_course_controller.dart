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
        golfCourses.value = courses.where((course) => course != null).map((course) {
          return GolfCourseModel.fromMap(Map<String, dynamic>.from(course));
        }).toList();
      } else {
        print("Unexpected data structure: ${snapshot.value}");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Error fetching golf courses: $e");
    }
  }

}
