using System.ComponentModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace myChat.Pages;

public class PrivacyModel : PageModel
{
    private readonly ILogger<PrivacyModel> _logger;

    public PrivacyModel(ILogger<PrivacyModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }

    // Function to average a set of numbers
    public double Average(double[] numbers)
    {
        double total = 0;
        foreach (double num in numbers)
        {
            total += num;
        }
        return total / numbers.Length;
    }

    // Function to average a set of numbers
    public double Average2(double[] numbers)
    {
        double total = 0;
        foreach (double num in numbers)
        {
            total += num;
        }
        return total / numbers.Length;
    }
    
}

