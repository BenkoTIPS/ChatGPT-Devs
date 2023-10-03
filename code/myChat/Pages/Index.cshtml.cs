using Azure;
using Azure.AI.OpenAI;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace myChat.Pages;

public class IndexModel : PageModel
{
    // Add package for OpenAI from AI Playground code...
    //   dotnet add code\myChat package Azure.AI.OpenAI --version 1.0.0-beta.5 
    
    private readonly ILogger<IndexModel> _logger;
    private readonly IConfiguration _config;
    private readonly HttpClient _httpClient = new HttpClient();
    
    public IndexModel(ILogger<IndexModel> logger, IConfiguration config, HttpClient httpClient)
    {
        _logger = logger;
        _config = config;
        _httpClient = httpClient;
    }
    
    public void OnGet()
    {
    }
    
    public async Task<JsonResult> OnPostSendMessage(string message)
    {
        try{
            var apiKey = _config["openaiKey"];
            var apiUrl = _config["openaiUrl"];
            var prompt = "Conversation with chatbot:<br/>User: " + message + "</br>Chatbot:";
            var client = new OpenAIClient(new Uri(apiUrl), new AzureKeyCredential(apiKey));
    
            Response<ChatCompletions> responseWithoutStream = await client.GetChatCompletionsAsync(
                "Turbo301",
                new ChatCompletionsOptions()
                {
                    Messages =
                    {
                        new ChatMessage(ChatRole.System, @"You are an AI assistant that helps people find information."),
                        new ChatMessage(ChatRole.User, message),
                    },
                    Temperature = (float)0.7,
                    MaxTokens = 800,
                    NucleusSamplingFactor = (float)0.95,
                    FrequencyPenalty = 0,
                    PresencePenalty = 0,
                });
    
            ChatCompletions completions = responseWithoutStream.Value;
            
            return new JsonResult(completions.Choices[0].Message.Content);
    
        } catch (Exception ex) {
            return new JsonResult(ex.Message);
        }
    }
}
