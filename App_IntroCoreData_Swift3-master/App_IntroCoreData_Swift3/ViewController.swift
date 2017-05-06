//
//  ViewController.swift
//  App_IntroCoreData_Swift3
//
//  Created by Andres on 3/4/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    //MARK: - Variables locales
    var contextManager : NSManagedObjectContext!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //1 -> Creamos la instancia a traves de la cual salvaremos datos
        let customPersona = Persona(context: contextManager)
        customPersona.nombre = "Andres"
        customPersona.apellido = "Ocampo"
        customPersona.email = "info@info.com"
        customPersona.movil = 653940573
        
        
        //2 -> Salvamos datos a traves del contexto
        do{
            try contextManager.save()
            
        }catch{
            print("Error salvando datos")
        }
        
        
        //3 -> Recuperamos datos a traves del contexto
        let request : NSFetchRequest<Persona> = Persona.fetchRequest()
        let customPredicate = NSPredicate(format: "nombre = 'Andres'")
        let cusotmSortDescriptor = NSSortDescriptor(key: "nombre", ascending: true)
        
        request.predicate = customPredicate
        request.sortDescriptors = [cusotmSortDescriptor]
        
        do{
            //4
            let multitud = try contextManager.fetch(request)
            for c_persona in multitud{
                print("Nombre: \(c_persona.nombre!)\nApellido: \(c_persona.apellido!)\nEmail: \(c_persona.email!)\nMovil: \(c_persona.movil)\n\n")
            }
            
        }catch{
            print("Error cargando datos")
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

