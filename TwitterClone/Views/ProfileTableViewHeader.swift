//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by Orçun Erdil on 15.08.2023.
//

import UIKit

class ProfileTableViewHeader: UIView {

    
    private enum sectionTabs : String {
        
        case tweets = "Tweets"
        case tweetsAndReplies = "Tweets & Replies"
        case media = "Media"
        case likes = "Likes"
        
        var index : Int {
            switch self {
            case .tweets:
                return 0
            case .tweetsAndReplies:
                return 1
            case .media:
                return 2
            case .likes:
                return 3
            }
        }
    }
    
    private var leadingAnchors : [NSLayoutConstraint] = []
    private var trailingAnchors : [NSLayoutConstraint] = []
    
    private let indicator: UIView = {
       
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        
        return view
    }()
    
    //ilk yüklendiğinde 0. index yani tweetler label renginde olcak diğerleri secondarylabel
    //hangi indeksi seçersek onun rengi ilk yüklendiğinde label rengi olur.
    
    private var selectedTab: Int = 0 {
        didSet{
                for i in 0..<self.tabs.count {
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {[weak self] in
                    self?.sectionStack.arrangedSubviews[i].tintColor = i == self?.selectedTab ? .label : .secondaryLabel
                        self?.leadingAnchors[i].isActive = i == self?.selectedTab ? true : false
                        self?.trailingAnchors[i].isActive = i == self?.selectedTab ? true : false
                        self?.layoutIfNeeded()
                }
                
            }
            
        }
    }
    
    private var tabs : [UIButton] = ["Tweets","Tweets & Replies","Media","Likes"]
        .map{ buttonTitle in
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.tintColor = .label
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    
    private lazy var sectionStack : UIStackView = {
       
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    
    private let followersTextLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Followers"
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let followersCountLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "213"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
        
    }()
    
    private let followingTextLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Following"
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let followingCountLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "113"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let joinDataLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Joined May 2023"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
        
    }()
    
    private let joinDateImageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar",withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userBioLabel : UILabel = {
        
        let label = UILabel()
        label.text = "ceng"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    private let usernameLabel : UILabel = {
       
        let label = UILabel()
        label.text = "@orcunerdil"
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let displayNameLabel :UILabel = {
       
        let label = UILabel()
        label.text = "Orcun"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let profileAvatarImageView : UIImageView = {
       
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .yellow
        imageView.image = UIImage(named: "pp")
        return imageView
        
    }()
    
    private let profileHeaderImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "header")
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileHeaderImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(usernameLabel)
        addSubview(userBioLabel)
        addSubview(joinDataLabel)
        addSubview(joinDateImageView)
        addSubview(followersTextLabel)
        addSubview(followingTextLabel)
        addSubview(followersCountLabel)
        addSubview(followingCountLabel)
        addSubview(sectionStack)
        addSubview(indicator)
        configureConstraints()
        configureStackButtons()
    }
    
    private func configureStackButtons() {
        for(i,button) in sectionStack.arrangedSubviews.enumerated(){
            guard let button = button as? UIButton else {return}
            
            if i == selectedTab {
                button.tintColor = .label
            }else {
                button.tintColor = .secondaryLabel
            }
            
            button.addTarget(self, action: #selector(didTapTab), for: .touchUpInside)
        }
    }

    @objc func didTapTab(_ sender:UIButton){
        guard let label = sender.titleLabel?.text else {return}
        switch label {
        case sectionTabs.tweets.rawValue:
            selectedTab = 0
        case sectionTabs.tweetsAndReplies.rawValue:
            selectedTab = 1
        case sectionTabs.media.rawValue:
            selectedTab = 2
        case sectionTabs.likes.rawValue:
            selectedTab = 3
        default:
            selectedTab = 0
        }
    }
    
    private func configureConstraints(){
        
        
        for i in 0..<tabs.count {
            let leadingAnchor = indicator.leadingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].leadingAnchor)
            leadingAnchors.append(leadingAnchor)
            let trailingAnchor = indicator.trailingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].trailingAnchor)
            trailingAnchors.append(trailingAnchor)
        }
        
        let profileHeaderImageViewConstraints = [
            profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let profileAvatarImageViewConstraints = [
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor, constant: 10),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let displayNameLabelConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 20)
        ]
        
        let usernameLabelConstraints = [
            
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5)
            
        ]
        
        let userBioLabelConstraints = [
            userBioLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            userBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5)
        ]
        
        let joinDateImageViewConstraints = [
            joinDateImageView.leadingAnchor.constraint(equalTo: userBioLabel.leadingAnchor),
            joinDateImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 5)
        ]
        
        let joinDataLabelConstraints = [
            joinDataLabel.leadingAnchor.constraint(equalTo: joinDateImageView.trailingAnchor, constant: 2),
            joinDataLabel.bottomAnchor.constraint(equalTo: joinDateImageView.bottomAnchor)
            
        ]
        
        let followingCountLabelConstraints = [
            
            followingCountLabel.leadingAnchor.constraint(equalTo: joinDateImageView.leadingAnchor),
            followingCountLabel.topAnchor.constraint(equalTo: joinDateImageView.bottomAnchor, constant: 10)
        ]
        
        let followingTextLabelConstraints = [
                
            followingTextLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant: 4),
            followingTextLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor)
        ]
        
        let followersCountLabelConstraints = [
            
            followersCountLabel.leadingAnchor.constraint(equalTo: followingTextLabel.trailingAnchor,constant: 8),
            followersCountLabel.bottomAnchor.constraint(equalTo: followingTextLabel.bottomAnchor)
        ]
        
        let followersTextLabelConstraints = [
                
            followersTextLabel.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor, constant: 4),
            followersTextLabel.bottomAnchor.constraint(equalTo: followersCountLabel.bottomAnchor)
        ]
        
        let sectionStackViewConstraints = [
            sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            sectionStack.topAnchor.constraint(equalTo: followingTextLabel.bottomAnchor, constant: 5),
            sectionStack.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let indicatorConstraints = [
            leadingAnchors[0],
            trailingAnchors[0],
            indicator.topAnchor.constraint(equalTo: sectionStack.arrangedSubviews[0].bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ]
        NSLayoutConstraint.activate(profileHeaderImageViewConstraints)
        NSLayoutConstraint.activate(profileAvatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(usernameLabelConstraints)
        NSLayoutConstraint.activate(userBioLabelConstraints)
        NSLayoutConstraint.activate(joinDateImageViewConstraints)
        NSLayoutConstraint.activate(joinDataLabelConstraints)
        NSLayoutConstraint.activate(followingCountLabelConstraints)
        NSLayoutConstraint.activate(followingTextLabelConstraints)
        NSLayoutConstraint.activate(followersCountLabelConstraints)
        NSLayoutConstraint.activate(followersTextLabelConstraints)
        NSLayoutConstraint.activate(sectionStackViewConstraints)
        NSLayoutConstraint.activate(indicatorConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
}
