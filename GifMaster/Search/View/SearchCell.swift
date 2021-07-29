//
//  SearchCell.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/27.
//


import UIKit

class SearchCell: UITableViewCell {


    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return iv
    }()
    
    let nameLabel = Tools.setUpLabel("Name:", 15, .bold, .black)
    let name = Tools.setUpLabel("Name", 15, .regular, .black)
    let platformLabel = Tools.setUpLabel("Platform:", 15, .bold, .black)
    let platform = Tools.setUpLabel("Platform", 15, .regular, .black)
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(name)
        contentView.addSubview(platformLabel)
        contentView.addSubview(platform)
        
        iconImage.snp.makeConstraints { make  in
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(contentView).offset(10)
        }
        
        nameLabel.snp.makeConstraints { make  in
            make.top.equalTo(contentView).offset(13)
            make.left.equalTo(iconImage.snp_rightMargin).offset(16)
        }
        
        name.snp.makeConstraints { make  in
            make.top.equalTo(contentView).offset(13)
            make.left.equalTo(nameLabel.snp_rightMargin).offset(16)
        }
        
        platformLabel.snp.makeConstraints { make  in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(15)
            make.left.equalTo(iconImage.snp_rightMargin).offset(16)
        }
        
        platform.snp.makeConstraints { make  in
            make.top.equalTo(name.snp_bottomMargin).offset(15)
            make.left.equalTo(platformLabel.snp_rightMargin).offset(16)
        }
        
        
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

