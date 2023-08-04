using Microsoft.AspNetCore.Mvc;
using MHC.Authorization.Core.Services;

namespace MHC.Authorization.WebApi.Controllers
{
    [ApiController]
    [Route("api/opal")]
    public class OpalController : ControllerBase
    {
        private readonly IOpalService _opalService;

        public OpalController(IOpalService opalService)
        {
            _opalService = opalService;
        }

        [HttpGet]
        [Route("api/opal/GetOpalData")]
        public async Task<IHttpActionResult> GetOpalData()
        {
            var opalData = await _opalService.GetOpalData();
            return Ok(opalData);
        }
    }
}
