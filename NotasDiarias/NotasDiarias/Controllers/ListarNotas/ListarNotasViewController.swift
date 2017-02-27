//
//  ListarNotasViewController.swift
//  NotasDiarias
//
//  Created by André Luís  Campopiano on 24/02/17.
//  Copyright © 2017 André Luís  Campopiano. All rights reserved.
//

import UIKit

class ListarNotasViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var listaNotas:[NotaEntity] = []
    var navControl:String = "add"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib (nibName: "NotaCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.recoveryListNote()
        
    }
    func recoveryListNote(){
        listaNotas = NotaPersistencia().listNotas()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaNotas.count != 0 ? listaNotas.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if listaNotas.count > 0 {
            let cellNota = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotaCell
            let nota = listaNotas[indexPath.row]
            cellNota.lblTitle.text = nota.titulo
            cellNota.lblSubTitle.text = nota.descricao
            
            let formatDate = DateFormatter()
            formatDate.dateFormat = "dd/MM/yyyy HH:mm"
            
            let newDate = formatDate.string(from: nota.data as Date )
            
            cellNota.lblDate.text = String(describing: newDate )
            cell = cellNota
        }else {
            cell.textLabel?.text = "Nenhum Registro Salvo"
        }
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if( listaNotas.count > 0){
            let nota = listaNotas[indexPath.row]
            self.performSegue(withIdentifier: "segueNovaNota", sender: nota)
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
           NotaPersistencia().delete(position: indexPath.row)
            if self.listaNotas.count > 1 {
                self.listaNotas.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }else {
                self.recoveryListNote()
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueNovaNota" {
            let vc = segue.destination as! NovaNotaViewController
            if sender is NotaEntity {
                vc.position = self.tableView.indexPathForSelectedRow?.row
                vc.note = sender as! NotaEntity
            }
            
            
        }
        
        
        
    }
    

}
