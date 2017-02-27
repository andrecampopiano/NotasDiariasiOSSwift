//
//  NotaPersistencia.swift
//  NotasDiarias
//
//  Created by André Luís  Campopiano on 24/02/17.
//  Copyright © 2017 André Luís  Campopiano. All rights reserved.
//

import UIKit
import CoreData

class NotaPersistencia: NSObject {

    
    func getManagerObjects()->NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managerObjects = appDelegate.persistentContainer.viewContext
        
        return managerObjects
    }
    
    func save(nota:NotaEntity){
        let managerObjects = getManagerObjects()
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Nota", into: managerObjects)
        
        newNote.setValue(nota.titulo, forKey: "titulo")
        newNote.setValue(nota.descricao, forKey: "descricao")
        newNote.setValue(NSDate(), forKey: "data")
        
        do {
            try managerObjects.save()
            print("sucesso ao salvar")
        }catch let erro as NSError{
            print("Erro ao salvar: \(erro.description)")
        }
    }
    
    func listNotas()->[NotaEntity]{
        var listaNotas:[NotaEntity] = []
        
        let managerObjects = getManagerObjects()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Nota")
        
        
        do{
            let notas = try managerObjects.fetch(request)
            for nota in notas {
                let notaEnt = NotaEntity()
                notaEnt.titulo = (nota as AnyObject).value(forKey:"titulo") as? String
                notaEnt.data = (nota as AnyObject).value(forKey:"data") as! NSDate
                notaEnt.descricao = (nota as AnyObject).value(forKey:"descricao") as? String
                listaNotas.append(notaEnt)
            }
            print("Sucesso ao recuperar a lista")
        }catch let erro as NSError{
            print("erro ao recuperar a lista \(erro.description)")
        }
        return listaNotas
    }
    
    
    func update(nota:NotaEntity){
        
    }
    
    func delete(nota:NotaEntity){
        
    }
    
}
