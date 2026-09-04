*** Settings ***
Library    ../library/CustomKeywords.py


*** Variables ***
${URL}=     https://deralph.vercel.app/

*** Test Cases ***

TestCase1

    Open Portfolio    ${URL}
    Click Nav Buttons
