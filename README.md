# Simple-Login-And-Registration-use-Parse
Simple Login And Registration use Parse

Hello, 

 Simple Login And Registration use back4app.com
 First you need instal Cocoa Touch and in pod file add pod 'Parse' and install this.
 
 In AppDelegate change code, 
 
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let configuration = ParseClientConfiguration {
            $0.applicationId = "HERE_WHRITE_YOUR_APPKEY"
            $0.clientKey = "HERE_WHRITE_YOUR_CLIENT_KEY"
            $0.server = "https://parseapi.back4app.com"
            //            $0.isLocalDatastoreEnabled = true
        }
        Parse.initialize(with: configuration)
        return true
    }
    
    
