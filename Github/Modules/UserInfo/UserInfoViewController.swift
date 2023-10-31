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

final class UserInfoViewController: UIViewController {
    // final class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var interactor: UserInfoInteractorProtocol
    
    var userInfo: UserInfo
    var imageData: Data
    var repos: [Repos]
    
    lazy var rootView = UserInfoView()
    
    //private var sections = [Section]()
    
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
        
        rootView.userName.text = userInfo.name
        rootView.userBio.text = userInfo.bio
        rootView.userLocation.text = userInfo.location
        rootView.userCompany.text = userInfo.company
        
        rootView.userArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard)))
        rootView.userImageView.image = UIImage(data: imageData)
        
        //configureModels()
        
        //rootView.tableView.dataSource = self
        //rootView.tableView.delegate = self
    }
    
    @objc func flipCard() {
        let isUserImageCard = !rootView.userImageView.isHidden
        UIView.transition(with: rootView.userCard, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
        interactor.flipCard(isUserImageCard: isUserImageCard)
        
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
            NSLayoutConstraint.activate([
                firstCard.topAnchor.constraint(equalTo: rootView.repositoriesListContent.topAnchor),
                firstCard.leadingAnchor.constraint(equalTo: rootView.repositoriesListContent.leadingAnchor, constant: 20),
                rootView.repositoriesListContent.trailingAnchor.constraint(equalTo: firstCard.trailingAnchor, constant: 20),
                firstCard.heightAnchor.constraint(equalToConstant: 150),
            ])
        }
        
        func configureMiddleCard(middleCard: RepositorieCardView, previousCard: RepositorieCardView) {
            NSLayoutConstraint.activate([
                middleCard.topAnchor.constraint(equalTo: previousCard.bottomAnchor, constant: 20),
                middleCard.leadingAnchor.constraint(equalTo: rootView.repositoriesListContent.leadingAnchor, constant: 20),
                rootView.repositoriesListContent.trailingAnchor.constraint(equalTo: middleCard.trailingAnchor, constant: 20),
                middleCard.heightAnchor.constraint(equalToConstant: 150),
            ])
        }
        
        func configureLastCard(lastCard: RepositorieCardView) {
            NSLayoutConstraint.activate([
                lastCard.bottomAnchor.constraint(equalTo: rootView.repositoriesListContent.bottomAnchor),
            ])
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
    }


extension UserInfoViewController: UserInfoViewControllerProtocol {
    func showInfoCard() {
        rootView.userImageView.isHidden = true
        
        rootView.userCompany.isHidden = false
        rootView.userLocation.isHidden = false
        rootView.userBio.isHidden = false
        rootView.userName.isHidden = false
    }
    
    func showUserImageCard() {
        rootView.userImageView.isHidden = false
        
        rootView.userCompany.isHidden = true
        rootView.userLocation.isHidden = true
        rootView.userBio.isHidden = true
        rootView.userName.isHidden = true
    }
}

//    private func configureModels() {
//        sections.append(Section(title: "Informações Pessoais", options: [
//            Option(title: userInfo.name),
//            Option(title: userInfo.bio),
//            Option(title: userInfo.company),
//            Option(title: userInfo.location),
//            Option(title: "Seguidores: " + String(userInfo.followers)),
//            Option(title: "Seguindo " + String(userInfo.following)),
//        ]))
//    }
    
    
    
    // MARK: - TableView
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].options.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model = sections[indexPath.section].options[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = model.title
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let model = sections[indexPath.section].options[indexPath.row]
//        if((model.handler) != nil){
//            model.handler!()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let model = sections[section]
//        return model.title
//    }
