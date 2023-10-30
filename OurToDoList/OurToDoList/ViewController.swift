//
//  ViewController.swift
//  OurToDoList
//
//  Created by 서정원 on 10/30/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {


    private let table : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,forCellReuseIdentifier: "cell" )
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DoToList"
        view.addSubview(table)
        table.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {       //section 의 행 수
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
