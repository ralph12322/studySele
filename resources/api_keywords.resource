***Settings***
Library         RequestsLibrary


***Variables***
${LOGIN_PATH}       /api/auth/login


***Keywords***
Signin Request
    [Arguments]     ${body}
    ${resp}         POST on Session       api        ${LOGIN_PATH}        json=${body}        expected_status=200
    RETURN     ${resp}
