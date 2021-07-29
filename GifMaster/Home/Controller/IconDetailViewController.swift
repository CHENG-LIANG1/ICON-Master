//
//  IconDetailViewController.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/22.
//

import UIKit
import SCLAlertView

class IconDetailViewController: UIViewController {
    var imgUrl: String?
    var platform: String?
    let iconImage = UIImageView()
    let headingLabel = Tools.setUpLabel("icons in this platform", 19, .bold, .black)
    let platformCollectionView = Tools.setUpCollectionView(10, 10, .vertical)
    
    var searchResult: SubCateModel?
    var names: [String] = []
    var imgUrls: [String] = []
    
    let downloadButton = Tools.setUpButton("Share", .white, 20)
    let closeButton = Tools.setUpButton("Close", .white, 15)
    
//    @objc func image(_ image: UIImage,
//         didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//
//         if let error = error {
//             print("ERROR: \(error)")
//         }else {
//            let appearence = SCLAlertView.SCLAppearance(
//                showCloseButton: false
//            )
//
//            let alertView = SCLAlertView(appearance: appearence)
//            alertView.addButton("OK", action: {
//
//            })
//            alertView.showTitle("Downloaded", subTitle: "icon saved to the album", style: .success, colorStyle: 0x29BB89)
//         }
//     }
//
    @objc func closeAction(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func download(sender: UIButton){
        sender.showAnimation {
            let imageToshare = [self.iconImage.image!]
            let activityViewController = UIActivityViewController(activityItems: imageToshare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func getIconsInAPlatform(onCompletion:@escaping () -> ()){
        let urlString = "https://api-icons.icons8.com/publicApi/icons?token=\(K.token)&platform=\(platform ?? "none")"

        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { [self]data, response, error in
            if error == nil {
                do{
                    self.searchResult = try JSONDecoder().decode(SubCateModel.self, from: data!)
                    
                    for doc in (searchResult?.docs)! {
                        names.append(doc.commonName)
                    }
    
                    DispatchQueue.main.async {
                        onCompletion()
                    }

                }catch{
                    print(error)
                }
            }
        }).resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconImage.af.setImage(withURL: URL(string: imgUrl!)!)
        platformCollectionView.delegate = self
        platformCollectionView.dataSource = self
        platformCollectionView.register(SubCateCell.self, forCellWithReuseIdentifier: "SubCateCell")
        platformCollectionView.backgroundColor = .white
        downloadButton.layer.borderWidth = 3
        downloadButton.layer.borderColor = K.brandGreen.cgColor
        downloadButton.layer.cornerRadius = 10
        Tools.setHeight(downloadButton, 45)
        downloadButton.addTarget(self, action: #selector(download(sender:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeAction(sender:)), for: .touchUpInside)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        
        platformCollectionView.showsVerticalScrollIndicator = false
        
        view.backgroundColor = .white
        view.addSubview(iconImage)
        view.addSubview(headingLabel)
        view.addSubview(platformCollectionView)
        view.addSubview(downloadButton)
        view.addSubview(closeButton)
        
        iconImage.widthAnchor.constraint(equalToConstant: K.screenWidth - 200).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: K.screenWidth - 200).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImage.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(30)
        }
        
        downloadButton.setTitleColor(K.brandGreen, for: .normal)
        downloadButton.snp.makeConstraints { make  in
            make.top.equalTo(iconImage.snp_bottomMargin).offset(30)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
        }
        
        headingLabel.snp.makeConstraints { make  in
            make.top.equalTo(downloadButton.snp_bottomMargin).offset(30)
            make.left.equalTo(view).offset(20)
        }
        
        platformCollectionView.snp.makeConstraints { make  in
            make.top.equalTo(headingLabel).offset(30)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-60)
        }
        
        closeButton.snp.makeConstraints { make  in
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view).offset(10)
        }
        
        
        getIconsInAPlatform {
            for name in self.names {
                let imgUrl = "https://img.icons8.com/" + self.platform! + "/256/000000/" + name + ".png"
                self.imgUrls.append(imgUrl)
            }
            self.platformCollectionView.reloadData()
            
        }
        
        
    }

}

extension IconDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
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
        vc.platform = platform
        self.present(vc, animated: true, completion: nil)
    }
    
}

