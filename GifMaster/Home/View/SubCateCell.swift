//
//  SubCateCell.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/20.
//

import UIKit


class SubCateCell: UICollectionViewCell {


    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    let nameLabel: UILabel = Tools.setUpLabel("Name", 8, .regular, .black)
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(iconImageView)

        
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = K.brandDark.cgColor
        contentView.layer.cornerRadius = 10
        
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        iconImageView.snp.makeConstraints { make  in
            make.bottom.equalTo(contentView).offset(-10)
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
