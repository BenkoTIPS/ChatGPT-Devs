git init

dotnet new razor -o code/myChat
dotnet new sln
dotnet sln add code/myChat

## Add code and run in debug mode

git remote add origin https://github.com/BenkoTIPS/ChatGPT-Devs.git
git branch -M main
git push -u origin main

start powerpnt.exe .\docs\bnk-openai-dev.pptx