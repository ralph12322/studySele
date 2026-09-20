*** Settings ***
Library     ../library/CustomKeywords.py
Test Setup      Open Portfolio  ${URL}
Test Teardown    Close Browser

*** Keywords ***


*** Variables ***
${URL}  https://teampayaman.vercel.app/sign
${validMail}    ralphgeosantos.dev@gmail.com    
${validPass}    qwer


*** Test Cases ***
Login is Valid
    Perform Valid Login    ${validMail}    ${validPass}

Login is Invalid
    Perform Invalid Login    sampleinvalid@gmail.com    12345

Signup is Valid
    Perform Valid Signup    sample name    samplevalid@gmail.com    qwer

Signup is Invalid
    Perform Invalid Signup    ""    ""    ""