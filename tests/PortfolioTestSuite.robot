*** Settings ***
Library    ../library/CustomKeywords.py
Test Setup    Open Portfolio    ${URL}
Test Teardown    Close Browser

*** Variables ***
${URL}=     https://deralph.vercel.app/

*** Test Cases ***

Open Portfolio and Verify Nav Buttons
    [Tags]    navbuttons
    [Documentation]    Opens the portfolio site and clicks through nav buttons
    Click Nav Buttons

Test Toggle Light and Dark Mode
    [Tags]    toggle
    [Documentation]    Test the toggle Light and Dark Mode
    Switch To Light Mode
    Switch To Dark Mode

Verify Resume Linking
    [Tags]    link
    [Documentation]    Verifies that the resume button is working
    Opens the Resume