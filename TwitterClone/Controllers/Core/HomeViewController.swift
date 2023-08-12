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
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        return cell
        
    }

    
    
}

extension HomeViewController : TweetTableViewCellDelegate {
    func tweetTableViewCellDidTapReply() {
        print("Reply")
    }
    
    func tweetTableViewCellDidTapRetweet() {
        print("Retweet")

    }
    
    func tweetTableViewCellDidTapLike() {
        print("Like")

    }
    
    func tweetTableViewCellDidTapShare() {
        print("Share")

    }
    
    
}
