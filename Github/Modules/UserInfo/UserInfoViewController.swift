//
//  UserInfoViewController.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import UIKit

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
        
        showCardsOnList()
        
        rootView.userImageView.image = UIImage(data: imageData)
        
        //configureModels()
        
        //rootView.tableView.dataSource = self
        //rootView.tableView.delegate = self
    }
    
    private func showCardsOnList() {
        var counter = 0
        
        for repo in repos {
            let repositorieCardView = RepositorieCardView()
            
            rootView.repositoriesListContent.addSubview(repositorieCardView)
            
            repositorieCardView.userRespositoriesView.backgroundColor = defineCardColor(language: repo.language ?? "")
            repositorieCardView.userRepositoriesName.text = repo.name
            repositorieCardView.userRepositoriesLanguage.text = repo.language
            repositorieCardView.userRepositoriesDescription.text = repo.description
            
            setUserRespositoriesConstraints(repositorieCardView: repositorieCardView, element: counter)
            counter += 1
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
    
    private func setUserRespositoriesConstraints(repositorieCardView: RepositorieCardView, element: Int) {
        
        NSLayoutConstraint.activate([
            repositorieCardView.userRespositoriesView.centerXAnchor.constraint(equalTo: rootView.repositoriesList.centerXAnchor),
            repositorieCardView.userRespositoriesView.topAnchor.constraint(equalTo: rootView.repositoriesList.topAnchor, constant: element == 0 ? 0 : CGFloat(180 * element)),
            repositorieCardView.userRespositoriesView.widthAnchor.constraint(equalToConstant: 350),
            repositorieCardView.userRespositoriesView.heightAnchor.constraint(equalToConstant: 150),
        ])

        NSLayoutConstraint.activate([
            repositorieCardView.userRepositoriesName.leftAnchor.constraint(equalTo: repositorieCardView.userRespositoriesView.leftAnchor, constant: 20),
            repositorieCardView.userRepositoriesName.topAnchor.constraint(equalTo: repositorieCardView.userRespositoriesView.topAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            repositorieCardView.userRepositoriesDescription.leftAnchor.constraint(equalTo: repositorieCardView.userRespositoriesView.leftAnchor, constant: 20),
            repositorieCardView.userRepositoriesDescription.topAnchor.constraint(equalTo: repositorieCardView.userRespositoriesView.topAnchor, constant: 60),
            repositorieCardView.userRepositoriesDescription.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        NSLayoutConstraint.activate([
            repositorieCardView.userRespositoriesView.rightAnchor.constraint(equalTo: repositorieCardView.userRepositoriesLanguage.rightAnchor, constant: 20),
            repositorieCardView.userRepositoriesLanguage.topAnchor.constraint(equalTo: repositorieCardView.userRespositoriesView.topAnchor, constant: 20),
        ])
    }
    
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
}
