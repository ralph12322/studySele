
###   Log in
- Negative Test Cases
    - [x] Login With Empty Email and a Valid Password
        - Test Case Id: TC-login-001
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

    - [x] Login With Empty Password and a Valid Email
        - Test Case Id: TC-Login-002
        - Test Case Name: Login With Empty Password
        - Requirement: The field requires password
        - Use Case: User Logs in
        - Priority: High
        - Preconditions: Password Textfield should have a property 'required=true'
        - Test Data: email: ralphgeosantos.dev@gmail.com     password= (empty)
        - Test Steps:
            1. Go to /sign 
            2. Select Login from the toggle
            3. Fill the email field with the test data and leave the password empty
            4. Click Submit
        - Expected Result: 'required' warning should show beside the password field and the Login should not proceed.
        - Actual Result: 'required' warning showed beside the password field and the Login Function did not proceed.
        - Status: Passed
        - Remarks: 

    - [x] Login With Empty Email and Password
        - Test Case Id: TC-Login-003
        - Test Case Name: Login With Empty Email and Password
        - Requirement: The field requires both email and password
        - Use Case: User Logs in
        - Priority: High
        - Preconditions: Email and Password Textfield should have a property 'required=true'
        - Test Data: email: (empty)     password= (empty)
        - Test Steps:
            1. Go to /sign 
            2. Select Login from the toggle
            3. Leave the Email and password field empty
            4. Click Submit
        - Expected Result: 'required' warning should show beside the email and password field and the Login should not proceed.
        - Actual Result: 'required' warning showed beside email and password field and the Login Function did not proceed.
        - Status: Passed
        - Remarks: 


###   Sign up
- Negative Test Cases
    - [x] Signup with the name only empty with everything else valid
        - Test Case Id: TC-Signup-001
        - Test Case Name: Signup with valid fields but the name being empty
        - Requirement: The field requires name
        - Use Case: User Signs up
        - Priority: High
        - Preconditions: Name Textfield should have a property 'required=true'
        - Test Data: name: (empty)  email: validemail@gmail.com    password:Qwer12322?      confirmPassword: Qwer12322?
        - Test Steps:
            1. Go to /sign 
            2. Select Signup from the toggle
            3. Leave the Name field empty and fill the other fields with the test data
            4. Click Submit
        - Expected Result: 'required' warning should show beside the name field and the Signup should not proceed.
        - Actual Result: 'required' warning showed beside name field and the Signup Function did not proceed.
        - Status: Passed
        - Remarks: 

    - [x] Signup with the email only empty with everything else valid
        - Test Case Id: TC-Signup-002
        - Test Case Name: Signup with valid fields but the email being empty
        - Requirement: The field requires email
        - Use Case: User Signs up
        - Priority: High
        - Preconditions: Email Textfield should have a property 'required=true'
        - Test Data: name: Valid Name  email: (empty)    password:Qwer12322?      confirmPassword: Qwer12322?
        - Test Steps:
            1. Go to /sign 
            2. Select Signup from the toggle
            3. Leave the Email field empty and fill the other fields with the test data
            4. Click Submit
        - Expected Result: 'required' warning should show beside the email field and the Signup should not proceed.
        - Actual Result: 'required' warning showed beside email field and the Signup Function did not proceed.
        - Status: Passed
        - Remarks: 

    - [x] Signup with the password only empty with everything else valid
        - Test Case Id: TC-Signup-003
        - Test Case Name: Signup with valid fields but the password being empty
        - Requirement: The field requires password
        - Use Case: User Signs up
        - Priority: High
        - Preconditions: Password Textfield should have a property 'required=true'
        - Test Data: name: Valid Name  email: validemail@gmail.com    password: (empty)      confirmPassword: Qwer12322?
        - Test Steps:
            1. Go to /sign 
            2. Select Signup from the toggle
            3. Leave the Password field empty and fill the other fields with the test data
            4. Click Submit
        - Expected Result: 'required' warning should show beside the password field and the Signup should not proceed.
        - Actual Result: 'required' warning showed beside password field and the Signup Function did not proceed.
        - Status: Passed
        - Remarks: 

    - [x] Signup with the Confirmpassword only empty with everything else valid
        - Test Case Id: TC-Signup-004
        - Test Case Name: Signup with valid fields but the Confirmpassword being empty
        - Requirement: The field requires confirmPassword
        - Use Case: User Signs up
        - Priority: High
        - Preconditions: confirmPassword Textfield should have a property 'required=true'
        - Test Data: name: Valid Name  email: validemail@gmail.com    password: (empty)      confirmPassword: Qwer12322?
        - Test Steps:
            1. Go to /sign 
            2. Select Signup from the toggle
            3. Leave the confirmPassword field empty and fill the other fields with the test data
            4. Click Submit
        - Expected Result: 'required' warning should show beside the confirmPassword field and the Signup should not proceed.
        - Actual Result: 'required' warning showed beside confirmPassword field and the Signup Function did not proceed.
        - Status: Passed
        - Remarks: 

    - [x] Signup with all fields empty
        - Test Case Id: TC-Signup-005
        - Test Case Name: Signup with all fields empty
        - Requirement: The field requires name, email, password and confirmPassword
        - Use Case: User Signs up
        - Priority: High
        - Preconditions: all Textfield should have a property 'required=true'
        - Test Data: name: (empty)  email: (empty)    
        password: (empty)      confirmPassword: (empty)
        - Test Steps:
            1. Go to /sign 
            2. Select Signup from the toggle
            3. Leave all the fields empty
            4. Click Submit
        - Expected Result: 'required' warning should show beside all the fields and the Signup should not proceed.
        - Actual Result: 'required' warning showed beside all fields and the Signup Function did not proceed.
        - Status: Passed
        - Remarks: 