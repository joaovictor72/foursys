*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     String

Resource            main.resource


*** Variables ***
## LOGIN
${USERNAME}                     automationtest
${PASSWORD}                     1
${ANSWER}                       1
${USERNAME_FIELD}               id=txtUserName
${PASSWORD_FIELD}               id=txtPassword
${ANSWER_FIELD}                 id=txtAnswerQuestion1
${btn_Ok}                       id=btnContinue
${btn_Login}                    id=btnLogin

## NAVIGATION
${nav_bank_account}             id=ctl00_OfficeBankPrivateContentPlaceHolder_lbSnb
${nav_accounts}                 //a[@href='#'][contains(.,'Accounts')]
${nav_bank}                     //a[@href='/SafraOfficeBank/accounts/frmAccountsSummary.aspx?AccountType=SNBNY'][contains(.,'Bank')]
${nav_bank_accounts}            //div[@class='accordion-title'][contains(.,'Bank Accounts')]
${nav_cash_accounts}            //div[@class='accordion-title'][contains(.,'Cash Accounts')]
${link_personal_checking}       //a[@href='DDA/frmDDADetail.aspx?Values=2a1IE56hUjqFkJCbqkvt9canDB5xq3FHhLFOyHJeUCOxIY7F62QFLw%2flk1n8ifqQOhq1CNBNVDH0%2feHv7YDsttDbDmgx3Zd9WduLjg39UoyE1T8516LVPUOf3G%2b324%2fmv9ICjgFh7pT4eCyOEj5d%2bm3kBem%2bBYZN'][contains(.,'Personal Checking - Domestic')]
${link_cd_regular}              //a[@href='CD/frmCDDetail.aspx?Values=2a1IE56hUjqR3iwUcl3luJzfaC5EoxEB0PvOgkCbeagf%2f%2fqEN5BkqihJr4NjSLkdruoxm43%2bvyydzduxputcYQ%2b%2bvBk0V8JINCrXavaCcdV7YrSiMdpgT4vY0mFDTT6JTrGdAs1zuLU%3d'][contains(.,'CD Regular - Foreign')]
${info_personal_checking}       (//td[contains(@align,'left')])[1]
${info_cd_regular}              (//td[contains(@align,'left')])[2]
${account_checking_number}      id=ctl00_OfficeBankPrivateContentPlaceHolder_lblAcctNumberValue
${cd_regular_number}            id=ctl00_OfficeBankPrivateContentPlaceHolder_lblTitleValue


*** Keywords ***

Log in to SafraLink Web
    Go To    url=${URL}
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Click Button    ${btn_Ok}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Button    ${btn_Login}
    ${current_url}=    Get Location
    ${is_authentication_page}=    Run Keyword And Return Status    Should Be Equal As Strings    ${current_url}    https://ibkmobileqa.safra.com/Safraofficebank/frmLoginStep2.aspx
    Run Keyword If    ${is_authentication_page}    Input Text    ${ANSWER_FIELD}    ${ANSWER}
    Run Keyword If    ${is_authentication_page}    Click Button    ${btn_Ok}

Access top menu
    Mouse Over       ${nav_accounts}
    Click Element    ${nav_bank}
    Click Element    ${nav_bank_accounts}
    Sleep    2s
    Click Element    ${nav_cash_accounts}
    Sleep    2s

Access via home
    Click Element    ${nav_bank_account}
    Click Element    ${nav_bank_accounts}
    Sleep    2s
    Click Element    ${nav_cash_accounts}
    Sleep    2s

 Validate Personal Checking
    ${personal_checking_info}=    Get Text    ${info_personal_checking}
    Log    ${personal_checking_info}
    Click Element    ${link_personal_checking}
    ${acct_number}=    Get Text    ${account_checking_number}
    Log    ${acct_number}
    Should Be Equal As Strings    ${personal_checking_info}    ${acct_number}

 Validate CD Regular
    ${cd_regular_info}=    Get Text    ${info_cd_regular}
    Log    ${cd_regular_info}
    Click Element    ${link_cd_regular}
    ${cd_regular_number_text}=    Get Text    ${cd_regular_number}
    ${cd_regular_number}=    Get Substring    ${cd_regular_number_text}    0    7
    Log    ${cd_regular_number}
    Should Be Equal As Strings    ${cd_regular_info}    ${cd_regular_number}