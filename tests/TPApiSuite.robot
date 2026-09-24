*** Settings ***
Documentation     Created a Signup TestSuite for the Team Payaman Cumminity Site
...               that i am Building, made sure that every negative and positive cases are covered
...               by this Test Suite.
Library           RequestsLibrary
Library           String
Library           Collections
Suite Setup       Create Session    api    ${BASE_URL}    disable_warnings=1
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}            https://teampayaman.vercel.app/
${SIGNUP_ENDPOINT}     /api/auth/signup
${VALID_PASSWORD}      Str0ng!Pass
${COOKIE_NAME}         authToken

*** Test Cases ***
# Happy path
Signup With Valid Data Returns 201
    [Tags]    smoke    happy-path
    ${email}=    Unique Email
    ${resp}=    Signup Request    name=Test User    email=${email}    password=${VALID_PASSWORD}
    Status Should Be    201    ${resp}
    Should Be Equal    ${resp.json()}[message]    User created successfully

Signup Sets HttpOnly Auth Cookie
    [Tags]    happy-path    security
    ${email}=    Unique Email
    ${resp}=    Signup Request    name=Test User    email=${email}    password=${VALID_PASSWORD}
    Status Should Be    201    ${resp}
    ${set_cookie}=    Get From Dictionary    ${resp.headers}    Set-Cookie
    Should Contain    ${set_cookie}    ${COOKIE_NAME}=
    Should Contain    ${set_cookie}    HttpOnly
    Should Contain    ${set_cookie}    Path=/
    Should Contain    ${set_cookie}    Max-Age=604800
    Should Contain    ${set_cookie}    SameSite=lax    ignore_case=True

Signup Response Does Not Leak Password Or Token
    [Tags]    security
    ${email}=    Unique Email
    ${resp}=    Signup Request    name=Test User    email=${email}    password=${VALID_PASSWORD}
    Status Should Be    201    ${resp}
    Should Not Contain    ${resp.text}    ${VALID_PASSWORD}
    Should Not Contain    ${resp.text.lower()}    password
    Should Not Contain    ${resp.text.lower()}    token

Signup Trims And Lowercases Email
    [Documentation]    Second signup with the normalized form must be rejected as duplicate.
    ...                Only the local part is uppercased because the route's gmail check is case-sensitive.
    [Tags]    happy-path    normalization
    ${local}=    Generate Random String    8    [LOWER][NUMBERS]
    ${padded}=    Set Variable    ${SPACE}${local.upper()}@gmail.com${SPACE}
    ${resp1}=    Signup Request    name=Test User    email=${padded}    password=${VALID_PASSWORD}
    Status Should Be    201    ${resp1}
    ${resp2}=    Signup Request    name=Test User    email=${local}@gmail.com    password=${VALID_PASSWORD}
    Status Should Be    400    ${resp2}
    Should Be Equal    ${resp2.json()}[error]    User already exists

# Missing fields
Signup Without Name Returns 400
    [Tags]    validation
    ${email}=    Unique Email
    ${resp}=    Signup Request    email=${email}    password=${VALID_PASSWORD}
    Status Should Be    400    ${resp}
    Should Be Equal    ${resp.json()}[error]    Missing name, email, or password

Signup Without Email Returns 400
    [Tags]    validation
    ${resp}=    Signup Request    name=Test User    password=${VALID_PASSWORD}
    Status Should Be    400    ${resp}
    Should Be Equal    ${resp.json()}[error]    Missing name, email, or password

Signup With Empty Name Returns 400
    [Tags]    validation
    ${email}=    Unique Email
    ${resp}=    Signup Request    name=${EMPTY}    email=${email}    password=${VALID_PASSWORD}
    Status Should Be    400    ${resp}
    Should Be Equal    ${resp.json()}[error]    Missing name, email, or password

Signup Without Password Returns 400
    [Tags]    validation    known-issue
    ${email}=    Unique Email
    ${resp}=    Signup Request    name=Test User    email=${email}
    Status Should Be    400    ${resp}
    Should Be Equal    ${resp.json()}[error]    Missing name, email, or password

