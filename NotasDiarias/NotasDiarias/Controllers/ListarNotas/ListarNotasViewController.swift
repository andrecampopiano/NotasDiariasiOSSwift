//
//  ListarNotasViewController.swift
//  NotasDiarias
//
//  Created by André Luís  Campopiano on 24/02/17.
//  Copyright © 2017 André Luís  Campopiano. All rights reserved.
//

import UIKit

class ListarNotasViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var listaNotas:[Dictionary<String,String>] = []
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //listaNotas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotaCell
        
        //let nota = listaNotas[indexPath.row]
        
//        cell.lblSubTitle.text = nota(value(forKey: "descricao"))
        
        cell.lblSubTitle.text = "Testando"
        cell.lblTitle.text = "TITULO TESTE"
        cell.lblDate.text = "19/05/1983"
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navControl = "edit"
        self.performSegue(withIdentifier: "segueNovaNota", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            print("foi ai em ")
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
            
            if navControl == "edit" {
                vc.nota = listaNotas[sender as! Int]
                vc.navControl = navControl
            }
            
            
            
        }
        
        
        
    }
    

}
