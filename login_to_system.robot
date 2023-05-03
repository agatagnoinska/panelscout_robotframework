*** Settings ***
Library                     SeleniumLibrary
Documentation               Suite description #automated tests for scout website
*** Variables ***
${LOGIN URL}                https://scouts-test.futbolkolektyw.pl/en
${BROWSER}                  Chrome
${EMAILINPUT}               xpath = //*[@id='login']
${PASSWORDINPUT}            xpath = //*[@id='password']
${SIGNINBUTTON}             xpath = //*[@id="__next"]/form/div/div[2]/button
${DASHBOARDTITLE}           //*[@id="__next"]/div[1]/header/div/h6
${VALIDATIONWRONGLOGIN}     xpath = //div/div[1]/div[3]/span
${LANGUAGEDROPDOWN}         xpath = //*[@aria-haspopup='listbox']
${LANGUAGEPOLISHBUTTON}     xpath = //*[@data-value='pl']
${PASSWORDLABEL}            xpath = //*[@id="password-label"]
${ADDNEWPLAYERBUTTON}       xpath = //div[2]/div/div/a/button
${EDITPLAYERPAGEHEADER}     xpath = //form/div[1]/div/span
${NAMEINPUT}                xpath = //*[@name="name"]
${SURNAMEINPUT}             xpath = //*[@name="surname"]
${AGEINPUT}                 xpath = //*[@name="age"]
${MAINPOSITIONINPUT}        xpath = //*[@name="mainPosition"]
${SUBMITBUTTON}             xpath = //*[@type="submit"]
${PLAYERINSIDEPANEL}        xpath = //ul[2]/div[1]/div[2]/span
${CLEARBUTTON}              xpath = //button[2]/span[1]
${SIGNOUTBUTTON}            xpath = //div/div/div/ul[2]/div[2]
${LOGINPAGETITLE}           xpath = /html/head/title
*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert dashboards
    [Teardown]    Close Browser
Login to the system with invalid email
    Open login page
    Type in an invalid email
    Type in password
    Click on the Sign in button
    Assert validation
    [Teardown]    Close Browser
Change language of Login Page
    Open login page
    Click on the dropdown
    Click on the Polish language
    Assert translation
Add a new player
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Click on the Add player button
    Type in name
    Type in surname
    Type in age
    Type in main position
    Click on the Submit button
    Assert Edit page
Clear button on add player page
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Click on the Add player button
    Type in name
    Click on clear button
    Assert name
Log out
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Click on the Sign out button
    Assert log out page

*** Keywords ***
Open login page
    Open Browser                     ${LOGIN URL}    ${BROWSER}
    Title Should Be                  Scouts panel - sign in
Type in email
    Input Text                       ${EMAILINPUT}              user07@getnada.com
Type in password
    Input Text                       ${PASSWORDINPUT}           Test-1234
Click on the Sign in button
    Click Element                    ${SIGNINBUTTON}
Assert dashboards
    Wait Until Element Is Visible    ${DASHBOARDTITLE}
    Title Should Be                  Scouts panel
    Capture Page Screenshot          alert.png
Type in an invalid email
    Input Text                       ${EMAILINPUT}              user01@ge
Assert validation
    Wait Until Element Is Visible    ${VALIDATIONWRONGLOGIN}
    Element Text Should Be           ${VALIDATIONWRONGLOGIN}   Identifier or password invalid.
    Capture Page Screenshot          invalidlogin.png
Click on the dropdown
    Wait Until Element Is Visible    ${LANGUAGEDROPDOWN}
    Click Element                    ${LANGUAGEDROPDOWN}
Click on the Polish language
    Wait Until Element Is Visible    ${LANGUAGEPOLISHBUTTON}
    Click Element                    ${LANGUAGEPOLISHBUTTON}
Assert translation
    Wait Until Element Is Visible    ${PASSWORDLABEL}
    Element Text Should Be           ${PASSWORDLABEL}          Hasło
    Capture Page Screenshot          polish.png
Click on the Add player button
    Wait Until Element Is Visible    ${ADDNEWPLAYERBUTTON}
    Click Element                    ${ADDNEWPLAYERBUTTON}
Type in name
    Wait Until Element Is Visible    ${NAMEINPUT}
    Input Text                       ${NAMEINPUT}             Adam
Type in surname
    Input Text                       ${SURNAMEINPUT}          Nawałka
Type in age
    Input Text                       ${AGEINPUT}              12121988
Type in main position
    Input Text                       ${MAINPOSITIONINPUT}     strzelec
Click on the Submit button
    Click Element                    ${SUBMITBUTTON}
Assert Edit page
    Wait Until Element Contains      ${PLAYERINSIDEPANEL}   Adam
    Element Text Should Be           ${PLAYERINSIDEPANEL}   Adam Nawałka
    Capture Page Screenshot          adding.png
Click on clear button
    Click Element                    ${CLEARBUTTON}
Assert name
    Element Text Should Not Be       ${NAMEINPUT}           Adam
Click on the Sign out button
    Wait Until Element Is Visible    ${SIGNOUTBUTTON}
    Click Element                    ${SIGNOUTBUTTON}
Assert log out page
    Wait Until Element Is Visible    ${LOGINPAGETITLE}
    Title Should Be                  Scouts panel - sign in
    Capture Page Screenshot          logout.png