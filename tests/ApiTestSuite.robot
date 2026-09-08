*** Settings ***
Library    RequestsLibrary
Library    Collections

Suite Setup    Create Session    api    ${URL}

*** Variables ***
#Api Paths and URL
${URL}    https://jsonplaceholder.typicode.com
${todo_path1}    /todos/1
${users_path}    /users
${post_path}    /posts

#List and Objects of fields for Json
@{EXPECTED_USER_FIELDS}    id    name    username    email    address    phone    website    company
@{EXPECTED_ADDRESS_FIELDS}    street    suite    city    zipcode    geo
@{EXPECTED_GEO_FIELDS}    lat    lng
@{EXPECTED_COMPANY_FIELDS}    name    catchPhrase    bs
&{SAMPLE}    userId=1    id=1    title=Sample Title    body=Sample body for this post

*** Test Cases ***
Verify Todo Endpoint
    [Tags]    api    smoke
    [Documentation]    This just basically Verifies if the api endpoint is working nothing much

    ${response}=    GET On Session    api    ${todo_path1}
    Should Be Equal As Integers     ${response.status_code}    200
    ${res}=    Set Variable    ${response.json()}
    Should Not Be True    ${res}[completed]
    Log    ${response.json()}

Verify Users Endpoint
    [Tags]    api    smoke
    [Documentation]    Verifies every user in the response contains all expected top-level and nested fields.

    ${response}=    GET On Session    api    ${users_path}
    Should Be Equal As Integers    ${response.status_code}    200
    ${res}=    Set Variable    ${response.json()}

    FOR    ${user}    IN    @{res}
        FOR    ${field}    IN    @{EXPECTED_USER_FIELDS}
            Dictionary Should Contain Key    ${user}    ${field}
            ...    msg=User ${user}[id] is missing field '${field}'
        END

        FOR    ${field}    IN    @{EXPECTED_ADDRESS_FIELDS}
            Dictionary Should Contain Key    ${user}[address]    ${field}
            ...    msg=User ${user}[id] address is missing field '${field}'
        END

        FOR    ${field}    IN    @{EXPECTED_GEO_FIELDS}
            Dictionary Should Contain Key    ${user}[address][geo]    ${field}
            ...    msg=User ${user}[id] geo is missing field '${field}'
        END

        FOR    ${field}    IN    @{EXPECTED_COMPANY_FIELDS}
            Dictionary Should Contain Key    ${user}[company]    ${field}
            ...    msg=User ${user}[id] company is missing field '${field}'
        END
    END

Verify Post Api
    [Tags]    api    smoke
    [Documentation]    Verifies POST /posts creates a resource and returns the expected fields.
    ${response}=    POST On Session    api    ${post_path}    json=${SAMPLE}
    Should Be Equal As Integers    ${response.status_code}    201

    ${res}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${res}    id
    Should Be Equal As Integers    ${res}[userId]    1
    Should Be Equal As Strings    ${res}[title]    Sample Title 
    Should Be Equal As Strings    ${res}[body]    Sample body for this post