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
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DoToList"
        view.addSubview(table)          //제목을 넣어 준다.
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))                  // 우측 상단에 + 버튼을 만들어 준다.
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
    }
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "할일 추가하기", message: "할일을 추가해보세요 !", preferredStyle: .alert)             //
        alert.addTextField { field in
            field.placeholder = "할일을 적어보세요!"            //입력칸 뒤에 반투명으로 무엇을 입력해야 할 지 안내하는 문구
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self]//확인 버튼
            (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    //Enter New To Do List
                    DispatchQueue.main.async {              //재실행을 해도 적용이 된다.
                        var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                        currentItems.append(text)
                        
                        UserDefaults.standard.setValue(currentItems, forKey: "items")
                        self?.items.append(text)                // 여긴 왜 옵셔널로 줘야 하는가.
                        self?.table.reloadData()
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))       // 취소 버튼
        
        present(alert,animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {       //section 의 행 수
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            UserDefaults.standard.set(items, forKey: "items")           //삭제 후 재부팅을 해도 삭제가 된다.
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
