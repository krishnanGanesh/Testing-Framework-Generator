package driver;


import config.Config;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.safari.SafariDriver;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import static config.Constants.*;

public class WebDriverFactory {

    private Config driverConfig = null;
    private final HashMap<String, Object> deviceProps = new HashMap<>();

    public WebDriverFactory(Config config) {
        this.driverConfig = config;
        this.deviceProps.put("browserName", config.browserName);
        this.deviceProps.put("version", config.browserVersion);
        this.deviceProps.put("platform", config.browserPlatform);
    }

    public RemoteWebDriver createDriver() throws MalformedURLException {

        DesiredCapabilities browserCaps =
                new DesiredCapabilities(deviceProps);

        String browserName = browserCaps
                .getCapability("browserName")
                .toString()
                .toLowerCase();

        switch (browserName) {
            case CHROME:
                return getChromeDriver(browserCaps);
            case FIREFOX:
                return getFirefoxDriver(browserCaps);
            case SAFARI:
                return getSafariDriver(browserCaps);
            case INTERNET_EXPLORER:
                return getInternetExplorerDriver(browserCaps);
            case EDGE:
                return getEdgeDriver(browserCaps);
            default:
                throw new IllegalArgumentException(String.format("Driver type not implemented for browser: %s", browserName));
        }
    }

    private RemoteWebDriver getChromeDriver(DesiredCapabilities browserCaps) throws MalformedURLException {
        if(this.driverConfig.runLocally.equals("true")) {
            ChromeOptions chromeOpts = new ChromeOptions();
            chromeOpts.addArguments("--start-maximized");
//            chromeOpts.setBinary(getWebDriverBinaryPath("chrome"));

            DesiredCapabilities chromeCaps = DesiredCapabilities.chrome();
            chromeCaps.setCapability(ChromeOptions.CAPABILITY, chromeOpts);
            chromeCaps.setCapability("platform", browserCaps.getPlatform());
            chromeCaps.setCapability("browserName", browserCaps.getBrowserName());

            System.setProperty("webdriver.chrome.driver", getWebDriverBinaryPath("chrome"));
            return new ChromeDriver(chromeCaps);
        }
        else {
            return new RemoteWebDriver(new URL(SAUCE_LABS_URL), browserCaps);
        }
    }

    private RemoteWebDriver getFirefoxDriver(DesiredCapabilities browserCaps) throws MalformedURLException {
        if(this.driverConfig.runLocally.equals("true")) {
            return new FirefoxDriver(browserCaps);
        }
        else {
            return new RemoteWebDriver(new URL(SAUCE_LABS_URL), browserCaps);
        }
    }

    private RemoteWebDriver getSafariDriver(DesiredCapabilities browserCaps) throws MalformedURLException {
        if(this.driverConfig.runLocally.equals("true")) {
            return new SafariDriver(browserCaps);
        }
        else {
            return new RemoteWebDriver(new URL(SAUCE_LABS_URL), browserCaps);
        }
    }

    private RemoteWebDriver getInternetExplorerDriver(DesiredCapabilities browserCaps) throws MalformedURLException {
        if(this.driverConfig.runLocally.equals("true")) {
            return new InternetExplorerDriver(browserCaps);
        }
        else {
            return new RemoteWebDriver(new URL(SAUCE_LABS_URL), browserCaps);
        }
    }

    private RemoteWebDriver getEdgeDriver(DesiredCapabilities browserCaps) throws MalformedURLException {
        if(this.driverConfig.runLocally.equals("true")) {
            System.setProperty("webdriver.edge.driver", getWebDriverBinaryPath("edge"));
            return new EdgeDriver(browserCaps);
        }
        else {
            return new RemoteWebDriver(new URL(SAUCE_LABS_URL), browserCaps);
        }
    }

    private static String getWebDriverBinaryPath(String driverName) {

        String osType = System.getProperty("os.name");
        String cwd = System.getProperty("user.dir");
        String driverPath = cwd + "/src/main/resources/drivers/";

        switch (driverName.toLowerCase()) {
            case CHROME:
                if (osType.contains("Windows")) driverPath = driverPath + "chromedriver.exe";
                else driverPath = driverPath + "chromedriver";
                break;
            case FIREFOX:
                if (osType.contains("Windows")) driverPath = driverPath + "geckodriver.exe";
                else driverPath = driverPath + "geckodriver";
                break;
            case INTERNET_EXPLORER:
                driverPath = driverPath + "IEDriverServer.exe";
                break;
            case SAFARI:
            case EDGE:
                if (osType.contains("Windows")) driverPath = driverPath + "MicrosoftEdgeDriver.exe";
                else driverPath = driverPath + "MicrosoftEdgeDriver.exe";
            default:
                driverPath = null;
                break;
        }
        return driverPath;
    }
}
