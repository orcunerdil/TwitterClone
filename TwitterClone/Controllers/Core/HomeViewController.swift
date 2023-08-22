//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Orçun Erdil on 11.08.2023.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {

    private var viewModel = HomeViewViewModel()
    private var subscription: Set<AnyCancellable> = []
    
    private func configureNavigationBar() {
        let size: CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.image = UIImage(named: "twLogo")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView
        
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile))
    }
    
    @objc func didTapProfile(){
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
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
        configureNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSignOut))
        bindViews()
    }
    
    @objc func didTapSignOut(){
       try? Auth.auth().signOut()
        handleAuthentication()
    }
    
   
    
    /*
     
     timelineTableView adında bir UITableView öğesi görünümünün boyutu, ana görünümün boyutuna eşitlenir. Bu, timelineTableView'ın görünümün boyutuna tam olarak sığdığını ve ekranda doğru bir şekilde yerleştirildiğini sağlamak için yapılır.
      
     */
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.frame
    }
    
    private func handleAuthentication(){
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
        viewModel.retreiveUser()
    }
    
    func completeUserOnboarding(){
        
        let vc = ProfileDataFormViewController()
        present(vc, animated: true)
        
    }
    
    func bindViews(){
        viewModel.$user.sink { [weak self] user in
            guard let user = user else {return}
            if !user.isUserOnboarded {
                self?.completeUserOnboarding()
            }
        }
        .store(in: &subscription)
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
