//
//  NovaNotaViewController.swift
//  NotasDiarias
//
//  Created by André Luís  Campopiano on 24/02/17.
//  Copyright © 2017 André Luís  Campopiano. All rights reserved.
//

import UIKit

class NovaNotaViewController: UIViewController {

    
    var note:NotaEntity!
    var navControl = "add"
    var position:Int!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtNota: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 47/255, green: 92/255, blue: 177/255, alpha: 1)
        
        
        if (note) != nil {
            txtTitle.text = note.titulo
            txtNota.text = note.descricao
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnSalvar(_ sender: Any) {
        
        if(self.txtNota.text != "" && self.txtTitle.text != ""){
            let newNote = NotaEntity()
            newNote.descricao = txtNota.text
            newNote.titulo = txtTitle.text
            if note != nil {
                NotaPersistencia().update(position: self.position, notaUpd:newNote)
            }else {
                NotaPersistencia().save(nota: newNote)
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "Preencha os Campos", message: "Título e o conteudo da nota devem ser preenchidos", preferredStyle: .alert)
            let alertOk = UIAlertAction(title: "Continuar", style: .default, handler: nil)
            alert.addAction(alertOk)
            self.present(alert, animated: true, completion: nil)
            
            
        }
    }
}
