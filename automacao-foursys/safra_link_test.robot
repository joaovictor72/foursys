*** Settings ***
Library             SeleniumLibrary
Resource            main.resource
Resource            safra_link_keywords.robot

Test Setup          Open the browser
Test Teardown       Close the browser


*** Test Cases ***
Log in to SafraLink Web:
    Log in to SafraLink Web

Access top menu Personal Checking
    Log in to SafraLink Web
    Access top menu
    Validate Personal Checking

Access top menu CD Regular
    Log in to SafraLink Web
    Access top menu
    Validate CD Regular

Access via home Personal Checking
    Log in to SafraLink Web
    Access via home
    Validate Personal Checking

Access via home CD Regular
    Log in to SafraLink Web
    Access via home
    Validate CD Regular
