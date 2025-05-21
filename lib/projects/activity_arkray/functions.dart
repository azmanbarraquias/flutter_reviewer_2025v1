
/*
  ======================================
  NOTE: SAMPLE CODE USE AS REFERENCE ^_^
  ======================================
*/
import 'constants.dart' as constants;

/// Print Map
String reference() {
  String displayString = '' ;
  displayString = ''
    'First Name   : ${constants.sample['FIRST_NAME']}\n'
    'Middle Name  : ${constants.sample['MIDDLE_NAME']}\n'
    'Last Name    : ${constants.sample['LAST_NAME']}\n'
  ;

  return displayString;
}

/*
  =====================================
  [PHASE1]: Practice Starts HERE ^_^
  =====================================
*/
/// Practice 1
String p1() {
  // For new line add \n
  //
  // Using the [variable_1] variable
  // display the name in this format
  // LAST_NAME, FIRST_NAME MIDDLE INITIAL
  // Each name should only be capitalized on the first character
  // eg: (Dela Cruz, Juan B.)

  String displayString = '';

  return displayString;
}

/// Practice 2: (Display of Strings)
String p2() {
  // For new line add \n
  //
  // Using the [variable_1] variable
  // Display all the [CONTACT_NUMBERS] of the user
  // following this format
  // Name: FIRST_NAME
  // Contact No(#): contact_number
  //
  // eg:
  // Name: Juan
  // Contact No(1): 099123124123
  // Contact No(2): 099123124123
  // Contact No(3): 099123124123

  String displayString = '';

  return displayString;
}

/// Practice 3: (Display of List of Json Objects)
String p3() {
  // For new line add \n
  //
  // Using the [variable_1] variable
  // Display all the [ADDRESS_LIST] of the user
  // following this format
  // Name: FIRST_NAME
  // Address(1): NUMBER STREET, BARANGAY, CITY, PROVINCE, REGION
  //
  // eg:
  // Name: Juan
  // Address(1): Blk 1 Lot 1 Sampaloc Street, Barangay Sample, City of Sample, Province of Sample, Sample Region
  // Address(2): Blk 1 Lot 1 Sampaloc Street, Barangay Sample, City of Sample, Province of Sample, Sample Region
  // Address(3): Blk 1 Lot 1 Sampaloc Street, Barangay Sample, City of Sample, Province of Sample, Sample Region
  // Address(4): Blk 1 Lot 1 Sampaloc Street, Barangay Sample, City of Sample, Province of Sample, Sample Region

  String displayString = '';

  return displayString;
}

/// Practice 4: (Accessing list in a map)
String p4() {
  // For new line add \n
  //
  // Using the [variable_2] variable
  // Display the NAME of the first User
  // Display the NAME of the last User
  // Display the NAME of the 3rd User
  //
  // eg:
  // FIRST USER: Lyle, Alton M.
  // LAST USER: Deandra, Condon B.
  // 3RD USER: Cameron, Samuel D.

  String displayString = '';

  return displayString;
}

/// Practice 5: (Accessing list in a map)
String p5() {
  // For new line add \n
  //
  // Using the [variable_2] variable
  // Display the NAME of the first User with their 1st contact no
  // Display the NAME of the last User with their 2nd contact no
  // Display the NAME of the 3rd User with their last contact no
  //
  // eg:
  // FIRST USER: Lyle, Alton M. Contact #: 09912312412
  // LAST USER: Deandra, Condon B. Contact #: 09912312412
  // 3RD USER: Cameron, Samuel D. Contact #: 09912312412

  String displayString = '';

  return displayString;
}

/// Practice 6: (Accessing Map in List In Map In List in Map)
String p6() {
  // For new line add \n
  //
  // Using the [variable_2] variable
  // Display the NAME of the first User with their 1st address
  // Display the NAME of the last User with their 2nd address
  // Display the NAME of the 3rd User with their last address
  //
  // eg:
  // FIRST USER: Lyle, Alton M. Contact
  // FIRST USER 1ST ADDRESS: Blk 1 Lot 1 Sample1 Street, Barangay1, City1, Province1, Region1
  //
  // SECOND USER: Gwyneth, Douglass B. Contact
  // SECOND USER 2ND ADDRESS: Blk 2 Lot 2 Sample2 Street, Barangay2, City2, Province2, Region2
  //
  // THIRD USER: Lexus, Stoll A. Contact
  // THIRD USER LAST ADDRESS: Blk Last Lot Last SampleLast Street, BarangayLast, CityLast, ProvinceLast, RegionLast

  String displayString = '';

  return displayString;
}

/// Practice 7: (Accessing and Find Map in List In Map In List in Map)
String p7() {
  // For new line add \n
  //
  // Using the [variable_2] variable
  // Display the NAME of the first User with their [IS_CURRENT] current address
  // Display the NAME of the last User with their [IS_CURRENT] current address
  // Display the NAME of the 3rd User with their [IS_CURRENT] current address
  //
  // eg:
  // FIRST USER: Lyle, Alton M. Contact
  // FIRST USER 1ST ADDRESS: Blk 1 Lot 1 Sample1 Street, Barangay1, City1, Province1, Region1
  //
  // SECOND USER: Gwyneth, Douglass B. Contact
  // SECOND USER 2ND ADDRESS: Blk 2 Lot 2 Sample2 Street, Barangay2, City2, Province2, Region2
  //
  // THIRD USER: Lexus, Stoll A. Contact
  // THIRD USER LAST ADDRESS: Blk Last Lot Last SampleLast Street, BarangayLast, CityLast, ProvinceLast, RegionLast

  String displayString = '';

  return displayString;
}

