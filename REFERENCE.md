# Robot Framework Test Automation – Execution Guide
This project contains automated UI tests written using **Robot Framework**.
---
##  Prerequisites
Make sure the following are installed on your system:
- Python **3.9+**
- pip
- Google Chrome (for UI tests)
- ChromeDriver (matching your Chrome version) and added to PATH

Check versions:
```bash
python --version
pip --version
robot --version
```

### Setup (First Time Only)
1. Clone the Repository `git clone https://github.com/testAccountForLearningAll/DefinityRj.git`
2. cd DefinityRj

### Create and Activate Virtual Environment
```bash
python -m venv venv
venv\Scripts\activate
```
### Install Dependencies
`pip install -r requirements.txt`

## Execute Robot Files Using Var File Based on Environment
Environment-specific values (URL, username, password, etc.) are stored in Python variable files.
and can Configure Your Own Username & Password
Location: `resources/variables/environment/`
Example files: 
`qa2.py
 qa.py
 stage1.py`
If you want to use your own credentials, update the corresponding env file.
Example: qa2.py
```python
HCS = {
    "url":  "https://qa2.example.com/signin",
    "user": "your.username@example.com",
    "pass": "YourPasswordHere"
}

MYDEF = {
    "url":  "https://qa2.example.com",
    "user": "your.username@example.com",
    "pass": "YourPasswordHere"
}
```

If needed, create your own local env file like: `qa2_local.py`
and run tests using:
`robot --variablefile resources/variables/environment/qa2_local.py --outputdir results tests/Scenario/yourTest.robot`



## Redirect Output log files  
use: `--outputdir dirName`
Example:
`robot --variablefile resources/variables/environment/qa2.py  --outputdir results tests/Scenario/validateAllWaysJobCreationWithRapidContract.robot`


# scenario's Covered
all scenarios are maintained in `tests/Scenario/`
---
1. validateAllWaysJobCreationWithRapidContract.robot
    Test cases covers different ways of job creation with Job Type as Rapid Contract and using `jobEntities.resource`
    which contains different entities which are required to creat job like: `location, department, skill,..`
        ```robot
        *** Test Cases ***
        Validate Job Creation With Job Type as Rapid Contract Using Normal Flow
        Validate Job Creation With Job Type as Rapid Contract Using Copy Exists
        Validate Job Creation With Job Type as Rapid Contract Using Add New Job From Template
        ```
    ##### If you want to add your own Entity values you can Edit in `jobEntities.resource` File

        ```robot
        *** Variables ***
        ${LOCATION}                   TestLocation_20251128_1650
        ${DEPARTMENT}                 TestDepartment_20251128_1650
        ${HIRING_MANAGER}             rajitha p
        ${SKILL}                      TestSkill_20251128_1650
        ${NO_OF_POSITIONS}            5
        ${EARLIEST_DATE}
        ${MINI_WK_DUR}                5
        ${SHIFT}                      19:00-07:30 (13:30 - 21:30)
        ${EXPECTED_WKLY_SHIFT}        5
        ${HOURS_PER_SHIFT}            7
        ${YEARS_OF_EXPERIENCE}        5
        ${REGULAR_RATE}               1
        ${RATE_TEMPLATE_NAME}         TestRateTemplate_20251128_1650
        ${OT_RULE_TEMPLATE_NAME}      Testratetemplate_20251128_1650
        ```

2. validateBulkEditForRapidContract.robot
     Test cases covers in JobList Page applying Filter for `status` and `jobType` with values as `open` and `Rapid Contract`
     and select specified number of jobs like 5 in `Select Jobs for Bulk Edit    5` from result and do Bulk Edit to update
     Hot Job Option `Update Hot Job Option For Bulk Edit    Add Hot Job Flag` and submit
           ```robot
           *** Test Cases ***
           Validate Bulk Edit for Open Jobs of Rapid Contract
           ```
3. validateCreatedJobofRapidContractTypeforRatesComparision.robot
    Test cases covers create job of type `Rapid Contract` and store all types of rates, ot rules
    then navigate to rates page select specified rate `Choose Specified Rate Template from Dropdown list    ${RATE_TEMPLATE_NAME}` 
    and fetching all rates for selected Skill from job creation then `save and compare rates` and similarly OT Rules
    select specified ot Template `Choose Specified OT Rule Template from Dropdown list    ${OT_RULE_TEMPLATE_NAME}`
    and checking selected location from job creation is present or not then fetching and comparing with Job Ot rules
          ```robot
           *** Test Cases ***
           Validate Job Creation With Job Type as Rapid Contract
           Store All Rates for Created Job
           Compare All Job Rates with Rate Template and Ensure Skill Matches Job's Skil
           Compare All Job OT Rules with OT Template and Ensure Location Matches Job's Location
                 ```
    ##### NOTE: If you want to add your own Entity values ${RATE_TEMPLATE_NAME} ${OT_RULE_TEMPLATE_NAME} you can Edit in `jobEntities.resource` File
4. validateHrefForAllHiringProcessingSkillList.robot
   Test cases covers check all the values under `hiring process` column in `Skill Administration` page are of type button
   and when clicked on any value should open window
          ```robot
           *** Test Cases ***
           Validate All Values Under Hiring Process Values are Buttons and Redirect to View Rules Window
                 ```
5. validateSkillHiringProcessRules.robot
   Test cases covers create of new skill and update skill with different combinations of Rules
          ```robot
           *** Test Cases ***
           Validate Skill Hiring Process Rules
           Verify Two rules partition combos
           Verify Three rules cover all combos
           Verify Multi-select grouping that still yields unique mapping
           Verify Exact duplicate mapping in two rules
           Verify Overlapping multi-selects cause duplicate atomic combo
           Verify Partial overlap where one atomic combo duplicates
           Verify Missing explicit uniqueness in overlapping rules
           Verify Exceeding allowed number of rules
           Verify Overlapping multi-selects causing multiple duplicates
                 ```
6. validateTalentSubmissionFromCoretoRapidContractJob.robot
   Test cases covers create job of `Rapid Contract` type and store created job name then login to vms
   portal and search with created job name then create new talent using faker library for firstname, lastname,...
   and store all talent details create and submit talent in vms portal
          ```robot
           *** Test Cases ***
           Create Job of Rapid Contract Type For Talent Submission
           Create Talent From Vms Portal
           Accept offer for Submitted Talent
                 ```
7. verifyRapidContractTypeListedinJobTypeDropDown.robot
   Test cases covers checking rapid contract option is present in jobtype dropdown
          ```robot
           *** Test Cases ***
           Validate Rapid Contract Option listed in JobType DropDown While Creating New Job
           Validate Rapid Contract Option listed in JobType DropDown While Creating New Job Using Template
           Validate Rapid Contract Option listed in JobType DropDown While Creating New Job by Copying Existing Job
                 ```