*** Settings ***
Library         ../../library/CustomKeywords.py
Library         String
Test Setup      Open Portfolio  ${URL}
Test Teardown    Close Browser

*** Keywords ***
Generate Random Email
    ${local}=    Generate Random String    12    [LOWER][NUMBERS]
    RETURN    robot.${local}@gmail.com


*** Variables ***
${URL}  https://teampayaman.vercel.app/sign
${validMail}    ralphgeosantos.dev@gmail.com    
${validPass}    qwer12322
&{mock_fields}     name=sample      password=Qwer12322?


*** Test Cases ***
Login is Valid
    Perform Valid Login    ${validMail}    ${validPass}

Login is Invalid
    Perform Invalid Login    sampleinvalid@gmail.com    12345

Signup is Valid
    ${UNIQUE_MAIL}      Generate Random Email
    Perform Valid Signup    sample name    ${UNIQUE_MAIL}    Qwer12322?

Signup is Invalid The User Already Exist
    Perform Invalid Signup      ${mock_fields}[name]     ${validMail}   ${mock_fields}[password]

#Negative cases includes Empty fields done by manual testing since i made all the fields in form required