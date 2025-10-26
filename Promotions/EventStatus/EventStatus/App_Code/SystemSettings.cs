using System;


using Microsoft.Win32;

/// <summary>
/// Summary description for SystemSettings
/// </summary>
public class SystemSettings
{
    private string ProgramLocation;
    private string DatabaseMachine;
    private string DatabaseName;
    private string Locale;

	public SystemSettings()
	{
		//
		// TODO: Add constructor logic here
		//
        RegistryKey key = Registry.LocalMachine;
        key = key.OpenSubKey(@"Software\Zonal\Aztec", false);

        ProgramLocation = key.GetValue("ProgramLocation").ToString().TrimEnd('/');
        DatabaseMachine = key.GetValue("DatabaseMachine").ToString();
        DatabaseName = key.GetValue("DatabaseName").ToString();
        
        key = Registry.CurrentUser;
        key = key.OpenSubKey(@"Control Panel\International", false);
        Locale = key.GetValue("Locale").ToString();
	}

    public string GetAztecConnectionString()
    {
//        return "Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=" + DatabaseName + ";Data Source=" + DatabaseMachine;
        return "User ID=zonalsysadmin;Password=0049356GNHsxkzi26TYMF;Initial Catalog=" + DatabaseName + ";Data Source=" + DatabaseMachine;
    }

    public string GetThemeModellingPath()
    {
        return ProgramLocation + @"\ThemeModelling.exe";
    }

    public string GetAztecDirectory()
    {
        return ProgramLocation;
    }

    public String GetCultureTag()
    {
        if (Locale == "00000409")
            return("en-US");
        else
            return("en-GB");
    }
 

}
