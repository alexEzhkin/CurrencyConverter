//
//  AppDelegate.swift
//  Currency Converter
//
//  Created by AndUser on 23/03/2023.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let realm = try! Realm()
        
        if realm.objects(CurrencyRealmObject.self).count == 0 {
            // If the database does not exist, create a new Currency object with default values and write it to the database
            let currency = CurrencyRealmObject()
            currency.eur = 1000.00
            currency.usd = 0.00
            currency.jpy = 0.00
            
            try! realm.write {
                realm.add(currency)
            }
        }
        
        if realm.objects(FeeLimitObject.self).count == 0 {
            // If the database does not exist, create a new FeeLimit object with default values and write it to the database
            let fee = FeeLimitObject()
            fee.freeTransactionLimit = 1
            
            try! realm.write {
                realm.add(fee)
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

