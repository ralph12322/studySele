***Settings***
Documentation            Created a resource file for keywords that i will use across other files.

Library         RequestsLibrary


***Variables***
${LOGIN_PATH}       /api/auth/login


***Keywords***
Signin Request
    [Arguments]     ${body}
    ${resp}         POST on Session       api        ${LOGIN_PATH}        json=${body}        expected_status=200
    RETURN     ${resp}
