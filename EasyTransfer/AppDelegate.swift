//
//  AppDelegate.swift
//  EasyTransfer
//
//  Created by PanJianTing on 2020/3/21.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds);
        self.window!.backgroundColor = UIColor.white;
        
        let tabbarController = UITabBarController();
        
        tabbarController.tabBar.backgroundColor = UIColor.clear;

        let mainNVC = UINavigationController(rootViewController: ViewController());
        mainNVC.tabBarItem = UITabBarItem(title: "我的帳戶", image: UIImage(named: "user"), tag: 100)

        let historyNVC = UINavigationController(rootViewController: HistoryTransferViewController());
        historyNVC.tabBarItem = UITabBarItem(title: "歷史轉帳", image: UIImage(named: "scroll"), tag: 101)
        
        tabbarController.viewControllers = [mainNVC, historyNVC];
        
        tabbarController.selectedIndex = 0;
        
        self.window!.rootViewController = tabbarController;
        self.window!.makeKeyAndVisible();
        
        print(self.coreData.insertAccount(account: panTSAccount));
        print(self.coreData.insertAccount(account: panUFAccount));
        print(self.coreData.insertAccount(account: panHNAccount));
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EasyTransferModel");
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error), \(error.userInfo)");
            }
        }
        return container
    }()
    
    lazy var coreData:CoreDataConnect = {
        return CoreDataConnect.init(context: self.persistentContainer.viewContext);
    }()
    
    // MARK: - Core Data Saving
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save();
            }catch{
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)");
            }
        }
    }


}

