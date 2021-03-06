//
//  AppDelegate.swift
//  PTchat
//
//  Created by Tiếp Sỹ Minh Phụng on 7/11/20.
//  Copyright © 2020 PTgroup. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )

        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        return true
    }
          
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return GIDSignIn.sharedInstance().handle(url)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else{
            if let error = error{
                  print("Fail to sign in with Google: \(error)")
            }
            return
        }
        guard let user = user else{
            return
        }
        print("Did sign in with google user: \(user) ")
        guard let email = user.profile.email,
            let firstName = user.profile.givenName,
            let lastName = user.profile.familyName else{
                return
        }
        
        
        DatabaseManager.shared.userExists(with: email, completion: { exists in
            if !exists{
                //insert to database
                DatabaseManager.shared.insertUsers(with: ChatAppUser(firstName: firstName,
                                                                     lastName: lastName,
                                                                     emailAddress: email))
            }
        })
        
        guard let authentication = user.authentication else {
            print("Missing auth object of google")
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        FirebaseAuth.Auth.auth().signIn(with: credential, completion: { authResult, error in
            guard authResult != nil, error == nil else{
                print("Fail to login with google credential")
                return
            }
            //success
             print("Successfully login with google credential")
            NotificationCenter.default.post(name: .didLoginNotification, object: nil)
        })
        
    }
    func sign(_ signIn: GIDSignIn!, didConnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Google User was disconected")
    }
    
}

    
