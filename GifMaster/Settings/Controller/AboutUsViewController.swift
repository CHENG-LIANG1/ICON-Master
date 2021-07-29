//
//  AboutUsViewController.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/29.
//

import UIKit

class AboutUsViewController: UIViewController {
    let iconImageView = UIImageView()
    let versionIDLabel = Tools.setUpLabel(K.VersionID, 18, .bold, .black)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About Us"
        iconImageView.image = UIImage(named: "icon")
        versionIDLabel.textAlignment = .center
        view.backgroundColor = .white
        
        view.addSubview(iconImageView)
        view.addSubview(versionIDLabel)
        
        iconImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImageView.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(150)
        }
        
        versionIDLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        versionIDLabel.snp.makeConstraints { make  in
            make.top.equalTo(iconImageView.snp_bottomMargin).offset(30)
        }
        
        
    }
    

}
