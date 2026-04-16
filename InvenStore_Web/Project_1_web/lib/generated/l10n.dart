// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign In`
  String get signin {
    return Intl.message(
      'Sign In',
      name: 'signin',
      desc: '',
      args: [],
    );
  }

  /// `E-mail Address`
  String get email_Address {
    return Intl.message(
      'E-mail Address',
      name: 'email_Address',
      desc: '',
      args: [],
    );
  }

  /// `E-mail cannot be empty`
  String get email_cannot_be_empty {
    return Intl.message(
      'E-mail cannot be empty',
      name: 'email_cannot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Enter e-mail..`
  String get enter_email {
    return Intl.message(
      'Enter e-mail..',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `This feild is required`
  String get feild_required {
    return Intl.message(
      'This feild is required',
      name: 'feild_required',
      desc: '',
      args: [],
    );
  }

  /// `Enter password..`
  String get enter_password {
    return Intl.message(
      'Enter password..',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Or Sign In With`
  String get or_Sign_With {
    return Intl.message(
      'Or Sign In With',
      name: 'or_Sign_With',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Warehouses`
  String get warehouses {
    return Intl.message(
      'Warehouses',
      name: 'warehouses',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Manager`
  String get manager {
    return Intl.message(
      'Manager',
      name: 'manager',
      desc: '',
      args: [],
    );
  }

  /// `This feild is required`
  String get required {
    return Intl.message(
      'This feild is required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Enter User Name..`
  String get enterUserName {
    return Intl.message(
      'Enter User Name..',
      name: 'enterUserName',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone Number..`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter Phone Number..',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Full Name..`
  String get enterFullName {
    return Intl.message(
      'Enter Full Name..',
      name: 'enterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Enter Location..`
  String get enterLocation {
    return Intl.message(
      'Enter Location..',
      name: 'enterLocation',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Enter City..`
  String get enterCity {
    return Intl.message(
      'Enter City..',
      name: 'enterCity',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get report {
    return Intl.message(
      'Reports',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Employees`
  String get employees {
    return Intl.message(
      'Employees',
      name: 'employees',
      desc: '',
      args: [],
    );
  }

  /// `Centers`
  String get centers {
    return Intl.message(
      'Centers',
      name: 'centers',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Category Name`
  String get categoryNameAr {
    return Intl.message(
      'Arabic Category Name',
      name: 'categoryNameAr',
      desc: '',
      args: [],
    );
  }

  /// `English Category Name`
  String get categoryNameEn {
    return Intl.message(
      'English Category Name',
      name: 'categoryNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Enter Category Name in Arabic..`
  String get entercategoryNameAr {
    return Intl.message(
      'Enter Category Name in Arabic..',
      name: 'entercategoryNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Enter Category Name in English..`
  String get entercategoryNameEn {
    return Intl.message(
      'Enter Category Name in English..',
      name: 'entercategoryNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Search..`
  String get search {
    return Intl.message(
      'Search..',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Edit Category`
  String get editCategory {
    return Intl.message(
      'Edit Category',
      name: 'editCategory',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Add Subcategory`
  String get addSubcategory {
    return Intl.message(
      'Add Subcategory',
      name: 'addSubcategory',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logout {
    return Intl.message(
      'Log Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Login to another account`
  String get anotherAccount {
    return Intl.message(
      'Login to another account',
      name: 'anotherAccount',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message(
      'Light Theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message(
      'Add Product',
      name: 'addProduct',
      desc: '',
      args: [],
    );
  }

  /// `Edit Subcategory`
  String get editSubcategory {
    return Intl.message(
      'Edit Subcategory',
      name: 'editSubcategory',
      desc: '',
      args: [],
    );
  }

  /// `English Product Name`
  String get ProductNameEn {
    return Intl.message(
      'English Product Name',
      name: 'ProductNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Name in English..`
  String get enterProductNameEn {
    return Intl.message(
      'Enter Product Name in English..',
      name: 'enterProductNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Product Name`
  String get ProductNameAr {
    return Intl.message(
      'Arabic Product Name',
      name: 'ProductNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Name in Arabic..`
  String get enterProductNameAr {
    return Intl.message(
      'Enter Product Name in Arabic..',
      name: 'enterProductNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Manufacturers`
  String get manufacturer {
    return Intl.message(
      'Manufacturers',
      name: 'manufacturer',
      desc: '',
      args: [],
    );
  }

  /// `Enter Manufacturer Name..`
  String get enterManufacturer {
    return Intl.message(
      'Enter Manufacturer Name..',
      name: 'enterManufacturer',
      desc: '',
      args: [],
    );
  }

  /// `English Description`
  String get descriptionEn {
    return Intl.message(
      'English Description',
      name: 'descriptionEn',
      desc: '',
      args: [],
    );
  }

  /// `Enter The Description in English..`
  String get enterDescriptionEn {
    return Intl.message(
      'Enter The Description in English..',
      name: 'enterDescriptionEn',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Description`
  String get descriptionAr {
    return Intl.message(
      'Arabic Description',
      name: 'descriptionAr',
      desc: '',
      args: [],
    );
  }

  /// `Enter The Description in Arabic..`
  String get enterDescriptionAr {
    return Intl.message(
      'Enter The Description in Arabic..',
      name: 'enterDescriptionAr',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Enter The Price..`
  String get enterprice {
    return Intl.message(
      'Enter The Price..',
      name: 'enterprice',
      desc: '',
      args: [],
    );
  }

  /// `Suffix`
  String get suffix {
    return Intl.message(
      'Suffix',
      name: 'suffix',
      desc: '',
      args: [],
    );
  }

  /// `Enter The Suffix..`
  String get enterSuffix {
    return Intl.message(
      'Enter The Suffix..',
      name: 'enterSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get description {
    return Intl.message(
      'Product Details',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Add Employee`
  String get addEmployee {
    return Intl.message(
      'Add Employee',
      name: 'addEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Employee`
  String get employee {
    return Intl.message(
      'Employee',
      name: 'employee',
      desc: '',
      args: [],
    );
  }

  /// `Contact Info`
  String get contactInfo {
    return Intl.message(
      'Contact Info',
      name: 'contactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Workplace`
  String get workplace {
    return Intl.message(
      'Workplace',
      name: 'workplace',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Employee Details`
  String get employeeDetails {
    return Intl.message(
      'Employee Details',
      name: 'employeeDetails',
      desc: '',
      args: [],
    );
  }

  /// `PROFILE IMAGE`
  String get profileImage {
    return Intl.message(
      'PROFILE IMAGE',
      name: 'profileImage',
      desc: '',
      args: [],
    );
  }

  /// `ROLE`
  String get role {
    return Intl.message(
      'ROLE',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `Personal Data`
  String get personalData {
    return Intl.message(
      'Personal Data',
      name: 'personalData',
      desc: '',
      args: [],
    );
  }

  /// `BIRTHDATE`
  String get birthDay {
    return Intl.message(
      'BIRTHDATE',
      name: 'birthDay',
      desc: '',
      args: [],
    );
  }

  /// `GENDER`
  String get gender {
    return Intl.message(
      'GENDER',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `SSN`
  String get ssn {
    return Intl.message(
      'SSN',
      name: 'ssn',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `NO`
  String get no {
    return Intl.message(
      'NO',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get yes {
    return Intl.message(
      'YES',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `You will deactivate this employee. Are you sure?`
  String get deactivateEmployeeMsg {
    return Intl.message(
      'You will deactivate this employee. Are you sure?',
      name: 'deactivateEmployeeMsg',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Enter SSN..`
  String get enterSSN {
    return Intl.message(
      'Enter SSN..',
      name: 'enterSSN',
      desc: '',
      args: [],
    );
  }

  /// `Enter Address..`
  String get enterAddress {
    return Intl.message(
      'Enter Address..',
      name: 'enterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Edit Personal Data`
  String get editPersonalData {
    return Intl.message(
      'Edit Personal Data',
      name: 'editPersonalData',
      desc: '',
      args: [],
    );
  }

  /// `Edit Contact Info`
  String get editContactInfo {
    return Intl.message(
      'Edit Contact Info',
      name: 'editContactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Edit Permissions`
  String get editPermissions {
    return Intl.message(
      'Edit Permissions',
      name: 'editPermissions',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Mele`
  String get male {
    return Intl.message(
      'Mele',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `English Warehouse Name`
  String get warehouseNameEn {
    return Intl.message(
      'English Warehouse Name',
      name: 'warehouseNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Warehouse Name`
  String get warehouseNameAr {
    return Intl.message(
      'Arabic Warehouse Name',
      name: 'warehouseNameAr',
      desc: '',
      args: [],
    );
  }

  /// `English Street Name`
  String get streetNameEn {
    return Intl.message(
      'English Street Name',
      name: 'streetNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Enter Warehouse Name in Arabic..`
  String get enterwarehouseNameEn {
    return Intl.message(
      'Enter Warehouse Name in Arabic..',
      name: 'enterwarehouseNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Enter Warehouse Name in English..`
  String get enterwarehouseNameAr {
    return Intl.message(
      'Enter Warehouse Name in English..',
      name: 'enterwarehouseNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Enter Street Name in English..`
  String get enterStreetNameEn {
    return Intl.message(
      'Enter Street Name in English..',
      name: 'enterStreetNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Street Name`
  String get streetNameAr {
    return Intl.message(
      'Arabic Street Name',
      name: 'streetNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Enter Street Name in Arabic..`
  String get enterStreetNameAr {
    return Intl.message(
      'Enter Street Name in Arabic..',
      name: 'enterStreetNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Add Warehouse`
  String get addWarehouse {
    return Intl.message(
      'Add Warehouse',
      name: 'addWarehouse',
      desc: '',
      args: [],
    );
  }

  /// `Add Distribution center`
  String get addCenter {
    return Intl.message(
      'Add Distribution center',
      name: 'addCenter',
      desc: '',
      args: [],
    );
  }

  /// `English Distribution center Name`
  String get centerNameEn {
    return Intl.message(
      'English Distribution center Name',
      name: 'centerNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Distribution center Name`
  String get centerNameAr {
    return Intl.message(
      'Arabic Distribution center Name',
      name: 'centerNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Enter Distribution center Name in Arabic..`
  String get enterCenterNameEn {
    return Intl.message(
      'Enter Distribution center Name in Arabic..',
      name: 'enterCenterNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Enter Distribution center Name in English..`
  String get enterCenterNameAr {
    return Intl.message(
      'Enter Distribution center Name in English..',
      name: 'enterCenterNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Edit Warehouse`
  String get editWarehouse {
    return Intl.message(
      'Edit Warehouse',
      name: 'editWarehouse',
      desc: '',
      args: [],
    );
  }

  /// `Continue As Manager`
  String get continueAsManager {
    return Intl.message(
      'Continue As Manager',
      name: 'continueAsManager',
      desc: '',
      args: [],
    );
  }

  /// `Edit Distribution center`
  String get editCenter {
    return Intl.message(
      'Edit Distribution center',
      name: 'editCenter',
      desc: '',
      args: [],
    );
  }

  /// `Edit Employee`
  String get editEmployee {
    return Intl.message(
      'Edit Employee',
      name: 'editEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Subcategory`
  String get subcategory {
    return Intl.message(
      'Subcategory',
      name: 'subcategory',
      desc: '',
      args: [],
    );
  }

  /// `Distribution Center`
  String get distributionCenter {
    return Intl.message(
      'Distribution Center',
      name: 'distributionCenter',
      desc: '',
      args: [],
    );
  }

  /// `Warehouse`
  String get warehouse {
    return Intl.message(
      'Warehouse',
      name: 'warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Add Manufacturer`
  String get addManufacturer {
    return Intl.message(
      'Add Manufacturer',
      name: 'addManufacturer',
      desc: '',
      args: [],
    );
  }

  /// `English Manufacturer Name`
  String get manufacturerNameEn {
    return Intl.message(
      'English Manufacturer Name',
      name: 'manufacturerNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Manufacturer Name`
  String get manufacturerNameAr {
    return Intl.message(
      'Arabic Manufacturer Name',
      name: 'manufacturerNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Enter Manufacturer Name in Arabic..`
  String get entermanufacturerNameEn {
    return Intl.message(
      'Enter Manufacturer Name in Arabic..',
      name: 'entermanufacturerNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Enter Manufacturer Name in English..`
  String get entermanufacturerNameAr {
    return Intl.message(
      'Enter Manufacturer Name in English..',
      name: 'entermanufacturerNameAr',
      desc: '',
      args: [],
    );
  }

  /// `All Products`
  String get allProducts {
    return Intl.message(
      'All Products',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  /// `Minimum`
  String get minimum {
    return Intl.message(
      'Minimum',
      name: 'minimum',
      desc: '',
      args: [],
    );
  }

  /// `Enter Minimum Value..`
  String get enterminimum {
    return Intl.message(
      'Enter Minimum Value..',
      name: 'enterminimum',
      desc: '',
      args: [],
    );
  }

  /// `Edit Minimum`
  String get editMinimum {
    return Intl.message(
      'Edit Minimum',
      name: 'editMinimum',
      desc: '',
      args: [],
    );
  }

  /// `Maximum`
  String get maximum {
    return Intl.message(
      'Maximum',
      name: 'maximum',
      desc: '',
      args: [],
    );
  }

  /// `Enter Maximum Value..`
  String get entermaximum {
    return Intl.message(
      'Enter Maximum Value..',
      name: 'entermaximum',
      desc: '',
      args: [],
    );
  }

  /// `Edit Maximum`
  String get editMaximum {
    return Intl.message(
      'Edit Maximum',
      name: 'editMaximum',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get ordres {
    return Intl.message(
      'Orders',
      name: 'ordres',
      desc: '',
      args: [],
    );
  }

  /// `You will deactivate this product. Are you sure?`
  String get deactivateProductMsg {
    return Intl.message(
      'You will deactivate this product. Are you sure?',
      name: 'deactivateProductMsg',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get orderId {
    return Intl.message(
      'Order ID',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `Ordered By`
  String get orderedBy {
    return Intl.message(
      'Ordered By',
      name: 'orderedBy',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Cost`
  String get cost {
    return Intl.message(
      'Cost',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `Ordered From`
  String get orderedFrom {
    return Intl.message(
      'Ordered From',
      name: 'orderedFrom',
      desc: '',
      args: [],
    );
  }

  /// `Create Order`
  String get createOrder {
    return Intl.message(
      'Create Order',
      name: 'createOrder',
      desc: '',
      args: [],
    );
  }

  /// `Sell Orders`
  String get sellOrders {
    return Intl.message(
      'Sell Orders',
      name: 'sellOrders',
      desc: '',
      args: [],
    );
  }

  /// `Buy Orders`
  String get buyOrders {
    return Intl.message(
      'Buy Orders',
      name: 'buyOrders',
      desc: '',
      args: [],
    );
  }

  /// `Supplies`
  String get suplies {
    return Intl.message(
      'Supplies',
      name: 'suplies',
      desc: '',
      args: [],
    );
  }

  /// `Total Quantity`
  String get total {
    return Intl.message(
      'Total Quantity',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Valid Quantity`
  String get validQuantity {
    return Intl.message(
      'Valid Quantity',
      name: 'validQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Expired Quantity`
  String get expiredQuantity {
    return Intl.message(
      'Expired Quantity',
      name: 'expiredQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Expiration Date`
  String get expirationDate {
    return Intl.message(
      'Expiration Date',
      name: 'expirationDate',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summary {
    return Intl.message(
      'Summary',
      name: 'summary',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Cost`
  String get shippingCost {
    return Intl.message(
      'Shipping Cost',
      name: 'shippingCost',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get deleted {
    return Intl.message(
      'Deleted',
      name: 'deleted',
      desc: '',
      args: [],
    );
  }

  /// `Recieve`
  String get recieve {
    return Intl.message(
      'Recieve',
      name: 'recieve',
      desc: '',
      args: [],
    );
  }

  /// `Recieved`
  String get recieved {
    return Intl.message(
      'Recieved',
      name: 'recieved',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get accepted {
    return Intl.message(
      'Accepted',
      name: 'accepted',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message(
      'Rejected',
      name: 'rejected',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Add State`
  String get addState {
    return Intl.message(
      'Add State',
      name: 'addState',
      desc: '',
      args: [],
    );
  }

  /// `English State Name`
  String get stateNameEn {
    return Intl.message(
      'English State Name',
      name: 'stateNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Arabic State Name`
  String get stateNameAr {
    return Intl.message(
      'Arabic State Name',
      name: 'stateNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Enter State Name in Arabic..`
  String get enterstateNameEn {
    return Intl.message(
      'Enter State Name in Arabic..',
      name: 'enterstateNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Enter State Name in English..`
  String get enterstateNameAr {
    return Intl.message(
      'Enter State Name in English..',
      name: 'enterstateNameAr',
      desc: '',
      args: [],
    );
  }

  /// `No Avalibale States`
  String get noAvalibaleStates {
    return Intl.message(
      'No Avalibale States',
      name: 'noAvalibaleStates',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Shipment`
  String get shipments {
    return Intl.message(
      'Shipment',
      name: 'shipments',
      desc: '',
      args: [],
    );
  }

  /// `Shipment Number`
  String get shipmentNumber {
    return Intl.message(
      'Shipment Number',
      name: 'shipmentNumber',
      desc: '',
      args: [],
    );
  }

  /// `Driver Name`
  String get driverName {
    return Intl.message(
      'Driver Name',
      name: 'driverName',
      desc: '',
      args: [],
    );
  }

  /// `Distination`
  String get distination {
    return Intl.message(
      'Distination',
      name: 'distination',
      desc: '',
      args: [],
    );
  }

  /// `Shipment Status`
  String get shipmentStatus {
    return Intl.message(
      'Shipment Status',
      name: 'shipmentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Shipment Details`
  String get shipmentDetails {
    return Intl.message(
      'Shipment Details',
      name: 'shipmentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Company`
  String get shippingCompany {
    return Intl.message(
      'Shipping Company',
      name: 'shippingCompany',
      desc: '',
      args: [],
    );
  }

  /// `Sending Address`
  String get sendingAddress {
    return Intl.message(
      'Sending Address',
      name: 'sendingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Recieving Address`
  String get recievingAddress {
    return Intl.message(
      'Recieving Address',
      name: 'recievingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Date Of Shipment`
  String get dateOfShipment {
    return Intl.message(
      'Date Of Shipment',
      name: 'dateOfShipment',
      desc: '',
      args: [],
    );
  }

  /// `Order Data`
  String get orderData {
    return Intl.message(
      'Order Data',
      name: 'orderData',
      desc: '',
      args: [],
    );
  }

  /// `Enter Driver Name..`
  String get enterdriverName {
    return Intl.message(
      'Enter Driver Name..',
      name: 'enterdriverName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Shipping Cost`
  String get enterCost {
    return Intl.message(
      'Enter Shipping Cost',
      name: 'enterCost',
      desc: '',
      args: [],
    );
  }

  /// `Add Shipping Company`
  String get addShippingCompany {
    return Intl.message(
      'Add Shipping Company',
      name: 'addShippingCompany',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Companies`
  String get shippingCompanies {
    return Intl.message(
      'Shipping Companies',
      name: 'shippingCompanies',
      desc: '',
      args: [],
    );
  }

  /// `English Shipping Company Name`
  String get shippingCompanyNameEn {
    return Intl.message(
      'English Shipping Company Name',
      name: 'shippingCompanyNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Shipping Company Name`
  String get shippingCompanyNameAr {
    return Intl.message(
      'Arabic Shipping Company Name',
      name: 'shippingCompanyNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Enter Shipping Company Name in Arabic..`
  String get entershippingCompanyNameEn {
    return Intl.message(
      'Enter Shipping Company Name in Arabic..',
      name: 'entershippingCompanyNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Enter Shipping Company Name in English..`
  String get entershippingCompanyNameAr {
    return Intl.message(
      'Enter Shipping Company Name in English..',
      name: 'entershippingCompanyNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Process`
  String get shippingProcess {
    return Intl.message(
      'Shipping Process',
      name: 'shippingProcess',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message(
      'Shipping',
      name: 'shipping',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delievered {
    return Intl.message(
      'Delivered',
      name: 'delievered',
      desc: '',
      args: [],
    );
  }

  /// `Under Preparing`
  String get underPreparing {
    return Intl.message(
      'Under Preparing',
      name: 'underPreparing',
      desc: '',
      args: [],
    );
  }

  /// `Under Shipping`
  String get underShipping {
    return Intl.message(
      'Under Shipping',
      name: 'underShipping',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Valid Products`
  String get validProducts {
    return Intl.message(
      'Valid Products',
      name: 'validProducts',
      desc: '',
      args: [],
    );
  }

  /// `Expired Product`
  String get expiredProducts {
    return Intl.message(
      'Expired Product',
      name: 'expiredProducts',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name..`
  String get enterName {
    return Intl.message(
      'Enter Name..',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Enter Price..`
  String get enterPrice {
    return Intl.message(
      'Enter Price..',
      name: 'enterPrice',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Before`
  String get before {
    return Intl.message(
      'Before',
      name: 'before',
      desc: '',
      args: [],
    );
  }

  /// `After`
  String get after {
    return Intl.message(
      'After',
      name: 'after',
      desc: '',
      args: [],
    );
  }

  /// `From:`
  String get from {
    return Intl.message(
      'From:',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To:`
  String get to {
    return Intl.message(
      'To:',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Choose a date`
  String get chooseDate {
    return Intl.message(
      'Choose a date',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Date A-Z`
  String get dateAsc {
    return Intl.message(
      'Date A-Z',
      name: 'dateAsc',
      desc: '',
      args: [],
    );
  }

  /// `Date Z-A`
  String get dateDesc {
    return Intl.message(
      'Date Z-A',
      name: 'dateDesc',
      desc: '',
      args: [],
    );
  }

  /// `Order Number Ascending`
  String get orderNumberAscending {
    return Intl.message(
      'Order Number Ascending',
      name: 'orderNumberAscending',
      desc: '',
      args: [],
    );
  }

  /// `Order Number Descending`
  String get orderNumberDescending {
    return Intl.message(
      'Order Number Descending',
      name: 'orderNumberDescending',
      desc: '',
      args: [],
    );
  }

  /// `Cost Ascending`
  String get costAscending {
    return Intl.message(
      'Cost Ascending',
      name: 'costAscending',
      desc: '',
      args: [],
    );
  }

  /// `Cost Descending`
  String get costDescending {
    return Intl.message(
      'Cost Descending',
      name: 'costDescending',
      desc: '',
      args: [],
    );
  }

  /// `Destruction a Product`
  String get destructionAProduct {
    return Intl.message(
      'Destruction a Product',
      name: 'destructionAProduct',
      desc: '',
      args: [],
    );
  }

  /// `Destruction`
  String get destruction {
    return Intl.message(
      'Destruction',
      name: 'destruction',
      desc: '',
      args: [],
    );
  }

  /// `Cause Of Destruction`
  String get causeOfDestruction {
    return Intl.message(
      'Cause Of Destruction',
      name: 'causeOfDestruction',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Destruction Num`
  String get destructionNum {
    return Intl.message(
      'Destruction Num',
      name: 'destructionNum',
      desc: '',
      args: [],
    );
  }

  /// `Destructioned By`
  String get destructionBy {
    return Intl.message(
      'Destructioned By',
      name: 'destructionBy',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Product Data`
  String get productData {
    return Intl.message(
      'Product Data',
      name: 'productData',
      desc: '',
      args: [],
    );
  }

  /// `Destructioned At`
  String get destructionDate {
    return Intl.message(
      'Destructioned At',
      name: 'destructionDate',
      desc: '',
      args: [],
    );
  }

  /// `Add Role`
  String get addRole {
    return Intl.message(
      'Add Role',
      name: 'addRole',
      desc: '',
      args: [],
    );
  }

  /// `Buyer Name`
  String get buyerName {
    return Intl.message(
      'Buyer Name',
      name: 'buyerName',
      desc: '',
      args: [],
    );
  }

  /// `Sold At`
  String get saledAt {
    return Intl.message(
      'Sold At',
      name: 'saledAt',
      desc: '',
      args: [],
    );
  }

  /// `Sold By`
  String get SaledBy {
    return Intl.message(
      'Sold By',
      name: 'SaledBy',
      desc: '',
      args: [],
    );
  }

  /// `You will logout. Are You sure?`
  String get logOutMsg {
    return Intl.message(
      'You will logout. Are You sure?',
      name: 'logOutMsg',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Press again to exit!`
  String get PressagaintoExit {
    return Intl.message(
      'Press again to exit!',
      name: 'PressagaintoExit',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `SYP`
  String get syp {
    return Intl.message(
      'SYP',
      name: 'syp',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error occurred`
  String get unknownErrorOccurred {
    return Intl.message(
      'Unknown error occurred',
      name: 'unknownErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Pieces`
  String get pieces {
    return Intl.message(
      'Pieces',
      name: 'pieces',
      desc: '',
      args: [],
    );
  }

  /// `Enter Buyer Name`
  String get enterBuyerName {
    return Intl.message(
      'Enter Buyer Name',
      name: 'enterBuyerName',
      desc: '',
      args: [],
    );
  }

  /// `Easy, Secure and Organized`
  String get easySecureAndOrganized {
    return Intl.message(
      'Easy, Secure and Organized',
      name: 'easySecureAndOrganized',
      desc: '',
      args: [],
    );
  }

  /// `Your warehouse operations made easy, secure, and perfectly organized.`
  String get yourWarehouseOperationsMadeEasySecureAndPerfectlyOrganized {
    return Intl.message(
      'Your warehouse operations made easy, secure, and perfectly organized.',
      name: 'yourWarehouseOperationsMadeEasySecureAndPerfectlyOrganized',
      desc: '',
      args: [],
    );
  }

  /// `Full Support`
  String get fullSupport {
    return Intl.message(
      'Full Support',
      name: 'fullSupport',
      desc: '',
      args: [],
    );
  }

  /// `We're here for you with our 24/7 support team, always ready to lend a hand.`
  String get WeHereForYouWithOurSupportTeamAlwaysReadyToLendaHand {
    return Intl.message(
      'We\'re here for you with our 24/7 support team, always ready to lend a hand.',
      name: 'WeHereForYouWithOurSupportTeamAlwaysReadyToLendaHand',
      desc: '',
      args: [],
    );
  }

  /// `Order Anywhere`
  String get orderAnywhere {
    return Intl.message(
      'Order Anywhere',
      name: 'orderAnywhere',
      desc: '',
      args: [],
    );
  }

  /// `Place orders with ease, wherever you are, with just a few clicks.`
  String get PlaceOrdersWithEaseWhereveYouAreWithJustAFewClicks {
    return Intl.message(
      'Place orders with ease, wherever you are, with just a few clicks.',
      name: 'PlaceOrdersWithEaseWhereveYouAreWithJustAFewClicks',
      desc: '',
      args: [],
    );
  }

  /// `No worries, we'll send you reset instructions.`
  String get NoWorriesWeSendYouResetInstructions {
    return Intl.message(
      'No worries, we\'ll send you reset instructions.',
      name: 'NoWorriesWeSendYouResetInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Enter email`
  String get enterEmail {
    return Intl.message(
      'Enter email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the code sent to your email.`
  String get pleaseEnterTheCodeSentToYourEmail {
    return Intl.message(
      'Please enter the code sent to your email.',
      name: 'pleaseEnterTheCodeSentToYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continu {
    return Intl.message(
      'Continue',
      name: 'continu',
      desc: '',
      args: [],
    );
  }

  /// `Set New Password`
  String get setNewPassword {
    return Intl.message(
      'Set New Password',
      name: 'setNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 8 characters.`
  String get mustBeAtLeast8Characters {
    return Intl.message(
      'Must be at least 8 characters.',
      name: 'mustBeAtLeast8Characters',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enterNewPassword {
    return Intl.message(
      'Enter New Password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `All Done!`
  String get allDone {
    return Intl.message(
      'All Done!',
      name: 'allDone',
      desc: '',
      args: [],
    );
  }

  /// `Go to Login page`
  String get goToLoginPage {
    return Intl.message(
      'Go to Login page',
      name: 'goToLoginPage',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been reset successfully.`
  String get resetSuccessfully {
    return Intl.message(
      'Your password has been reset successfully.',
      name: 'resetSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message(
      'Add to Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Verify your email`
  String get verifyYourEmail {
    return Intl.message(
      'Verify your email',
      name: 'verifyYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Verified!`
  String get verified {
    return Intl.message(
      'Verified!',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `Your email has been successfully verified.`
  String get youremailhasbeensuccessfullyverified {
    return Intl.message(
      'Your email has been successfully verified.',
      name: 'youremailhasbeensuccessfullyverified',
      desc: '',
      args: [],
    );
  }

  /// `Go to Home Page`
  String get gotoHomePage {
    return Intl.message(
      'Go to Home Page',
      name: 'gotoHomePage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Verification Required`
  String get verificationRequired {
    return Intl.message(
      'Verification Required',
      name: 'verificationRequired',
      desc: '',
      args: [],
    );
  }

  /// `We've noticed that your email is not verified with us.`
  String get WeNoticedThatYourEmailIsNotVerifiedWithUs {
    return Intl.message(
      'We\'ve noticed that your email is not verified with us.',
      name: 'WeNoticedThatYourEmailIsNotVerifiedWithUs',
      desc: '',
      args: [],
    );
  }

  /// `Please take a moment to verify your account.`
  String get pleaseTakeAMomentToVerifyYourAccount {
    return Intl.message(
      'Please take a moment to verify your account.',
      name: 'pleaseTakeAMomentToVerifyYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Get Verification Email`
  String get getVerificationEmail {
    return Intl.message(
      'Get Verification Email',
      name: 'getVerificationEmail',
      desc: '',
      args: [],
    );
  }

  /// `Cart Details`
  String get cartDetails {
    return Intl.message(
      'Cart Details',
      name: 'cartDetails',
      desc: '',
      args: [],
    );
  }

  /// `Number Of Products`
  String get numberOfProducts {
    return Intl.message(
      'Number Of Products',
      name: 'numberOfProducts',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get totalPrice {
    return Intl.message(
      'Total Price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Check Out`
  String get checkOut {
    return Intl.message(
      'Check Out',
      name: 'checkOut',
      desc: '',
      args: [],
    );
  }

  /// `Swap to Refresh`
  String get swapToRefresh {
    return Intl.message(
      'Swap to Refresh',
      name: 'swapToRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Somthing Went Wrong`
  String get somthingWentWrong {
    return Intl.message(
      'Somthing Went Wrong',
      name: 'somthingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection and try again.`
  String get checkYourInternetConnectionAndTryAgain {
    return Intl.message(
      'Check your internet connection and try again.',
      name: 'checkYourInternetConnectionAndTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Sale Order Details`
  String get saleDetails {
    return Intl.message(
      'Sale Order Details',
      name: 'saleDetails',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Banned`
  String get banned {
    return Intl.message(
      'Banned',
      name: 'banned',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Barcode Number`
  String get barcode {
    return Intl.message(
      'Barcode Number',
      name: 'barcode',
      desc: '',
      args: [],
    );
  }

  /// `Enter Barcode Number..`
  String get enterBarcode {
    return Intl.message(
      'Enter Barcode Number..',
      name: 'enterBarcode',
      desc: '',
      args: [],
    );
  }

  /// `Edit Shipping Company`
  String get editShippingCompany {
    return Intl.message(
      'Edit Shipping Company',
      name: 'editShippingCompany',
      desc: '',
      args: [],
    );
  }

  /// `Cheaper Than`
  String get cheaperThan {
    return Intl.message(
      'Cheaper Than',
      name: 'cheaperThan',
      desc: '',
      args: [],
    );
  }

  /// `More exoensive than`
  String get moreExpensive {
    return Intl.message(
      'More exoensive than',
      name: 'moreExpensive',
      desc: '',
      args: [],
    );
  }

  /// `expired`
  String get expired {
    return Intl.message(
      'expired',
      name: 'expired',
      desc: '',
      args: [],
    );
  }

  /// `valid`
  String get valid {
    return Intl.message(
      'valid',
      name: 'valid',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Manufacturer Name..`
  String get enterManufacturerName {
    return Intl.message(
      'Enter Manufacturer Name..',
      name: 'enterManufacturerName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Category Name`
  String get enterCategoryName {
    return Intl.message(
      'Enter Category Name',
      name: 'enterCategoryName',
      desc: '',
      args: [],
    );
  }

  /// `expire after`
  String get expireAfter {
    return Intl.message(
      'expire after',
      name: 'expireAfter',
      desc: '',
      args: [],
    );
  }

  /// `expire before`
  String get expireBefore {
    return Intl.message(
      'expire before',
      name: 'expireBefore',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
