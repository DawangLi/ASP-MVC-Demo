﻿using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Remote;
using System.Configuration;
using System.Threading;
using TechTalk.SpecFlow;

namespace Powerfront.Integration.Tests.Common
{
    [TestClass]
    public sealed class FeatureContext
    {

        public static RemoteWebDriver WebDriver { get; private set; }


        public static string ApiBaseUrl
        {
            get
            {
                if (!ScenarioContext.Current.ContainsKey("_apiBaseUrl"))
                {
                    ScenarioContext.Current["_apiBaseUrl"] = ConfigurationManager.AppSettings["api.url"];
                }
                return ScenarioContext.Current.Get<string>("_apiBaseUrl");
            }
            set { ScenarioContext.Current["_apiBaseUrl"] = value; }
        }

        [AssemblyInitialize]
        public static void Start(TestContext context)
        {
            WebDriver = new FirefoxDriver();
        }

        [AssemblyCleanup]
        public static void Stop()
        {
            WebDriver.Close();
            WebDriver.Dispose();
        }
    }
}