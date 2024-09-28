import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let container = Container()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        container.register(NetworkingServiceProtocol.self) { _ in NetworkingService() }
        container.register(ChatViewModel.self) { r in
            ChatViewModel(networkingService: r.resolve(NetworkingServiceProtocol.self)!)
        }
        container.register(ChatViewController.self) { r in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let chatVC = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            chatVC.viewModel = r.resolve(ChatViewModel.self)
            return chatVC
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let chatViewController = container.resolve(ChatViewController.self) {
            window?.rootViewController = chatViewController
            window?.makeKeyAndVisible()
            
            if window?.rootViewController == nil {
                print("Root view controller is nil!")
            } else {
                print("Root view controller is set")
            }
        }
        
        return true
    }
}
