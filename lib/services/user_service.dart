class UserService {
  static String _userName = 'Guest User';
  static String _phoneNumber = '';

  static void setUserData(String name, String phone) {
    _userName = name;
    _phoneNumber = phone;
  }

  static String get userName => _userName;
  static String get phoneNumber => _phoneNumber;
  static String get formattedPhone => _phoneNumber.length == 10 
      ? '+91 ${_phoneNumber.substring(0, 5)} ${_phoneNumber.substring(5)}'
      : '+91 $_phoneNumber';
}
