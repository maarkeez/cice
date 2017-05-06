//
//  AppDelegate.swift
//  App_BarLogin
//
//  Created by cice on 27/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var puedoRotar = false
    var orientacionDisponible : UIInterfaceOrientationMask = .portrait


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //Recuperamos los datos del teléfono si existe
        tareasManager.cargarDatosTareas()
        personalizaUI()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        tareasManager.guardarTareas()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        tareasManager.guardarTareas()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        tareasManager.cargarDatosTareas()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        tareasManager.cargarDatosTareas()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        tareasManager.guardarTareas()
    }

    //MARK: - Funciones de orientación
    //Indicamos cuando
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if (puedoRotar){
            return .all
        }else{
            return orientacionDisponible
        }
    }
    
   
    
    

    //MARK: - UTILS
    func personalizaUI(){
        let navigation = UINavigationBar.appearance()
        let tabBar = UITabBar.appearance()
        
        //Color del fondo de la barra
        navigation.barTintColor = CONSTANTES.COLOR.NEGRO
        // Colorear los bordes y demás para la barra de navegación
        navigation.tintColor = CONSTANTES.COLOR.AMARILLO
        //Pinta los colores de todos los textos de amarillo
        navigation.titleTextAttributes = [NSForegroundColorAttributeName : CONSTANTES.COLOR.AMARILLO]
        
        tabBar.barTintColor = CONSTANTES.COLOR.CASI_NEGRO
        tabBar.tintColor = CONSTANTES.COLOR.AMARILLO
        
    }
    
}

