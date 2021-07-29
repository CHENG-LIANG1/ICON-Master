//
//  CategoryDetailViewController.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/22.
//

import UIKit

class CategoryDetailViewController: UIViewController {

    var titleText: String?
    let detailCollectionView = Tools.setUpCollectionView(10, 10, .vertical)
    var imgUrls: [String]?
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = titleText
        self.view.backgroundColor = .white
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.backgroundColor = .white
        detailCollectionView.showsVerticalScrollIndicator = false
        detailCollectionView.register(SubCateCell.self, forCellWithReuseIdentifier: "SubCateCell")
        view.addSubview(detailCollectionView)
        
        detailCollectionView.snp.makeConstraints { make  in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }

    }
    


}
extension CategoryDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgUrls!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCateCell", for: indexPath) as! SubCateCell

        cell.iconImageView.af.setImage(withURL: URL(string: imgUrls![indexPath.row])!)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = IconDetailViewController()
        vc.imgUrl = imgUrls![indexPath.row]
        
    }
}
