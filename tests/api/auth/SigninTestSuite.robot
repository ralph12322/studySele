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
${BASE_URL}     https://teampayaman.vercel.app
${SIGNIN_PATH}      /api/auth/login

*** Keywords ***
Signin Request
    [Arguments]   &{body}
    ${res}      POST on Session     api     ${SIGNIN_PATH}      json=${body}    expected_status=any
    RETURN      ${res}


*** Test Cases ***

#  Positive Test Cases Valid Path
Login with Valid Credentials
    [Tags]  smoke   positive
    ${resp}     Signin Request    email=ralphgeosantos.dev@gmail.com      password=qwer12322
    Status Should Be    200     ${resp}
    Should Be Equal     ${resp.json()}[message]     Login successful

Signin Sets HttpOnly Auth Cookie
    [Tags]    smoke  positive   security
    ${resp}=    Signin Request    email=ralphgeosantos.dev@gmail.com    password=qwer12322
    Status Should Be    200    ${resp}
    ${set_cookie}=    Get From Dictionary    ${resp.headers}    Set-Cookie
    Should Contain    ${set_cookie}    authToken
    Should Contain    ${set_cookie}    HttpOnly
    Should Contain    ${set_cookie}    Path=/
    Should Contain    ${set_cookie}    Max-Age=604800
    Should Contain    ${set_cookie}    SameSite=lax    ignore_case=True


#   Negative Test Cases
Login with empty fields
    [Tags]  smoke   negative    all_empty
    ${resp}     Signin Request    email=      password=
    Status Should Be    400     ${resp}
    Should Be Equal     ${resp.json()}[error]   Missing email or password

Login With Empty Email
    [Tags]  smoke   negative    empty_email
    ${resp}     Signin Request      email=      password=qwer12322
    Status Should Be    400     ${resp}
    Should Be Equal     ${resp.json()}[error]       Missing email or password

Login With Empty Password
    [Tags]  smoke   negative    empty_email
    ${resp}     Signin Request      email=ralphgeosantos.dev@gmail.com      password=
    Status Should Be    400     ${resp}
    Should Be Equal     ${resp.json()}[error]       Missing email or password

Login With Correct Email Incorrect Password
    [Tags]  smoke   negative    one_incorrect
    ${resp}     Signin Request      email=ralphgeosantos.dev@gmail.com      password=incorrectpassword
    Status Should Be    401     ${resp}
    Should Be Equal     ${resp.json()}[error]       Invalid email or password

Login With Correct Password Incorrect Email
    [Tags]  smoke   negative    one_incorrect
    ${resp}     Signin Request      email=incorrectemail@gmail.com      password=qwer12322
    Status Should Be    401     ${resp}
    Should Be Equal     ${resp.json()}[error]       Invalid email or password

