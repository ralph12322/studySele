*** Settings ***
Library     Collections
Library     RequestsLibrary

Suite Setup    Create Session    api    ${URL}
*** Keywords ***

*** Variables ***
${URL}    https://teampayaman.vercel.app/
${SIGNIN_PATH}    /api/login
${SIGNUP_PATH}    /api/signup

*** Test Cases ***
Positive Login Test
    ${response}    POST On Session    api ${SIGNIN_PATH}
    Should Be Equal As Integers    ${response.status_code}    201


