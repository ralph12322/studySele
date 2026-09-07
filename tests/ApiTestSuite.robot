*** Settings ***
Library    RequestsLibrary
Library    Collections

Suite Setup    Create Session    api    ${URL}

*** Variables ***
${URL}    https://jsonplaceholder.typicode.com
${todo_path1}    /todos/1
${users_path}    /users

*** Test Cases ***
Verify Todo Endpoint
    [Tags]    api    smoke
    [Documentation]    This just basically Verifies if the api endpoint is working nothing much
    ${response}=    GET On Session    api    ${todo_path1}
    Should Be Equal As Strings     ${response.status_code}    200
    ${res}=    Set Variable    ${response.json()}
    Should Not Be True    ${res}[completed]
    Log    ${response.json()}

Verify Users Endpoint
    [Tags]    api    smoke
    [Documentation]    This basically verifies if the api endpoint works then Logs every user
    ${response}=    GET On Session    api    ${users_path}
    Should Be Equal As Strings    ${response.status_code}    200
    ${res}=    Set Variable    ${response.json()}
    FOR    ${user}    IN    @{res}
        Log    ${user}
    END
    
