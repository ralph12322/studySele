*** Settings ***
Documentation       Test Automation for all Comment related Functionalities, 
...                 manual testing should go to ManualTestCase.md file

Library             String
Library             RequestsLibrary
Resource            ../../../resources/api_keywords.resource

Test Setup          Create Session      api     ${BASE_URL}     disable_warnings=1
Suite Teardown      Delete All Sessions


*** Keywords ***
Random Post Id
    ${local}=        Generate Random String    24       [NUMBERS][LETTERS]
    RETURN      ${local}

Random Comment Id
    ${local}=        Generate Random String    24       [NUMBERS][LETTERS]
    RETURN      ${local}


*** Variables ***
${BASE_URL}         https://teampayaman.vercel.app
${VALID_POST_ID}    6ac77d9e24ef665d69deb101

&{VALID_CREDENTIALS}        email=ralphgeosantos.dev@gmail.com      password=qwer12322



*** Test Cases ***
# Positive Tests
Valid Comment With Valid Post Id and User
    [Documentation]     Positive Test Case, Just use the Sample Account for testing and used a random generated
    ...                 Text from the Random Post Id Keyword. [Valid User, Valid Text, Valid Post ID]
    [Tags]      smoke   valid

    ${Random_Text}      Random Post Id
    &{body}             Create Dictionary      text=${Random_Text}
    ${COMMENT_PATH}     Set Variable       /api/community/posts/${VALID_POST_ID}/comments
    ${res}              Signin Request      ${VALID_CREDENTIALS}
    Status Should Be        200     ${res}
    ${resp}             POST on Session     api     ${COMMENT_PATH}         json=${body}
    Should Be True      ${resp.ok}     



