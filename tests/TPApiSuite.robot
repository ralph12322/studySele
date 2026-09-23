*** Settings ***
Library     Collections
Library     RequestsLibrary

Suite Setup    Create Session    api    ${URL}
*** Keywords ***

*** Variables ***
${URL}    https://teampayaman.vercel.app/
${SIGNIN_PATH}    /api/auth/login
${SIGNUP_PATH}    /api/auth/signup
&{POSITIVE_CREDENTIALS}    email=ralphgeosantos.dev@gmail.com    password=qwer12322
&{NEGATIVE_CREDENTIALS}    email=invalidmail@gmail.com    password=qwer12322

*** Test Cases ***
Positive Login Test
    ${response}    POST On Session    api    ${SIGNIN_PATH}    json=${POSITIVE_CREDENTIALS}
    Should Be Equal As Integers    ${response.status_code}    200

Negative Login Test
    ${response}    POST On Session    api    ${SIGNIN_PATH}    json=${NEGATIVE_CREDENTIALS}    expected_status=401
    Should Be Equal As Integers    ${response.status_code}    401
