*** Settings ***
Library         ../../library/CustomKeywords.py
Library         String
Test Setup      Open Portfolio  ${URL}
Test Teardown    Close Browser

*** Keywords ***
Generate Random Email
    ${local}=    Generate Random String    12    [LOWER][NUMBERS]
    RETURN    ${local}@gmail.com


*** Variables ***
${URL}  https://teampayaman.vercel.app/sign
${validMail}    ralphgeosantos.dev@gmail.com    
${validPass}    qwer12322
&{mock_fields}     name=sample      password=Qwer12322?


*** Test Cases ***
Login is Valid
    Perform Valid Login    ${validMail}    ${validPass}

Login with Wrong Email and Valid Password
    Perform Invalid Login    sampleinvalid@gmail.com    ${validPass}


Login with Wrong Password and Valid Email
    Perform Invalid Login   ${validMail}    invalidpassword

Login with Wrong Password and Email
    Perform Invalid Login   sampleinvalid@gmail.com    invalidpassword

# Negative test case for Login is also done by Manual testing since i made all the form fields required.
# The test can be done by manual testing, if it involves submitting empty fields.

Signup is Valid
    ${UNIQUE_MAIL}      Generate Random Email
    Perform Valid Signup    sample name    ${UNIQUE_MAIL}    Qwer12322?

Signup is Invalid The User Already Exist
    Perform Invalid Signup      ${mock_fields}[name]     ${validMail}   ${mock_fields}[password]

# Negative cases includes Empty fields done by manual testing since i made all the 
# fields in form required.
# And also made the email field required to have @gmail.com so those test case 
# involves invalid mails is done by manual testing as well.
