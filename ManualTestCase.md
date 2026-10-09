
###   Log in
- Negative Test Cases
    - [x] Login With Empty Email and a Valid Password
        - Test Case Id: TC-001
        - Test Case Name: Login With Empty Email
        - Requirement: The field requires email address to Login
        - Use Case: User Logs in
        - Priority: High
        - Preconditions: Email Textfield should have a property 'required=true'
        - Test Data: email: (empty)     password=qwer12322
        - Test Steps:
            1. Go to /sign 
            2. Select Login from the toggle
            3. Leave the Email field empty and type the password in the Password field.
            4. Click Submit
        - Expected Result: 'required' warning should show beside the email field and the Login should not proceed.
        - Actual Result: 'required' warning showed and the Login Function did not proceed.
        - Status: Passed
        - Remarks: 

    - [] Login With Empty Password and a Valid Email
        - Test Case Id: TC-002
        - Test Case Name: Login With Empty Email
        - Requirement: The field requires email address to Login
        - Use Case: User Logs in
        - Priority: High
        - Preconditions: Email Textfield should have a property 'required=true'
        - Test Data: email: (empty)     password=qwer12322
        - Test Steps:
            1. Go to /sign 
            2. Select Login from the toggle
            3. Leave the Email field empty and type the password in the Password field.
            4. Click Submit
        - Expected Result: 'required' warning should show beside the email field and the Login should not proceed.
        - Actual Result: 'required' warning showed and the Login Function did not proceed.
        - Status: Passed
        - Remarks: 

    - [] Login With Empty Email and Password
        - Test Case Id: TC-003
        - Test Case Name: Login With Empty Email
        - Requirement: The field requires email address to Login
        - Use Case: User Logs in
        - Priority: High
        - Preconditions: Email Textfield should have a property 'required=true'
        - Test Data: email: (empty)     password=qwer12322
        - Test Steps:
            1. Go to /sign 
            2. Select Login from the toggle
            3. Leave the Email field empty and type the password in the Password field.
            4. Click Submit
        - Expected Result: 'required' warning should show beside the email field and the Login should not proceed.
        - Actual Result: 'required' warning showed and the Login Function did not proceed.
        - Status: Passed
        - Remarks: 


###   Sign up
- Positive Test Cases
    - [x] Login With Valid Credentials
    - [x] Signin Sets HttpOnly Auth Cookie

- Negative Test Cases
    - [x] Login With Valid Credentials
    - [x] Signin Sets HttpOnly Auth Cookie
