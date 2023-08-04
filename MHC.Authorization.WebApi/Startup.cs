using MHC.Common.Infrastructure.EventBus.DependencyInjection;
using MHC.Common.WebApi.DependencyInjection;
using MHC.Common.WebApi.Extensions;
using Serilog;
using Serilog.Events;

namespace MHC.Authorization.WebApi
{
    public class Startup
    {
        private static readonly string ApplicationName = typeof(Program).Assembly.GetName().Name;

        public Startup(IConfiguration configuration, IWebHostEnvironment environment)
        {
            Configuration = configuration;
            Environment = environment;

            Log.Information("MHC.Authorization.WebApi setting up the logging...");
            Log.Logger = new LoggerConfiguration()
                .MinimumLevel.Override("Microsoft.AspNetCore", LogEventLevel.Warning)
                .Enrich.FromLogContext()
                .Enrich.WithCorrelationId()
                .Enrich.WithProperty("ApplicationName", ApplicationName)
                .ReadFrom.Configuration(configuration)
                .CreateLogger();
            Log.Information("MHC.Authorization.WebApi Starting up...");

            // Uncomment in case of any client-side issues
            Serilog.Debugging.SelfLog.Enable(Console.Error);
        }

        public IConfiguration Configuration { get; }

        public IWebHostEnvironment Environment { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddSwagger(ApplicationName);
            services.AddMhcControllers<Startup>();
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, IServiceProvider serviceProvider)
        {
            Log.Information("MHC.Authorization.WebApi Configure...");
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseForwardedHeaders();
            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "MHC.Authorization");
            });

            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseCors("AllowAny");
        }

        private static void AddAutoMappers(IServiceCollection services)
        {
        }

        private static void AddEventHandlers(IServiceCollection services)
        {
        }
    }
}
