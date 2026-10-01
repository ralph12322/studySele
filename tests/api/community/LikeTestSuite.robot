***Settings***
Resource         ../../../resources/api_keywords.resource

Suite Setup     Create Session  api     ${BASE_URL}     disable_warnings=1
Suite Teardown  Delete All Sessions

***Variables***
${POST_ID}          6abe1d55400ad962e6ff708d
${BASE_URL}         https://teampayaman.vercel.app
&{VALID_CREDENTIALS}        email=ralphgeosantos.dev@gmail.com      password=qwer12322


***Test Cases***

Like Test
    ${res}      Signin Request     ${VALID_CREDENTIALS}
    Status Should Be    200     ${res}

