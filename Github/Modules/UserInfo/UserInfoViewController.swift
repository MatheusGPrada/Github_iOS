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
        
        print("Repos: \(repos[0])")
        
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
        
        //configureModels()
        
        rootView.repositorieCardView.userRepositoriesName.text = repos[0].name
        rootView.repositorieCardView.userRepositoriesLanguage.text = repos[0].language
        rootView.repositorieCardView.userRepositoriesDescription.text = repos[0].description
        rootView.userImageView.image = UIImage(data: imageData)
        
        //rootView.tableView.dataSource = self
        //rootView.tableView.delegate = self
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
}
