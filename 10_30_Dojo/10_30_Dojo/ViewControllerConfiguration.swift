//
//  ViewControllerConfiguration.swift
//  10_30_Dojo
//
//  Created by Luciana on 03/11/20.
//

import UIKit

class ViewControllerConfiguration: UIViewController {
    
    @IBOutlet weak var tableViewConfiguration: UITableView!
    
    var configuration = [Configuration]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfiguration.delegate = self
        tableViewConfiguration.dataSource = self

        configuration.append(Configuration(description: "Avaliar o app"))
        configuration.append(Configuration(description: "Suporte"))
        configuration.append(Configuration(description: "Relatar um problema por e-mail"))
    }

}
extension ViewControllerConfiguration: UITableViewDelegate {
    
}

extension ViewControllerConfiguration: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuration.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigurationCell") as! ConfigurationCell
        cell.accessoryType = .disclosureIndicator
        cell.setup(title: configuration[indexPath.row])
        return cell
    }
    
    
}

