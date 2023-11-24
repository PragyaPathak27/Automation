
Title: Fancode Assignment

Scenario:All the users of City `FanCode` should have more than half of their todos task completed.

Setup: Create a new file Fancode_Assignment in Pycharm.

Add PIP package using command pip install robotframeworkand pip install robotframework-requests to install required packages.

File Structure: /Automation
               -main
                 -Fancode_Assignment.robot
                 -README.md

Libraries used- Requestslibrary, Collections and String

Testing Approach:

First, the apis will be triggered and tested manually in order to understand the functionality of the api.

Once the apis have been evaluated manually we will automate them based on the requirement.

Steps:
Trigger /users api in postman and validate response with total users their id, city and tasks.
<img width="1440" alt="Screenshot 2023-11-24 at 7 30 34 PM" src="https://github.com/PragyaPathak27/Automation/assets/151938664/9d54ac4e-b943-44d4-955f-daa3301d852a">
Trigger /todos api in postman and validate the number of tasks.
<img width="1436" alt="Screenshot 2023-11-24 at 7 31 12 PM" src="https://github.com/PragyaPathak27/Automation/assets/151938664/d53d2ce7-a721-4d0b-8962-01886c017e44">
Once apis have been reviewed manually, we will automate the scenario.
Use command robot Fancode_assignment.robot to run the code.

Scope of Improvement:
Currently, keywords and variables have been added in single file. However, in future in order to improve code utilisation we can create seaparte files for keywords and variables.
