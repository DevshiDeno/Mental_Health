
class Therapist {
  final String name;
  final String specialty;
  final String contact;
  final String location;

  Therapist( {
    required this.location,
    required this.name,
    required this.specialty,
    required this.contact,
  });
  }

  List<Therapist> people = [
    Therapist(name: "Devshi", specialty: "Depression", contact: "0718705129", location: 'Meru'),
    Therapist(name: "Deno", specialty: "Anxiety", contact: "0718346905", location: 'Nairobi'),
    Therapist(name: "Muturi", specialty: "Aggression", contact: "071595959", location: 'Thika'),
    Therapist(name: "Kamau", specialty: "Obesity", contact: "0745095050", location: 'Kiambu'),
  ];

