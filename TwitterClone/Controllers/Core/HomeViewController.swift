//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Orçun Erdil on 11.08.2023.
//

import UIKit

class HomeViewController: UIViewController {

    private let timelineTableView = {
       let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(timelineTableView)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
    }
    
    
    
    /*
     
     timelineTableView adında bir UITableView öğesi görünümünün boyutu, ana görünümün boyutuna eşitlenir. Bu, timelineTableView'ın görünümün boyutuna tam olarak sığdığını ve ekranda doğru bir şekilde yerleştirildiğini sağlamak için yapılır.
      
     */
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.frame
    }
    
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "TEST TEST"
        return cell
    }
    
    
}
