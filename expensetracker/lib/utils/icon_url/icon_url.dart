class IconUrl {
  var imgUrls = {
  //expense
  'Bills': 'assets/images/icons/bill.png', 
  'Education': 'assets/images/icons/education.png', 
  'Entertainment': 'assets/images/icons/popcorn.png', 
  'Fashion & Clothing': 'assets/images/icons/dress.png',
  'Foods & Beverages': 'assets/images/icons/healthy-drink.png', 
  'Gadgets & Technologies': 'assets/images/icons/gadgets.png', 
  'Gifts & Donations': 'assets/images/icons/giftbox.png', 
  'Groceries': 'assets/images/icons/shopping-bag.png', 
  'Investment Expenses': 'assets/images/icons/investing.png', 
  'Loans': 'assets/images/icons/loan.png', 
  'Maintenance & Repair': 'assets/images/icons/repair.png', 
  'Make Up & Beauty Products': 'assets/images/icons/makeup.png', 
  'Medical & Dental': 'assets/images/icons/first-aid-kit.png', 
  'Other Expenses': 'assets/images/icons/poor.png', 
  'Pet Food & Care': 'assets/images/icons/pet-food.png',
  'Savings': 'assets/images/icons/saving.png', 
  'Software & Programs': 'assets/images/icons/software.png', 
  'Sports & Fitness': 'assets/images/icons/sport.png', 
  'Travel': 'assets/travel-luggage.png', 
  //income
  'Allowance':'assets/images/icons/payment-method.png',
  'Bonus':'assets/images/icons/incentive.png',
  'Commission':'assets/images/icons/commission.png',
  'Dividend':'assets/images/icons/dividend.png',
  'Gifts':'assets/images/icons/gift-card.png',
  'Interest':'assets/images/icons/compound.png',
  'Investment Returns':'assets/images/icons/investment.png',
  'Monetary Assistance':'assets/images/icons/money-bag.png',
  'Other Income':'assets/images/icons/income.png',
  'Part Time Wages':'assets/images/icons/part-time.png',
  'Profit':'assets/images/icons/profits.png',
  'Salary':'assets/images/icons/salary.png',
  'Scholarship':'assets/images/icons/scholarship.png',
  };

  String imgUrl (String type){
    return imgUrls[type]!;
  }
}
