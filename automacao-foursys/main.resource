*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     String


*** Variables ***
${URL}                          https://ibkmobileqa.safra.com/Safraofficebank/frmlogin.aspx
${BROWSER}                      chrome


*** Keywords ***
Open the browser
    Open Browser    browser=${BROWSER}
    Maximize Browser Window

Close the browser
    Close Browser

