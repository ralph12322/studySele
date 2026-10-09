
###   Log in
- Negative Test Cases
    - [x] Login With Empty Email
        - Test Case Id: TC-001
        - Test Case Name: Login With Empty Email
        - Requirement: Displays a warning in email field 'Required' and will not proceed with the Login
        - Use Case: Go to /sign Page select Login then input data
        - Priority: High
        - Preconditions: Email Textfield should have a property 'required=true'
        - Test Data: email=      password=qwer12322
        - Test Steps:
            1. Go to /sign 
            2. Select Login from the toggle
            3. Input the Test Data with respect to fields
            4. Click Submit
        - Expected Result: 'required' warning should show beside the email field and the Login should not proceed.
        - Actual Result: 'required' warning showed and the Login Function did not proceed.
        - Remarks: 
        
         

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
