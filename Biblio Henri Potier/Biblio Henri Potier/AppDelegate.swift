//
//  AppDelegate.swift
//  Biblio Henri Potier
//
//  Created by Julian Cely on 12.10.17.
//  Copyright © 2017 excercice. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var selectedBooks: [Book] = []
    private var tababarController: UITabBarController!

    var window: UIWindow?

    func add(book: Book) {
        self.selectedBooks.append(book)
    }
    
    func delete(book: Book) {
        self.selectedBooks = self.selectedBooks.filter({ $0.getTitle() != book.getTitle() })
    }
    
    func deleteBooks() {
        self.selectedBooks.removeAll(keepingCapacity: false)
        if let navC = tababarController.viewControllers?[0] as? UINavigationController, let firstVC = navC.viewControllers[0] as? FirstViewController {
            firstVC.deselectRows()
        }
    }
    
    func getSelectedBooks() -> [Book] {
        return self.selectedBooks
    }
    
    func setTabBarIndex(index: Int) {
        tababarController.selectedIndex = index
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let tbController = self.window!.rootViewController as? UITabBarController {
            tababarController = tbController
        }
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
}

