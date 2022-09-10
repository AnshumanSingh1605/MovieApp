//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Anshuman Singh on 10/09/22.
//

import SwiftUI

@main
struct MovieAppApp: App {
    
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  
  public var keyWindow : UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      return true
  }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

