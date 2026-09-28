*** Settings ***
Documentation       Created a simple Test for the Channel info of
...                 Cong Tv, to make sure it is working properly.

Library             Collections
Library             RequestsLibrary

Suite Setup         Create Session       api     ${BASE_URL}    disable_warnings=1  


***Variables***
${BASE_URL}         https://teampayaman.vercel.app
${INFO_PATH}        /api/info

&{SAMPLE_RETURN}    sample=sample   sampling=sampling

***Keywords***
Info Get Request
    ${res}     GET on Session      api     ${INFO_PATH}
    RETURN      ${res}

***Test Cases***
Get Channel Info Should Return status 200
    ${resp}     Info Get Request
    Status Should Be        200
    