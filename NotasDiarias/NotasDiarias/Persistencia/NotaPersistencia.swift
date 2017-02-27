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
        let notas = self.recoverList()
        
        if (notas.count > 0){
            for nota in notas {
                let notaEnt = NotaEntity()
                notaEnt.titulo = (nota as AnyObject).value(forKey:"titulo") as? String
                notaEnt.data = (nota as AnyObject).value(forKey:"data") as! NSDate
                notaEnt.descricao = (nota as AnyObject).value(forKey:"descricao") as? String
                listaNotas.append(notaEnt)
            }
        }
        return listaNotas
    }
    
    
    func recoverList()->[NSManagedObject]{
        var notas:[NSManagedObject] = []
        let managerObjects = getManagerObjects()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Nota")
        let orderbyDate = NSSortDescriptor(key: "data", ascending: false)
        request.sortDescriptors = [orderbyDate]
        
        
        do{
            let notasRec = try managerObjects.fetch(request)
            notas = notasRec as! [NSManagedObject]
            print("Sucesso ao recuperar a lista")
        }catch let erro as NSError{
            print("erro ao recuperar a lista \(erro.description)")
        }

        return notas
    }
    
    
    func update(position:Int, notaUpd:NotaEntity){
        let managerObject = getManagerObjects()
        let listaNotas = recoverList()
        let nota = listaNotas[position]
        
        nota.setValue(notaUpd.titulo, forKey: "titulo")
        nota.setValue(notaUpd.descricao, forKey: "descricao")
        nota.setValue(NSDate(), forKey: "data")
        
        do{
            try managerObject.save()
            print("Sucesso ao alterar nota")
        }catch let erro as NSError{
            print("erro ao atualizar \(erro.description)")
        }
        
        
    }
    
    func delete(position:Int){
        let managerObject = getManagerObjects()
        let listaNotas = recoverList()
        let nota = listaNotas[position]
        managerObject.delete(nota)
        do{
            try managerObject.save()
            print("Sucesso ao remover a nota")
        }catch let erro as NSError{
            print("erro ao remover \(erro.description)")
        }
    }
}
