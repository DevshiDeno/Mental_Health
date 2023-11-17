
class Doctor {
  final String name, speciality, image;
  final int reviews;
  final int reviewScore;

  Doctor(
      {required this.name,
        required this.speciality,
        required this.image,
        required this.reviews,
        required this.reviewScore});
  static final doctorsList = [
    Doctor(
        name: "Dr.Hegazy Ali",
        speciality: "Cardiology",
        image: "images/doctor_1.png",
        reviews: 80,
        reviewScore: 4),
    Doctor(
        name: "Dr.Dani",
        speciality: "Dermatology",
        image: "images/doctor_2.png",
        reviews: 67,
        reviewScore: 5),
    Doctor(
        name: "Dr George",
        speciality: "Ophthalmology",
        image: "images/doctor_1.png",
        reviews: 19,
        reviewScore: 3),
    Doctor(
        name: "Dr Dennis",
        speciality: "Psychology",
        image: "assets/images/doctor_1.png",
        reviews: 19,
        reviewScore: 4),
    Doctor(
        name: "Dr Winnie",
        speciality: "Mania",
        image: "images/doctor_2.png",
        reviews: 19,
        reviewScore: 3),
    Doctor(
        name: "Dr Winnie",
        speciality: "Mania",
        image: "images/doctor_3.png",
        reviews: 19,
        reviewScore: 3),

  ];
}
