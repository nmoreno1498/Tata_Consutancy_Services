using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Tata_Consutancy_Services.Context;
using Tata_Consutancy_Services.Models;

namespace Tata_Consutancy_Services.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly TCSSERVICESContext _context;


        public HomeController(ILogger<HomeController> logger, TCSSERVICESContext context)
        {
            _context = context;
            _logger = logger;
        }

        public IActionResult Index()
        {
            
            var Cliente = _context.Clientes.Find(1);
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
