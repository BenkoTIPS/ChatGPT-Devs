# ChatGPT Devs - Buildit
git init

dotnet new razor -o code/myChat
dotnet new sln
dotnet sln add code/myChat

## Add code and run in debug mode

git remote add origin https://github.com/BenkoTIPS/ChatGPT-Devs.git
git branch -M main
git push -u origin main

## Demos

dotnet new page -n Astroids -o code/myChat/Pages
dotnet new page -n Chat -o code/myChat/Pages

dotnet user-secrets -p code/myChat init
dotnet user-secrets -p code/myChat set "openaiKey" "your-api-key-here"
dotnet user-secrets -p code/myChat set "openaiUrl" "your-api-url-here"

dotnet add code/myChat package Azure.AI.OpenAI --version 1.0.0-beta.5

start powerpnt.exe .\docs\bnk-openai-dev.pptx