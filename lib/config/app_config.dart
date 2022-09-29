class AppConfig {
  static const grantType = "password";
  static const clientId = 2;
  static const clientSecret = "FANSINC";

  static const baseUrl =
      //'https://api.fansinc.io'; // prod
      'https://devapi.fansinc.io'; // dev
  // 'http://fansinc-api.hridham.com'; // dev HT

  static const privacyTermsUrl = 'https://fansinc.io/privacy_policy';

  static const authToken = '/oauth/token';
  static const loginFanUrl = '/api/fanLogin';
  static const registerFanUrl = '/api/guest/fanRegister';
  //'/api/users';
  //static const fanRegistrationUrl = '/api/guest/fanRegister';
  static const forgotPasswordUrl = '/api/forgot_password';

  static const forgotPasswordBodyUrl =
      'http://admin.fansinc.io/reset_password'; //prod

  /* Provider API URL's */
  static const newsUrl = '/api/News';
  static const experienceUrl = '/api/Experience';
  static const myWeekUrl = '/api/MyWeek';
  static const assetsUrl = '/api/assets';
  static const purchaseUrl = '/api/Purchase';
  static const profileUrl = '/api/me';

  // Address
  static const viewAddress = '/api/me/viewuseraddress';
  static const createAddress = '/api/me/createuseraddress';

  // NFT Wallet
  static const getWalletInterest = '/api/getWalletInterest';
  static const setWalletInterest = '/api/setWalletInterest';
  /* Provider API URL's */

  /* Config Colors */

  static const blueColorHex = '#002E5A';
  static const blackColorHex = '#1A1818';
  static const blackColor = 0xFF1A1818;
  static const orangeColorHex = '#F77E23';
  static const orangeColor = 0xFFF77E23;
  static const blueColor = 0xFF002F5D;
  static const blueBorderColor = 0xFF88A0B5;
  static const greenColor = 0xFF2CC78F;
  static const lightGrey = 0xFFD8D8D8;
  static const grey = 0xFFA9A9A9;
  static const comingSoonColor = 0XFF1B181F;

  /* Config Colors */

  /* Config Assets */
  static const defaultImage = 'assets/images/default.jpg';
  static const logoImage = 'assets/images/aw1_logo.png';
  static const splashImage = 'assets/images/aw1_logo.png';
  static const logoGoogleImage = 'assets/images/google_logo.png';
  static const tickImage = 'assets/icons/tick.png';
  static const comingSoonImage = 'assets/images/coming_soon.jpg';
  static const nftImage = 'assets/images/nft_bright.jpg';
  static const nftImageGIF = 'assets/images/nft_bright_resized.gif';
  static const nextStep = 'assets/images/Next_Step.jpeg';
  static const nextStepModified = 'assets/images/Next_Step_modified.png';
  static const northampton = 'assets/images/Northampton.jpeg';
  static const northamptonModified = 'assets/images/Northampton_modified.png';
  static const sbsa = 'assets/images/SBSA.jpeg';
  static const sbsaModified = 'assets/images/SBSA_modified.png';
}
