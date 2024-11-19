//
//  MC_gym_bookingApp.swift
//  MC gym booking
//
//  Created by user267421 on 11/18/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
        LoginView()
      }
    }
  }
}
