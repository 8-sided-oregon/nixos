{
  programs.firefox = {
    enable = true;
    policies = {
      Containers = {
        Default = [
          {
            name = "Shopping";
            icon = "cart";
            color = "pink";
          }
          {
            name = "Personal";
            icon = "fingerprint";
            color = "blue";
          }
          {
            name = "Email";
            icon = "fingerprint";
            color = "purple";
          }
          {
            name = "Google";
            icon = "circle";
            color = "green";
          }
          {
            name = "Github";
            icon = "circle";
            color = "orange";
          }
          {
            name = "Homework";
            icon = "circle";
            color = "yellow";
          }
        ];
      };
      Cookies = {
        ExpireAtSessionEnd = true;
        RejectTracker = true;
        Locked = false;
        Behavior = "reject-tracker-and-partition-foreign";
        BehaviorPrivateBrowsing = "reject-foreign";
      };
      DisableBuiltinPDFViewer = true;
      DisabledCiphers = {
        "TLS_RSA_WITH_3DES_EDE_CBC_SHA" = true;
      };
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "always";
      DNSOverHTTPS = {
        Enabled = true;
        Locked = false;
      };
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = false;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      EncryptedMediaExtensions = {
        Enabled = false;
        Locked = true;
      };
      ExtensionSettings = {
        "*" = {
          "installation_mode" = "denied";
        };
        "uBlock0@raymondhill.net" = {
          "installation_mode" = "normal_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
          "installation_mode" = "normal_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/noscript/latest.xpi";
        };
        "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
          "installation_mode" = "normal_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi";
        };
        "{7be2ba16-0f1e-4d93-9ebc-5164397477a9}" = {
          "installation_mode" = "allowed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/videospeed/latest.xpi";
        };
        "@testpilot-containers" = {
          "installation_mode" = "normal_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
        };
        "tridactyl.vim@cmcaine.co.uk" = {
          "installation_mode" = "normal_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/latest.xpi";
        };
        "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}" = {
          "installation_mode" = "normal_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/old-reddit-redirect/latest.xpi";
        };
      };
      Preferences = {
        "network.IDN_show_punycode" = {
          Value = true;
        };
        "dom.security.https_only_mode" = {
          Value = true;
        };
        "dom.security.https_only_mode_send_http_background_request" = {
          Value = true;
        };
        "dom.security.https_only_mode_ever_enabled" = {
          Value = true;
        };
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = false;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = false;
      };
      GoToIntranetSiteForSingleWordEntryInAddressBar = false;
      HardwareAcceleration = true;
      InstallAddonsPermission = {
        Default = true;
      };
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      Permissions = {
        Camera = {
          BlockNewRequests = true;
        };
        Microphone = {
          BlockNewRequests = true;
        };
        Location = {
          BlockNewRequests = true;
        };
        Notifications = {
          BlockNewRequests = true;
        };
      };
      PopupBlocking = {
        Default = true;
      };
      RequestedLocales = "de,en-US";
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        Downloads = true;
        FormData = true;
        History = true;
        Sessions = true;
        SiteSettings = true;
        OfflineApps = true;
        Locked = false;
      };
      SearchEngines = {
        Default = "DuckDuckGo";
        Remove = [
          "Amazon"
          "Bing"
          "Google"
          "Twitter"
          "Wikipedia"
          "Yahoo"
          "eBay"
          "Amazon.com"
        ];
      };
      SearchSuggestEnabled = false;
      UserMessaging = {
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = false;
        MoreFromMozilla = false;
        Locked = false;
      };
    };
    # Profile management is a bit weird and firefox doesn't like it ;-;
    #profiles = {
    #  browsing.name = "browsing";
    #  browsing.isDefault = true;
    #  browsing.id = 0;
    #  school.name = "school";
    #  school.isDefault = false;
    #  school.id = 1;
    #  persistant.name = "persistant";
    #  persistant.isDefault = false;
    #  persistant.id = 2;
    #};
  };
}
