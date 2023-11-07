//
//  UserInfoViewController.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import UIKit

protocol UserInfoViewControllerProtocol: AnyObject {
    func showInfoCard()
    func showUserImageCard()
}

final class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var interactor: UserInfoInteractorProtocol
    
    var userInfo: UserInfo
    var imageData: Data
    var repos: [Repos]
    var controlData: [String] = [String]()
    
    lazy var rootView = UserInfoView()
    var sections = [Section]()
    
    init(interactor: UserInfoInteractorProtocol, userInfo: UserInfo, imageData: Data, repos: [Repos]) {
        self.interactor = interactor
        self.userInfo = userInfo
        self.repos = repos
        self.imageData = imageData
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .black
        
        showCardsOnList()
        setupUI()
        
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
    }
    
    func setupUI() {
        rootView.userName.text = userInfo.name
        rootView.userBio.text = userInfo.bio
        rootView.userLocation.text = userInfo.location
        rootView.userCompany.text = userInfo.company
        
        rootView.userArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard)))
        rootView.userImageView.image = UIImage(data: imageData)
        
        rootView.segmentedControl.addTarget(self, action: #selector(segmentChange(_:)), for: .valueChanged)
        
        configureModels()
    }
    
    @objc func segmentChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            rootView.tableView.isHidden = true
            rootView.repositoriesList.isHidden = false
        } else {
            rootView.tableView.isHidden = false
            rootView.repositoriesList.isHidden = true
        }
    }
    
    @objc func flipCard() {
        let isUserImageCard = !rootView.userImageView.isHidden
        UIView.transition(with: rootView.userCard, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
        interactor.flipCard(isUserImageCard: isUserImageCard)
    }
    
    private func configureModels() {
        for repo in repos {
            sections.append(Section(title: repo.name, options: [
                Option(title: repo.description ?? ""),
                Option(title: repo.language ?? ""),
            ]))
        }
    }
    
    private func defineCardColor(language: String) ->UIColor {
        var color: UIColor
        
        switch language {
        case "Python":
            color = .systemBlue
        case "JavaScript":
            color = .systemYellow
        case "Swift":
            color = .systemOrange
        case "Java":
            color = .systemRed
        case "TypeScript":
            color = .systemYellow
        case "C++":
            color = .systemPurple
        default:
            color = .white
        }
        
        return color
    }
    
    private func showCardsOnList() {
        
        guard repos.isEmpty == false else {
            return
        }
        
        func generateCard(_ repo: Repos) -> RepositorieCardView {
            let repositorieCardView = RepositorieCardView()
            
            rootView.repositoriesListContent.addSubview(repositorieCardView)
            repositorieCardView.backgroundColor = defineCardColor(language: repo.language ?? "")
            repositorieCardView.userRepositoriesName.text = repo.name
            repositorieCardView.userRepositoriesLanguage.text = repo.language
            repositorieCardView.userRepositoriesDescription.text = repo.description
            
            return repositorieCardView
        }
        
        func configureFirstCard(firstCard: RepositorieCardView) {
            firstCard.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(rootView.repositoriesListContent.snp.top)
                make.leading.equalTo(rootView.repositoriesListContent.snp.leading).offset(20)
                make.trailing.equalTo(rootView.repositoriesListContent.snp.trailing).offset(-20)
                make.height.equalTo(150)
            }
        }
        
        func configureMiddleCard(middleCard: RepositorieCardView, previousCard: RepositorieCardView) {
            middleCard.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(previousCard.snp.bottom).offset(20)
                make.leading.equalTo(rootView.repositoriesListContent.snp.leading).offset(20)
                make.trailing.equalTo(rootView.repositoriesListContent.snp.trailing).offset(-20)
                make.height.equalTo(150)
            }
        }
        
        func configureLastCard(lastCard: RepositorieCardView) {
            lastCard.snp.makeConstraints { (make) -> Void in
                make.bottom.equalTo(rootView.repositoriesListContent.snp.bottom)
            }
        }
        
        let firstCard = generateCard(repos[0])
        configureFirstCard(firstCard: firstCard)
        
        var previousCard = firstCard
        
        for index in 1..<(repos.count - 1) {
            let card = generateCard(repos[index])
            configureMiddleCard(middleCard: card, previousCard: previousCard)
            
            previousCard = card
        }
        
        let lastIndex = repos.count - 1
        let lastCard = generateCard(repos[lastIndex])
        configureLastCard(lastCard: lastCard)
        configureMiddleCard(middleCard: lastCard, previousCard: previousCard)
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}


extension UserInfoViewController: UserInfoViewControllerProtocol {
    func showInfoCard() {
        rootView.userImageView.isHidden = true
        rootView.segmentedControl.isHidden = true
        
        rootView.userCompany.isHidden = false
        rootView.userLocation.isHidden = false
        rootView.userBio.isHidden = false
        rootView.userName.isHidden = false
    }
    
    func showUserImageCard() {
        rootView.userImageView.isHidden = false
        rootView.segmentedControl.isHidden = false
        
        rootView.userCompany.isHidden = true
        rootView.userLocation.isHidden = true
        rootView.userBio.isHidden = true
        rootView.userName.isHidden = true
    }
}
