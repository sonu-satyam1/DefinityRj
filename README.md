# DefinityRj
DefinityRj
#### pushing code to git
`git add .`
`git commit -m "envQa2file added"`
`git push -u origin main`
to add remote first time and required only once- `git remote add origin https://github.com/testAccountForLearningAll/DefinityRj`
if conflicts - `git pull origin main --rebase`


#### for env wise execution
`robot --variablefile resources/variables/environment/qa2.py  resources/resource.robot`

### testcase execution
`robot --variablefile resources/variables/environment/qa2.py  --outputdir results tests/ tests/LoginPage/login.robot`