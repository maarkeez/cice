//
//  AppDelegate.swift
//  App_iMDb
//
//  Created by cice on 28/4/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Suscribir a notificaciones
        NotificationCenter.default.addObserver(self, selector: #selector(updateBadge(_:)), name: NSNotification.Name("updateFaBadNot"), object: nil)
        
        let dataProvider = LocalCoreDataService()
        dataProvider.updateFavoriteBadge()
        
        editUI()
        
        
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

    //MARK: - Utils
    func editUI(){
        let navBar = UINavigationBar.appearance()
        let tabBar = UITabBar.appearance()
        
        navBar.barTintColor = CONSTANTES.COLOR.GRIS_TAB_NAV_BAR
        navBar.tintColor = CONSTANTES.COLOR.ROJO_GENERAL
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : CONSTANTES.COLOR.ROJO_GENERAL]
        
        tabBar.barTintColor = CONSTANTES.COLOR.GRIS_TAB_NAV_BAR
        tabBar.tintColor = CONSTANTES.COLOR.ROJO_GENERAL
        
        
        
    }

    ///Recupera el total de datos y lo printa en un circulo dentro del item del primer root view controller 
    ///para los favoritos
    ///OJO!!! Si no es el primer view, puede que no exista y causar errores.
    func updateBadge(_ notificacion: Notification){
        
        //Recuperar el rootview controller
        let tabBarVC = self.window?.rootViewController as! UITabBarController
        //Recuperar el último item
        let favNavVC = tabBarVC.viewControllers?.last   as! UINavigationController
        
        if let total = notificacion.object as? Int{
            if total != 0{
                favNavVC.tabBarItem.badgeValue = "\(total)"
            }else{
                favNavVC.tabBarItem.badgeValue = nil
            }
        }
        
        
        
        
    }
}

