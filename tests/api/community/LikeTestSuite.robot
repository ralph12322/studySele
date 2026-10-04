***Settings***
Documentation       Basic Test Suite for the Like path, every edge cases, positive
...                 and negative cases, will be test here. Used Resource file as well
...                 to act like a global Keywords.

Library         String

Resource         ../../../resources/api_keywords.resource
Test Setup     Create Session  api     ${BASE_URL}     disable_warnings=1
Test Teardown  Delete All Sessions

***Variables***
${POST_ID}          6abf00e30195158de469125f

# Paths Variables
${BASE_URL}         https://teampayaman.vercel.app
${LIKE_PATH}        /api/community/posts/${POST_ID}/like

# Credential Variables
&{VALID_CREDENTIALS}        email=ralphgeosantos.dev@gmail.com      password=qwer12322


***Keywords***
Generate Random Valid PostId
    ${id}=    Generate Random String     24      [NUMBERS]abcdef
    RETURN      ${id}      

Like Request
    ${resp}         POST on Session     api        ${LIKE_PATH}     expected_status=any
    RETURN      ${resp}

Dislike Request
    ${resp}         DELETE on Session     api        ${LIKE_PATH}       expected_status=any
    RETURN      ${resp}


***Test Cases***
# Positive Test Cases
Like Test with Loggedin User
    [Tags]  smoke   positive
    ${res}      Signin Request     ${VALID_CREDENTIALS}
    Status Should Be    200     ${res}
    ${resp}     Like Request
    Should Be True     ${resp.ok}
    
Dislike Test with Loggedin User
    [Tags]  smoke   positive
    ${res}      Signin Request     ${VALID_CREDENTIALS}
    Status Should Be    200     ${res}
    ${resp}     Dislike Request
    Should Be True     ${resp.ok}

# Negative Test Cases
Like Test Without Loggedin User Returns 401
    [Tags]  smoke   negative
    ${resp}     Like Request
    Status Should Be        401        ${resp}

Dislike Test Without Loggedin User Returns 401
    [Tags]  smoke   negative
    ${resp}     Dislike Request
    Status Should Be        401        ${resp}

Like Test With Invalid ObjectID for Post Returns 400
    [Documentation]        Should return 400 since it doesn't satisfy the condition as a Object Id
    ...                    in MongoDB. And always remember for Tests regarding non 200 status should always
    ...                    include expected_status.
    [Tags]  edge    negative
    ${res}      Signin Request     ${VALID_CREDENTIALS}
    Status Should Be    200     ${res}
    ${malformed_id}     Generate Random String     23      [NUMBERS]abcdef
    ${resp}     POST On Session     api     /api/community/posts/${malformed_id}/like       expected_status=any
    Status Should Be        400         ${resp}

Like Test With Non Existing Post Id Returns 404
    [Documentation]        Should return 404 since the Object Id passed is not found in Database.
    [Tags]  edge    negative
    ${res}      Signin Request     ${VALID_CREDENTIALS}
    Status Should Be    200     ${res}
    ${fake_id}=    Generate Random Valid PostId
    ${resp}=    POST On Session    api    /api/community/posts/${fake_id}/like    expected_status=any
    Status Should Be    404    ${resp}