/*
  =====================================
  [PHASE2]: Practice Starts HERE ^_^
  =====================================
*/
/// Practice 8: (Listing of JSON object and filtering of List of JSON Object)
String p8() {
  // For new line add \n
  //
  // Using the [variable_2] variable
  // Display all the [MEMBERSHIPS] information
  // with their corresponding users and
  // display NONE if no user is found
  // MEMBERSHIP(1): MEMBERSHIP_NAME (MEMBERSHIP_CODE)
  // USER(1): LAST_NAME, FIRST NAME MI
  //
  // eg:
  // MEMBERSHIP(1): Membership 1 (MEMBERSHIP_CODE1)
  // USER(1): Samuel, Giordano N.
  // USER(2): Dakota, Destin A.
  // USER(3): Popp, Bingham P.
  //
  // MEMBERSHIP(2): Membership 2 (MEMBERSHIP_CODE2)
  // USER(1): Lyle, Matheny N.
  // USER(2): Popp, Bingham P.
  //
  // MEMBERSHIP(3): Membership 3 (MEMBERSHIP_CODE3)
  // NONE

  String displayString = '';

  return displayString;
}

/// Practice 9: (Listing of JSON object and filtering and Sorting of List of JSON Object)
String p9() {
  // For new line add \n
  //
  // Using the [variable_2] variable
  // Display all the [MEMBERSHIPS] information
  // with their sorted corresponding users and
  // display NONE if no user is found
  // MEMBERSHIP(1): MEMBERSHIP_NAME (MEMBERSHIP_CODE)
  // USER(1): LAST_NAME, FIRST NAME MI
  //
  // eg:
  // MEMBERSHIP(1): Membership 1 (MEMBERSHIP_CODE1)
  // USER(1): Dakota, Destin A.
  // USER(2): Popp, Bingham P.
  // USER(3): Samuel, Giordano N.
  //
  // MEMBERSHIP(2): Membership 2 (MEMBERSHIP_CODE2)
  // USER(1): Lyle, Matheny N.
  // USER(2): Popp, Bingham P.
  //
  // MEMBERSHIP(3): Membership 3 (MEMBERSHIP_CODE3)
  // NONE

  String displayString = '';

  return displayString;
}

/// Practice 10: (Listing of JSON object and Sorting of List of JSON Object)
String p10() {
  // For new line add \n
  //
  // Using the [variable_2] variable
  // Display all the [MEMBERSHIPS] information
  // with their sorted corresponding users and their first contact number
  // NOTE: display NONE if no user is found
  // MEMBERSHIP(1): MEMBERSHIP_NAME (MEMBERSHIP_CODE)
  // USER(1): LAST_NAME, FIRST NAME MI
  //
  // eg:
  // MEMBERSHIP(1): Membership 1 (MEMBERSHIP_CODE1)
  // USER(1): Dakota, Destin A.
  //   > CONTACT #(1): 09912312412
  // USER(2): Popp, Bingham P.
  //   > CONTACT #(1): 09922312412
  // USER(3): Samuel, Giordano N.
  //   > CONTACT #(1): 09932312412
  //
  // MEMBERSHIP(2): Membership 2 (MEMBERSHIP_CODE2)
  // USER(1): Lyle, Matheny N.
  //   > CONTACT #(1): 09912312412
  // USER(2): Popp, Bingham P.
  //   > CONTACT #(2): 09922312412
  //
  // MEMBERSHIP(3): Membership 3 (MEMBERSHIP_CODE3)
  // NONE

  String displayString = '';

  return displayString;
}

/// Practice 11: (Listing of JSON object and filtering and Sorting of List of JSON Object)
String p11() {
  // For new line add \n
  //
  // Using the [variable_2] variable
  // Display all the [MEMBERSHIPS] information
  // with their sorted corresponding users and current address
  // NOTE: display NONE if no user is found
  // MEMBERSHIP(1): MEMBERSHIP_NAME (MEMBERSHIP_CODE)
  // USER(1): LAST_NAME, FIRST NAME MI
  //
  // eg:
  // MEMBERSHIP(1): Membership 1 (MEMBERSHIP_CODE1)
  // USER(1): Dakota, Destin A.
  //   > ADDRESS(1): Blk 1 Lot 1 Sample1 Street, Barangay1, City1, Province1, Region1
  // USER(2): Popp, Bingham P.
  //   > ADDRESS(2): Blk 2 Lot 2 Sample2 Street, Barangay2, City2, Province2, Region2
  // USER(3): Samuel, Giordano N.
  //   > ADDRESS(3): Blk 3 Lot 3 Sample3 Street, Barangay3, City3, Province3, Region3
  //
  // MEMBERSHIP(2): Membership 2 (MEMBERSHIP_CODE2)
  // USER(1): Lyle, Matheny N.
  //   > ADDRESS(1): Blk 1 Lot 1 Sample1 Street, Barangay1, City1, Province1, Region1
  // USER(3): Popp, Bingham P.
  //   > ADDRESS(2): Blk 2 Lot 2 Sample2 Street, Barangay2, City2, Province2, Region2
  //
  // MEMBERSHIP(3): Membership 3 (MEMBERSHIP_CODE3)
  // NONE

  String displayString = '';

  return displayString;
}


/// https://tinyurl.com/yb3ettuk