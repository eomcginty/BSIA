using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BSIA.Startup))]
namespace BSIA
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
