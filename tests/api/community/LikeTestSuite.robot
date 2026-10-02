***Settings***
Resource         ../../../resources/api_keywords.resource
Suite Setup     Create Session  api     ${BASE_URL}     disable_warnings=1
Suite Teardown  Delete All Sessions

***Variables***
${POST_ID}          6abe1d55400ad962e6ff708d
${BASE_URL}         https://teampayaman.vercel.app
${POST_ID}          6abf00e30195158de469125f
${LIKE_PATH}        /api/community/posts/${POST_ID}/like
&{VALID_CREDENTIALS}        email=ralphgeosantos.dev@gmail.com      password=qwer12322


***Keywords***
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

Like Test Without Loggedin User
    [Tags]  smoke   negative
    ${resp}     Like Request
    Status Should Be        401        ${resp}

Dislike Test Without Loggedin User
    [Tags]  smoke   negative
    ${resp}     Dislike Request
    Status Should Be        401        ${resp}



