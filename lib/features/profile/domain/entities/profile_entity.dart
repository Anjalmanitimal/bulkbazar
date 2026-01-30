class ProfileEntity {
  final String? id;
  final String fullName;
  final String email;
  final String? profileImage;

  const ProfileEntity({
    this.id,
    required this.fullName,
    required this.email,
    this.profileImage,
  });
}
