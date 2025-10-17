class ApiEndpoints {
  //Auth
  static const String baseUrl = 'https://codingarabic.online/api';
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String forgotPassword = '$baseUrl/forget-password';
  static const String verifyOtp = '$baseUrl/check-forget-password';
  static const String changePassword = '$baseUrl/reset-password';

  //Home
  static const String allProducts = '$baseUrl/products';
  static const String newArrivslsProducts = '$baseUrl/products-new-arrivals';
  static const String bestSellerProducts = '$baseUrl/products-bestseller';
  static const String sliders = '$baseUrl/sliders';

  //Wishlist
  static const String addToWishlist = '$baseUrl/add-to-wishlist';
  static const String removeFromWishlist = '$baseUrl/remove-from-wishlist';
  static const String showWishlist = '$baseUrl/wishlist';

  //cart
  static const String showCart = '$baseUrl/cart';
  static const String addToCart = '$baseUrl/add-to-cart';
  static const String updateCart = '$baseUrl/update-cart';
  static const String removeFromCart = '$baseUrl/remove-from-cart';
  static const String checkout = '$baseUrl/checkout';
  static const String placeOrder = '$baseUrl/place-order';

  //profile
  static const String updateUserProfile = '$baseUrl/update-profile';
  static const String updateUserPassword = '$baseUrl/update-password';

  //search
  static const String search = '$baseUrl/products-search';
}
