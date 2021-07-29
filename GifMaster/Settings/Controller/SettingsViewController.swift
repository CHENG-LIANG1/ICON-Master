//
//  ProfileViewController.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/20.
//

import UIKit

class SettingsViewController: UIViewController {

    let iconImageView = UIImageView()
    let aboutUsButton = Tools.setUpButton("About Us", K.brandPink, 20)
    let shareButton  = Tools.setUpButton("Share this app", K.brandPink, 20)
    
    
    @objc func aboutUsPressed(sender: UIButton){
        sender.showAnimation {
            let vc = AboutUsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func sharePressed(sender: UIButton){
        sender.showAnimation {
            [self] in
                let imageToshare = [self.iconImageView.image!]
                let activityViewController = UIActivityViewController(activityItems: imageToshare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        iconImageView.image = UIImage(named: "icon")
        
        aboutUsButton.addTarget(self, action: #selector(aboutUsPressed(sender:)), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(sharePressed(sender:)), for: .touchUpInside)
        
        view.addSubview(iconImageView)
        view.addSubview(aboutUsButton)
        view.addSubview(shareButton)
        
        iconImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImageView.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(150)
        }
        

        Tools.setHeight(aboutUsButton, 40)
        aboutUsButton.snp.makeConstraints { make  in
            make.top.equalTo(iconImageView.snp_bottomMargin).offset(30)
            make.left.equalTo(view).offset(100)
            make.right.equalTo(view).offset(-100)
        }
        
        Tools.setHeight(shareButton, 40)
        shareButton.snp.makeConstraints { make  in
            make.top.equalTo(aboutUsButton.snp_bottomMargin).offset(20)
            make.left.equalTo(view).offset(100)
            make.right.equalTo(view).offset(-100)
        }
        
    }
}
