class BankAccount {
  final int numberCard;
  final int rawForegroundColor;
  final double balance;
  final String bankName;
  final String bankLogo;
  final String imageBackground;
  final AccountTransaction lastTransaction;

  const BankAccount(this.balance, this.numberCard, this.rawForegroundColor,
      this.bankName, this.bankLogo, this.imageBackground, this.lastTransaction);

  static List<BankAccount> get accountCards => [
        //First Account Card
        const BankAccount(
          10230,
          9002,
          0x400040FF,
          'BBVA Bancomer',
          'assets/bank_challenge/img/bbva-logo.png',
          'assets/bank_challenge/img/bbva-background.jpg',
          AccountTransaction('Next 30 July', 'HBO Max', -14.99,
              'assets/bank_challenge/img/hbo-max-logo.webp'),
        ),
        //Second Account Card
        const BankAccount(
          1460,
          8021,
          0x40000000,
          'Citi Banamex',
          'assets/bank_challenge/img/citi-logo.png',
          'assets/bank_challenge/img/citi-background.jpg',
          AccountTransaction('Next 06 August', 'Netflix', -12.99,
              'assets/bank_challenge/img/netflix-logo.jpg'),
        ),
        //Third Account Card
        const BankAccount(
          13230,
          9002,
          0x40FF0000,
          'Santander',
          'assets/bank_challenge/img/san-logo.png',
          'assets/bank_challenge/img/santander-background.jpg',
          AccountTransaction('June 31', 'Deposit', 320.00,
              'assets/bank_challenge/img/save-money.jpg'),
        ),
      ];
}
class BankClient {
  const BankClient(this.name, this.pathImage, this.accounts);

  final String name;
  final String pathImage;
  final List<BankAccount> accounts;

  static BankClient get currentUser => BankClient(
    'Matt Johnson',
    'assets/bank_challenge/img/user5.jpg',
    BankAccount.accountCards,
  );

  static List<BankClient> get users => [
    const BankClient('Francis Garcia', 'assets/bank_challenge/img/user1.jpg', []),
    const BankClient('Arthur Li', 'assets/bank_challenge/img/user2.jpg', []),
    const BankClient('Christian Lake', 'assets/bank_challenge/img/user3.jpg', []),
    const BankClient('Liam Smith', 'assets/bank_challenge/img/user4.jpg', []),
    const BankClient('Carl ', 'assets/bank_challenge/img/user6.jpg', []),
    const BankClient('Guadalupe', 'assets/bank_challenge/img/user7.jpg', []),
    const BankClient('Liliano', 'assets/bank_challenge/img/user8.jpg', []),
  ];
}
class AccountTransaction {
  final String header;
  final String concept;
  final double money;
  final String srcImage;

  const AccountTransaction(
      this.header, this.concept, this.money, this.srcImage);
}