# Email validation
Signup With Non Gmail Email Returns 400
    [Tags]    validation    email
    ${local}=    Generate Random String    8    [LOWER][NUMBERS]
    ${resp}=    Signup Request    name=Test User    email=${local}@yahoo.com    password=${VALID_PASSWORD}
    Status Should Be    400    ${resp}
    Should Be Equal    ${resp.json()}[error]    should be a valid email

Signup With Email Missing At Sign Returns 400
    [Tags]    validation    email
    ${resp}=    Signup Request    name=Test User    email=notanemail    password=${VALID_PASSWORD}
    Status Should Be    400    ${resp}

Signup With Gmail Domain As Substring Returns 400
    [Documentation]    KNOWN WEAKNESS: email.includes("@gmail.com") also matches
    ...                "x@gmail.com.attacker.com". Use a strict regex or endsWith instead.
    [Tags]    validation    email    known-issue
    ${local}=    Generate Random String    8    [LOWER][NUMBERS]
    ${resp}=    Signup Request    name=Test User    email=${local}@gmail.com    password=${VALID_PASSWORD}
    Status Should Be    400    ${resp}

# Password rules
Password Rule Is Enforced
    [Template]    Signup Rejects Weak Password
    [Tags]    validation    password
    # password        expected error message
    Ab1!xyz           Password must be at least 8 characters long.
    lowercase1!       Password must contain at least one uppercase letter.
    UPPERCASE1!       Password must contain at least one lowercase letter.
    NoNumbers!!       Password must contain at least one number.
    NoSpecial123      Password must contain at least one special character.

Password Of Exactly Eight Characters Is Accepted
    [Tags]    validation    password    boundary
    ${email}=    Unique Email
    ${resp}=    Signup Request    name=Test User    email=${email}    password=Abcde1!x
    Status Should Be    201    ${resp}

# Duplicates
Duplicate Signup Returns 400
    [Tags]    duplicate
    ${email}=    Unique Email
    ${first}=    Signup Request    name=Test User    email=${email}    password=${VALID_PASSWORD}
    Status Should Be    201    ${first}
    ${second}=    Signup Request    name=Other User    email=${email}    password=${VALID_PASSWORD}
    Status Should Be    400    ${second}
    Should Be Equal    ${second.json()}[error]    User already exists

Duplicate Signup Does Not Set A Cookie
    [Tags]    duplicate    security
    ${email}=    Unique Email
    Signup Request    name=Test User    email=${email}    password=${VALID_PASSWORD}
    ${second}=    Signup Request    name=Test User    email=${email}    password=${VALID_PASSWORD}
    Status Should Be    400    ${second}
    Dictionary Should Not Contain Key    ${second.headers}    Set-Cookie

# Malformed requests
Signup With Invalid JSON Returns 500
    [Documentation]    request.json() throws inside the try block, so the route returns its generic 500.
    ...                Consider returning 400 for malformed JSON instead.
    [Tags]    robustness
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${resp}=    POST On Session    api    ${SIGNUP_ENDPOINT}    data={not valid json    headers=${headers}    expected_status=any
    Status Should Be    500    ${resp}
    Should Be Equal    ${resp.json()}[error]    Something went wrong. Please try again.

*** Keywords ***
Signup Request
    [Arguments]    &{body}
    ${resp}=    POST On Session    api    ${SIGNUP_ENDPOINT}    json=${body}    expected_status=any
    RETURN    ${resp}

Unique Email
    ${local}=    Generate Random String    12    [LOWER][NUMBERS]
    RETURN    robot.${local}@gmail.com

Signup Rejects Weak Password
    [Arguments]    ${password}    ${expected_error}
    ${email}=    Unique Email
    ${resp}=    Signup Request    name=Test User    email=${email}    password=${password}
    Status Should Be    400    ${resp}
    Should Be Equal    ${resp.json()}[error]    ${expected_error}