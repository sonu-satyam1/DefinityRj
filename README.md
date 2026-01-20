#  DefinityRj — Robot Framework Automation Project
DefinityRj
##  Git Commands (Push Code to Repository)
`git add .`
`git commit -m "envQa2file added"`
`git push -u origin main`
to add remote first time and required only once- `git remote add origin https://github.com/testAccountForLearningAll/DefinityRj`
if conflicts - `git pull origin main --rebase`


### testcase execution using specific env
`robot --variablefile resources/variables/environment/qa2.py  --outputdir results tests/Scenario/`


#### For refering code 
1. goto Specific Folder in Local 
2. Clone the repository using  `git clone https://github.com/testAccountForLearningAll/DefinityRj.git`
3. Go into the project folder `cd DefinityRj`
   i. Requirements to Run Robot Framework:
           Install Python (Mandatory) and Add Python to PATH
           `python --version
            pip --version`
   ii. install libraries
            `pip install robotframework
             pip install robotframework-seleniumlibrary
             pip install webdriver-manager` or Download ChromeDriver matching your Chrome version Add driver exe to PATH or project folder

        