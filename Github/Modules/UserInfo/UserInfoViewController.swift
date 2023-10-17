//
//  UserInfoViewController.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
    var interactor: UserInfoInteractorProtocol
    var userInfo: UserInfo
    var imageData: Data
    lazy var rootView = UserInfoView()
    
    init(interactor: UserInfoInteractorProtocol, userInfo: UserInfo, imageData: Data) {
        self.interactor = interactor
        self.userInfo = userInfo
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
        
        rootView.userImageView.image = UIImage(data: imageData)
        rootView.userNameView.text = userInfo.login
    }
}
