*** Settings ***
Library     ../library/CustomKeywords.py
Test Setup      Open Portfolio  ${URL}

*** Keywords ***


*** Variables ***
${URL}  https://teampayaman.vercel.app/

*** Test Cases ***
Open site
    Redirect