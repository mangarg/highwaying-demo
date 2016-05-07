using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(highwaying_demo.Startup))]
namespace highwaying_demo
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
