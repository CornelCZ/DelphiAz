using Topshelf;

namespace EventPricingService
{
    class Program
    {
        static void Main(string[] args)
        {
            Log.Init();

            HostFactory.Run(x =>
            {
                x.Service<NancySelfHost>(s =>
                {
                    s.ConstructUsing(name => new NancySelfHost());
                    s.WhenStarted(tc => tc.Start());
                    s.WhenStopped(tc => tc.Stop());
                });

                x.RunAsLocalSystem();
                x.StartAutomatically();
                x.SetDescription("Switch on or off Event Pricing or Event Pricing components on the terminal");
                x.SetDisplayName("Aztec Event Pricing");
                x.SetServiceName("AztecEventPricingService");
            });
        }
    }
}
