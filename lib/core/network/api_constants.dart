class ApiConstants {
  /// Base URL
  static const String baseUrl = "https://go-kid.runasp.net";

  /// Auth Endpoints
  static const String register = "$baseUrl/api/Account/register";
  static const String verifyOtp =
      '$baseUrl/api/Account/verify-otp'; // <- هنا ضفناه
  static const String resendOtp = "$baseUrl/api/Account/resend-otp";
  static const String login = "$baseUrl/api/Account/login"; // <- هنا
  static const String refreshToken = "$baseUrl/api/Account/refresh-token";
  static const String logout = "$baseUrl/api/Account/logout"; // <- هنا
  static const String addChild = "$baseUrl/api/Account/child";
  static const String forgotPassword = "$baseUrl/api/Account/forgot-password";
  static const String resetPassword = "$baseUrl/api/Account/reset-password";
  static const String getTasks = "$baseUrl/api/Child";
  static const String getChildPoints = "$baseUrl/api/Child/points";
  static String submitTask(String taskId) =>
      "$baseUrl/api/Child/$taskId/submit";

  /// 🔥 Add Task Flow
  static const String getCategories = "$baseUrl/api/Category";

  static String getSubCategories(String categoryId) =>
      "$baseUrl/api/TaskSubCategory/category/$categoryId";

  static String getTaskTemplates(String subCategoryId, String level) =>
      "$baseUrl/api/task-templates?SubCategoryId=$subCategoryId&Difficulty=$level";

  static const String assignTask = "$baseUrl/api/ParentTask/assign";
  static const getParentTasks = '$baseUrl/api/ParentTask';
  static String getTaskDetails(String taskId) =>
      "$baseUrl/api/ParentTask/$taskId/details";
  static const String reviewTask = "$baseUrl/api/ParentTask/review";
  static const String getAvailableGifts = "$baseUrl/api/gifts/available";
  static String purchaseGift(String giftId) =>
      "$baseUrl/api/gifts/$giftId/purchase";
  static const String globalRanking = "$baseUrl/api/ranking/global";
  static const String institutionRanking = "$baseUrl/api/ranking/institution";

  /// 🎁 Rewards Endpoints
  static const String createReward = "$baseUrl/api/Rewards";
  static const String getRewards = "$baseUrl/api/Rewards";

  static String getRewardDetails(String rewardId) =>
      "$baseUrl/api/Rewards/$rewardId";

  static String giveReward(String rewardId) =>
      "$baseUrl/api/Rewards/$rewardId/give";
  static String deleteReward(String rewardId) =>
      "$baseUrl/api/Rewards/$rewardId";
  static const String getmyRewards = "$baseUrl/api/Rewards/my-rewards";

  /// 🎮 Adventure Endpoints
  static const String getChildAdventures = "$baseUrl/api/ChildAdventure";

  static String getAdventureDetails(String weeklyAdventureId) =>
      "$baseUrl/api/ChildAdventure/$weeklyAdventureId";

 // static String getAdventureTasks(String weeklyAdventureId) =>
    //  "$baseUrl/api/ChildAdventure/weekly-adventures/$weeklyAdventureId/tasks";
}
