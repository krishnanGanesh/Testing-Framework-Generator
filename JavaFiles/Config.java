package config;

import static config.Constants.CHROME;
import static config.Constants.DEFAULT_URL;

public class Config {

    public final String runLocally;
    public final String platformType;

    public final String browserName;
    public final String browserVersion;
    public final String browserPlatform;
    public final String browserUrl;

    public final String mobilePlatform;
    public final String mobileVersion;

    /**
     * Config is initialized in the Hooks and determines the various environment settings on which the tests will execute.
     * The properties can be set via command line, or it will default to the values specified in the Hooks class.
     *
     * Command Line Examples:
     *  - mvn clean install -Dtest=MobileTestRunner -DmobilePlatform="android" -DmobilePlatformVersion="7.0" test
     *  - mvn clean install -Dtest=MobileTestRunner -DmobilePlatform="ios" -DmobilePlatformVersion="9.3" test
     *  - mvn clean install -Dtest=DesktopTestRunner -DbrowserName="chrome" -DbrowserPlatform="windows 10" -Durl="https://cyclone-qa-desktop.ovrc.com" test
     *
     * Parameters:
     *  platformType - choose "desktop" or "mobile"
     *  runLocally - set 'true' to run desktop tests on local machine or 'false' to run on Sauce Labs
     *
     *  browserName - the version of the browser to run against. Choose "chrome", "firefox", "safari" or "internet explorer"
     *  browserVersion - The browser release version (optional)
     *  browserPlatform -The Operating System to run desktop tests against. Options: "windows 7" , "el capitan", see: https://tinyurl.com/yat8xlkn
     *  browserUrl - The application url to run browser tests against.
     *
     *  mobilePlatform - the mobile platform: either "ios" or "android"
     *  mobileVersion - The version of the mobile OS. Examples: "9.3", "10.1", "7.0", or any valid Android or iOS version #.
     */
    public Config() {

        this.platformType = System.getProperty("platformType", "web");
        this.runLocally = System.getProperty("runLocally", "true");

        this.browserName = System.getProperty("browserName", FIREFOX);
        this.browserVersion = System.getProperty("browserVersion", "latest");
        this.browserPlatform = System.getProperty("browserPlatform", null);
        this.browserUrl = System.getProperty("browserUrl", DEFAULT_URL);

        this.mobilePlatform = System.getProperty("mobilePlatform", "ios");
        this.mobileVersion = System.getProperty("mobileVersion", "");

    }

}
