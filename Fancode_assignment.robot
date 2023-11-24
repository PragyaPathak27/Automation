*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${BASE_URL}            http://jsonplaceholder.typicode.com
${FANCODE_CITY_LAT}   -40 to 5
${FANCODE_CITY_LONG}  5 to 100

*** Test Cases ***
Verify User Task Completion Percentage
    [Documentation]    Ensure users in the FanCode city have completed more than 50% of their todos.
    ${users}    Get Users In FanCodeCity
    FOR    ${user}    IN    @{users}
        ${todos}    Get User Todos    ${user}[id]
        ${completed_tasks}    Get Completed Tasks    ${todos}
        ${total_tasks}    Get Length    ${todos}
        ${completion_percentage}    Calculate Completion Percentage    ${completed_tasks}    ${total_tasks}
        Should Be True    ${completion_percentage} > 50
    END

*** Keywords ***
#Get Users In FanCode City
#    ${params}    Create Dictionary    city=FanCode
#    ${url}    Set Variable    http://jsonplaceholder.typicode.com/users
#    ${response}    Get     ${url}    params=${params}
#    ${users}    Set Variable    ${response.json()}
#    [Return]    ${users}

Get Users In FanCodeCity
    ${response}    Get     ${BASE_URL}/users
    ${users}    Set Variable    ${response.json()}
    ${fancode_city_users}    Create List
    FOR    ${user}    IN    @{users}
        ${lat}    Set Variable    ${user['address']['geo']['lat']}
        ${long}    Set Variable    ${user['address']['geo']['lng']}
        ${is_fancode_city}    Run Keyword And Return Status    Check FanCode City    ${lat}    ${long}
        Run Keyword If    ${is_fancode_city}    Append To List    ${fancode_city_users}    ${user}
    END
    [Return]    ${fancode_city_users}

Check FanCode City
    [Arguments]    ${lat}    ${long}
    ${is_fancode_city}    Run Keyword If    (${FANCODE_CITY_LAT} >= ${lat} >= 5) AND (${FANCODE_CITY_LONG} >= ${long} >= 100)    Return From Keyword    ${True}
    [Return]    ${False}


Get User Todos
    [Arguments]    ${user_id}
    ${params}    Create Dictionary    userId=${user_id}
    ${response}    Get      http://jsonplaceholder.typicode.com/todos    params=${params}
    ${todos}    Set Variable    ${response.json()}
    [Return]    ${todos}

Get Completed Tasks
    [Arguments]    ${todos}
    ${completed_tasks}    Evaluate    len([item for item in ${todos} if item['completed'] == ${True}])
    [Return]    ${completed_tasks}



Get Length
    [Arguments]    ${todos}
    ${length}    Evaluate    len([item for item in "${todos}"])
    [Return]    ${length}

Calculate Completion Percentage
    [Arguments]    ${completed_tasks}    ${total_tasks}
    ${percentage}    Evaluate    ${completed_tasks} / ${total_tasks} * 100
    [Return]    ${percentage}


