//
//  ViewController.swift
//  10_30_Dojo
//
//  Created by Luciana on 01/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBarItem: UISearchBar!
    @IBOutlet weak var tableViewItem: UITableView!
    @IBOutlet weak var tableViewConfiguration: UITableView!
    
    var arrayItemGlobal = [Item]()
    var arrayItemOpen = [Item]()
    var arrayItemClose = [Item]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewItem.delegate = self
        tableViewItem.dataSource = self
        searchBarItem.delegate = self
        
        arrayItemGlobal.append(Item(name: "Maça", isOpen: true))
        arrayItemGlobal.append(Item(name: "Laranja", isOpen: true))
        arrayItemGlobal.append(Item(name: "Melancia", isOpen: true))
        arrayItemGlobal.append(Item(name: "Arroz", isOpen: true))
        arrayItemGlobal.append(Item(name: "Feijão", isOpen: true))
        arrayItemGlobal.append(Item(name: "Farinha", isOpen: false))
        arrayItemGlobal.append(Item(name: "Açucar", isOpen: false))
        arrayItemGlobal.append(Item(name: "Sal", isOpen: false))
        arrayItemGlobal.append(Item(name: "Azeite", isOpen: false))
        arrayItemGlobal.append(Item(name: "Macarrão", isOpen: false))
        loadData()
    }
    
    @IBAction func actionButtonAdd(_ sender: Any) {
        showAlert(nil)
    }
    
    func loadData(){
        arrayItemOpen.removeAll()
        arrayItemClose.removeAll()
        for item in arrayItemGlobal {
            if item.isOpen == true {
                arrayItemOpen.append(item)
            }else if item.isOpen == false {
                arrayItemClose.append(item)
            }
        }
        tableViewItem.reloadData()
    }
    
    func addItem(item: Item){
        let itemAdd = Item(name: item.name, isOpen: true)
        arrayItemGlobal.append(itemAdd)
        loadData()
    }
    
    func deleteItem(item: Item) {
        if !arrayItemGlobal.isEmpty {
            arrayItemGlobal.removeAll() {$0.name.lowercased() == item.name.lowercased()}
            loadData()
        }
    }
    
    func editItem(item: Item) {
        let itemReceive = arrayItemGlobal.first() {$0.name.lowercased() == item.name.lowercased()}
        itemReceive!.isOpen = item.isOpen
        loadData()
    }
    
    func markOpen(item: Item) {
        let itemUpdate = arrayItemGlobal.first() {$0.name.lowercased() == item.name.lowercased()}
        itemUpdate!.isOpen = true
        loadData()
    }
    
    func markClose(item: Item) {
        let itemUpdate = arrayItemGlobal.first() {$0.name.lowercased() == item.name.lowercased()}
        itemUpdate!.isOpen = false
        loadData()
    }
    
    func showAlert(_ item: Item?) {
        let alert = UIAlertController(title: "", message: "Digite o nome do item", preferredStyle: .alert)
        
        alert.addTextField { (textFieldName) in
            textFieldName.placeholder = "Ex.: Maçã"
            textFieldName.tag = 1
            textFieldName.text = item?.name
            
        }
        
        let buttonCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let buttonSave = UIAlertAction(title: "Salvar", style: .default) { _ in
            guard let nameField = (alert.view.viewWithTag(1) as? UITextField) else {
                return
        }
            if let name = nameField.text{
                if let editItem = item {
                    editItem.name = name
                    alert.title = "Editar"
                    self.editItem(item: editItem)
                } else {
                    alert.title = "Criar"
                    self.addItem(item: Item(name: name, isOpen: true))
                }
            }
        }
        alert.addAction(buttonCancel)
        alert.addAction(buttonSave)
        present(alert, animated: true, completion: nil)
    }
    
    func deleteAlert(itemDelete: Item) {
        let deleteItem = Item(name: itemDelete.name, isOpen: itemDelete.isOpen)
        
        let alertDelete = UIAlertController(title: "Atenção",
                                            message: "Tem certeza que deseja apagar este item?",
                                            preferredStyle: .alert)
        let buttonNo = UIAlertAction(title: "Não", style: .default, handler: nil)
        let buttonYes = UIAlertAction(title: "Sim", style: .default) { (itemDelete) in
            self.deleteItem(item: deleteItem)
           
        }
        alertDelete.addAction(buttonNo)
        alertDelete.addAction(buttonYes)
    present(alertDelete, animated: true, completion: nil)
    }
    
    func actionSheetTableView(item: Item) {
        let alertTable = UIAlertController(title: "", message: "Selecione a opção desejada", preferredStyle: .actionSheet)
        
        let itemTable = Item(name: item.name, isOpen: item.isOpen)
        
        if itemTable.isOpen == true {
            alertTable.addAction(UIAlertAction(title: "Marcar como concluído", style: .default) { (itemTable) in
                self.markClose(item: item)})
        } else {
            alertTable.addAction(UIAlertAction(title: "Marcar como aberto", style: .default) { (itemTable) in
                self.markOpen(item: item)
            })
        }
        alertTable.addAction(UIAlertAction(title: "Editar", style: .default, handler: { (itemTable) in
            self.showAlert(item)
        }))
        alertTable.addAction(UIAlertAction(title: "Excluir", style: .default, handler: { (itemTable) in
            self.deleteAlert(itemDelete: item)
        }))
        
        alertTable.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertTable, animated: true, completion: nil)
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

}

}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let itemOpen = arrayItemOpen[indexPath.row]
            actionSheetTableView(item: itemOpen)
        } else {
            let itemClose = arrayItemClose[indexPath.row]
            actionSheetTableView(item: itemClose)
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if section == 0 {
            rowCount = arrayItemOpen.count
        }
        if section == 1 {
            rowCount = arrayItemClose.count
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Abertos"
        case 1:
            return "Concluídos"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        if indexPath.section == 0 {
            cellItem.setup(item: arrayItemOpen[indexPath.row])
        } else {
            cellItem.setup(item: arrayItemClose[indexPath.row])
        }
        return cellItem
    }
    
    
}



