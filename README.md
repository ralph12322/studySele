# Overview

I am done studying Robot Framework, and being aware of the difference and similarities of puppeteer and selenium so that i can use selenium with it's full potential and also done refreshing my knowledge with python specially with Object Oriented Programming and now i will create tons of projects and test my skills everyday. Starting today Day 1;



## Day 1: 

Testing my own Portfolio: with basic selenium functionalities and libraries;

## Day 2: 

Done with my First Test Case 

## Day 3:

Made a Test Suite with 3 Test Cases regarding Opening the Portfolio then Testing the Navigation Buttons;
Testing the Toggle Light/Dark Mode;
and Verifying if the Resume Link is Completely Working;

And all Passed the Test Suite

## Day 4:

Made a Field Checker; Makes Sure that every Data possess the Necessary Fields

;;  Maybe i'll build something first then i'll automate the testing myself, that's my next plan.

# Day 5: I Failed my Assessment Exam as a QA 

It is really heartbreaking for me, I am hoping to get the job since someone is helping me out even though i'm new to the position.


# Day 6: polished the sign page and some minor details. sign page almost ready for testing. 

Tomorrow  i will polish everything in Sign module, i put frontend validation and backend validation, so i have to test both api and the frontend validations.

### Stopped Counting the days, since sometimes i am not able to code due to Church and School Proctoring and Teachings. Currently Done with my Robust Login and Signup Feature for the TEAM PAYAMAN COMMUNITY SITE and already made a Test Suite for it 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Checklist

##  UIs:
Test Suites Checklist for all the Test via UI by categories:

###   Log in
- Positive Test Cases
    - [x] Login With Valid Credentials
    - [x] Signin Sets HttpOnly Auth Cookie
    - [x] Login With Valid Credentials
    - [x] Signin Sets HttpOnly Auth Cookie

- Negative Test Cases
    - [x] Login With Valid Credentials
    - [x] Signin Sets HttpOnly Auth Cookie
    - [x] Login With Valid Credentials
    - [x] Signin Sets HttpOnly Auth Cookie

###   Sign up
- Positive Test Cases
    - [x] Login With Valid Credentials
    - [x] Signin Sets HttpOnly Auth Cookie

- Negative Test Cases
    - [x] Login With Valid Credentials
    - [x] Signin Sets HttpOnly Auth Cookie



##  APIs:
Test Checklist for all the Test for Apis by categories:

###   Log in
- Positive Test Cases
    - [x] Login With Valid Credentials
    - [x] Signin Sets HttpOnly Auth Cookie

- Negative Test Cases
    - [x] Login with empty fields
    - [x] Login With Empty Email
    - [x] Login With Empty Password
    - [x] Login With Correct Email Incorrect Password
    - [x] Login With Correct Password Incorrect Email

###   Sign up
- Positive Test Cases
    - [x] Signup With Valid Data Returns 201
    - [x] Signup Sets HttpOnly Auth Cookie
    - [x] Signup Response Does Not Leak Password Or Token
    - [x] Signup Trims And Lowercases Email

- Negative Test Cases
    - [x] Signup Without Name Returns 400
    - [x] Signup Without Email Returns 400
    - [x] Signup With Empty Name Returns 400
    - [x] Signup Without Password Returns 400
    - [x] Signup With Non Gmail Email Returns 400
    - [x] Signup With Email Missing At Sign Returns 400
    - [x] Signup With Gmail Domain As Substring Returns 400


###   Like Path
- Positive Test Cases
    - [x] Like Test with Loggedin User
    - [x] Dislike Test with Loggedin User


- Negative Test Cases
    - [x] Like Test Without Loggedin User
    - [x] Dislike Test Without Loggedin User


###   Comment Path
- Positive Test Cases
    - [x] Login With Valid Credentials
    - [x] Login With Valid Credentials
    - [x] Login With Valid Credentials


- Negative Test Cases
    - [x] Login With Valid Credentials
    - [x] Login With Valid Credentials
    - [x] Login With Valid Credentials
