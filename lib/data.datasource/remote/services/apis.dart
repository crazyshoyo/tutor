class Apis {
  static const baseUrl = 'https://tutorslms.com';
  static const login = '$baseUrl/api/auth/signin';
  static const getSingleCourse = '$baseUrl/api/courses/course/?slug=';
  static const registerByEmail = '$baseUrl/api/auth/signup';
  static const forgotPassword = '$baseUrl/api/auth/forgot-password';
  static const resetPassword = '$baseUrl/api/auth/changePassword';
  static const banner = '$baseUrl/api/all-courses';
  static const learning = '$baseUrl/api/learnings/';
  static const videos = '$baseUrl/api/learnings/videos/';
  static const userdetail = '$baseUrl/api/auth/update';
  static const purchasehistory = '$baseUrl/api/learnings/my-purchases/';
  static const categories = '$baseUrl/api/categories';
  static const dashboardapi = '$baseUrl/api/dashboard';
  static const notification = '$baseUrl/api/announcement/';
  static const faq = '$baseUrl/api/faq/';
  static const userProfile = '$baseUrl/api/users/update/';
  static const profileImage = '$baseUrl/api/authprofile-photo';
  static const memberShipPlan = '$baseUrl/api/membershipPlan';
  static const createMembershipPlan = '$baseUrl/api/membershipPlan/create';
  static const featuredCourses = '$baseUrl/api/featured-courses/?page=1&limit=10';
  static const funFact = '$baseUrl/api/funfacts/';
  static const enroll = '$baseUrl/api/courses/course/enroll/';
  static const courseProgress = '$baseUrl/api/learnings/progress/?userId=14&courseId=122';
  static const stripePayment = '$baseUrl/api/membershipPlan/create';
  static const getCategory = '$baseUrl/api/all-courses/?page=1&limit=12&category=';
  static const createPayment = '$baseUrl/api/membershipPlan/create/';
}