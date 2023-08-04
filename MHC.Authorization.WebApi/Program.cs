using Microsoft.AspNetCore.Connections;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore;
using Serilog;

namespace MHC.Authorization.WebApi
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            try
            {
                var host = CreateWebHostBuilder(args)
                    .Build();

                host.Run();
            }
            catch (Exception exception)
            {
                Log.Fatal($"MHC.Authorization.WebApi failed to start with {exception.Message}", exception);
            }
            finally
            {
                Log.CloseAndFlush();
            }
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>();
    }
}