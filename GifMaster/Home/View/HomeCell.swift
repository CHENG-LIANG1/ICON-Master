//
//  HomeCell.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/20.
//
import UIKit
import SnapKit
import Alamofire
import AlamofireImage

protocol HomeCellDelegate {
    func headinigButtonPressed(cell: HomeCell)
}

class HomeCell: UITableViewCell {


    let headingButton = Tools.setUpButton("Title", K.gradientBlue, 18)
    let cellCollectioinView = Tools.setUpCollectionView(10, 10, .horizontal)
    var delegate: HomeCellDelegate?

    var subCategories = [String]() {
        didSet{
            self.cellCollectioinView.reloadData()
        }
    }
    
    var imgUrls = [String]() {
        didSet{
            self.cellCollectioinView.reloadData()
        }
    }
    var platforms = [String]() {
        didSet{
            self.cellCollectioinView.reloadData()
        }
    }
    
    @objc func tap(sender: UIButton){
        sender.showAnimation { [self] in
            delegate?.headinigButtonPressed(cell: self)
            self.cellCollectioinView.reloadData()
        }

    }
    
    let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .small)
    let arrowImage = UIImageView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        headingButton.titleLabel!.font = UIFont.init(name: "Menlo", size: 22)
        cellCollectioinView.delegate = self
        cellCollectioinView.dataSource = self

        cellCollectioinView.backgroundColor = .white
        cellCollectioinView.register(SubCateCell.self, forCellWithReuseIdentifier: "SubCateCell")
        

        headingButton.addTarget(self, action: #selector(tap(sender:)), for: .touchUpInside)
        
        contentView.addSubview(headingButton)
        contentView.addSubview(cellCollectioinView)
        contentView.addSubview(arrowImage)
        
        headingButton.backgroundColor = K.gradientBlue
        headingButton.layer.cornerRadius = 5
        headingButton.clipsToBounds = true
        headingButton.setTitleColor(K.brandDark, for: .normal)
        Tools.setHeight(headingButton, 25)

        
        arrowImage.image = UIImage(systemName: "chevron.compact.right", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        headingButton.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(20)

        }

        cellCollectioinView.snp.makeConstraints{ make in
            make.top.equalTo(headingButton.snp_bottomMargin).offset(10)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        arrowImage.centerYAnchor.constraint(equalTo: headingButton.centerYAnchor).isActive = true
        arrowImage.snp.makeConstraints { make  in
            make.left.equalTo(headingButton.snp_rightMargin).offset(8)

        }

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HomeCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCateCell", for: indexPath) as! SubCateCell

        cell.iconImageView.af.setImage(withURL: URL(string: imgUrls[indexPath.row])!)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = IconDetailViewController()
        vc.imgUrl = imgUrls[indexPath.row]
        vc.platform = platforms[indexPath.row]
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
}
