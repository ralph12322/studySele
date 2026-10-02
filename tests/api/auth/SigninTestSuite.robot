*** Settings ***
Documentation     Created a Signin TestSuite for the Team Payaman Cumminity Site
...               that i am Building, made sure that every negative and positive cases are covered
...               by this Test Suite.

Library     Collections
Library     String
Library     RequestsLibrary

Suite Setup     Create Session  api     ${BASE_URL}     disable_warnings=1
Suite Teardown  Delete All Sessions

*** Variables ***
&{VALID_CREDENTIALS}        email=ralphgeosantos.dev@gmail.com      password=qwer12322
${BASE_URL}     https://teampayaman.vercel.app
${SIGNIN_PATH}      /api/auth/login
${LOGOUT_PATH}      /api/auth/logout

*** Keywords ***
Signin Request
    [Arguments]   ${body}
    ${res}      POST on Session     api     ${SIGNIN_PATH}      json=${body}    expected_status=any
    RETURN      ${res}

Logout Request
    ${res}      POST on Session     api     ${LOGOUT_PATH}      expected_status=200
    RETURN      ${res}


*** Test Cases ***

# Logout Test Case
Logout Test Case
    [Tags]    smoke
    ${resp}     Signin Request    ${VALID_CREDENTIALS}
    Status Should Be    200     ${resp}
    Should Be Equal     ${resp.json()}[message]     Login successful
    ${resp}     Logout Request
    Dictionary Should Not Contain Key    ${resp.headers}    Set-Cookie
    
#  Positive Test Cases Valid Path
Login with Valid Credentials
    [Tags]  smoke   positive
    ${resp}     Signin Request    ${VALID_CREDENTIALS}
    Status Should Be    200     ${resp}
    Should Be Equal     ${resp.json()}[message]     Login successful

Signin Sets HttpOnly Auth Cookie
    [Tags]    smoke  positive   security
    ${resp}=    Signin Request    ${VALID_CREDENTIALS}
    Status Should Be    200    ${resp}
    ${set_cookie}=    Get From Dictionary    ${resp.headers}    Set-Cookie
    Should Contain    ${set_cookie}    authToken
    Should Contain    ${set_cookie}    HttpOnly
    Should Contain    ${set_cookie}    Path=/
    Should Contain    ${set_cookie}    Max-Age=604800
    Should Contain    ${set_cookie}    SameSite=lax    ignore_case=True


#   Negative Test Cases
Login with empty fields
    [Documentation]     Signs in With All the fields Empty, which falls under the first validation
    ...                 regarding truthiness of all fields (should not be empty)
    [Tags]  smoke   negative    all_empty
    &{INVALID_CREDENTIALS}      Create Dictionary      email=          password=
    ${resp}     Signin Request    ${INVALID_CREDENTIALS}
    Status Should Be    400     ${resp}
    Should Be Equal     ${resp.json()}[error]   Missing email or password

Login With Empty Email
    [Tags]  smoke   negative    empty_email
    &{INVALID_CREDENTIALS}      Create Dictionary      email=      password=qwer12322
    ${resp}     Signin Request      ${INVALID_CREDENTIALS}     
    Status Should Be    400     ${resp}
    Should Be Equal     ${resp.json()}[error]       Missing email or password

Login With Empty Password
    [Tags]  smoke   negative    empty_email
    &{INVALID_CREDENTIALS}       Create Dictionary      email=ralphgeosantos.dev@gmail.com      password=
    ${resp}     Signin Request      ${INVALID_CREDENTIALS}
    Status Should Be    400     ${resp}
    Should Be Equal     ${resp.json()}[error]       Missing email or password

Login With Correct Email Incorrect Password
    [Tags]  smoke   negative    one_incorrect
    &{INVALID_CREDENTIALS}          Create Dictionary        email=ralphgeosantos.dev@gmail.com      password=incorrectpassword
    ${resp}     Signin Request      ${INVALID_CREDENTIALS}
    Status Should Be    401     ${resp}
    Should Be Equal     ${resp.json()}[error]       Invalid email or password

Login With Correct Password Incorrect Email
    [Tags]  smoke   negative    one_incorrect
    &{INVALID_CREDENTIALS}      Create Dictionary       email=incorrectemail@gmail.com      password=qwer12322
    ${resp}     Signin Request      ${INVALID_CREDENTIALS}
    Status Should Be    401     ${resp}
    Should Be Equal     ${resp.json()}[error]       Invalid email or password

