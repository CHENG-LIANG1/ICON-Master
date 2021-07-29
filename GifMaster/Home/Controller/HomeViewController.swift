//
//  HomeViewController.swift
//  ICONMaster
//
//  Created by 梁程 on 2021/7/20.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class HomeViewController: UIViewController {
    let homeTableView = Tools.setUpTableView()
    var iconsData: iconData?
    var categories: [String] = []
    var apiCodes: [String] = []
    var subNames: [String] = []
    var searchResult: SubCateModel?
    var names: [String] = []
    var platforms: [String] = []
    var imageUrls: [String] = []
    var urlSet: [[String]] = [[]]

    enum FetchError: Error {
        case networkError
    }

    let loadingView = NVActivityIndicatorView(frame: CGRect(x: K.screenWidth / 2 - 50, y: K.screenHeight / 3, width: 100, height: 50), type: .ballGridPulse, color: K.brandPink, padding: 1.0)


    func getCategories(onCompletion:@escaping () -> ()){
        let urlString = K.API + "categories" + "?token=" + K.token
        
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { [self]data, response, error in
            if error == nil {
                do{
                    self.iconsData = try JSONDecoder().decode(iconData.self, from: data!)
                    for i in 0..<iconsData!.docs.count{
                        categories.append((iconsData?.docs[i].name)!)
                        
                        apiCodes.append((iconsData?.docs[i].apiCode)!)
                        

                        for subCategory in (iconsData?.docs[i].subcategories)! {
                            subNames.append(subCategory.name)
                        }

                        K.globalCate.append(subNames)
                
                        subNames = []
                    
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
    
    func getIconPreview(_ apiCode: String, onCompletion:@escaping () -> ()){
        let urlString = "https://api-icons.icons8.com/publicApi/icons?token=\(K.token)&category=\(apiCode)"

        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { [self]data, response, error in
            if error == nil {
                do{
                    self.searchResult = try JSONDecoder().decode(SubCateModel.self, from: data!)
                    
                    for doc in (searchResult?.docs)! {
                        names.append(doc.commonName)
                        platforms.append(doc.platform)
                    }
                    
                    if platforms.count != names.count {
                        throw FetchError.networkError
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
        view.addSubview(homeTableView)
        view.addSubview(loadingView)
        self.title = "ICON Master"

        loadingView.startAnimating()
        getCategories {
            self.loadingView.stopAnimating()
            self.homeTableView.reloadData()
        }
        
        self.view.backgroundColor = .white

        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.rowHeight = 120
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        

        homeTableView.register(HomeCell.self, forCellReuseIdentifier: "HomeCell")
        homeTableView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(0)
            make.left.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
        }


    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        K.APICode = apiCodes[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        cell.headingButton.setTitle(" \(categories[indexPath.row].capitalizingFirstLetter()) ", for: .normal) 
        cell.subCategories = K.globalCate[indexPath.row]
        

  
        getIconPreview(apiCodes[indexPath.row], onCompletion: { [self] in
             imageUrls = []
             
             for i in 0..<names.count {
                
                 let imgUrl = "https://img.icons8.com/" + platforms[i] + "/256/000000/" + names[i] + ".png"
                 imageUrls.append(imgUrl)
             }
             cell.platforms = platforms
             cell.imgUrls = imageUrls
             self.names = []
             self.platforms = []
         })
    
   

        
        
        
        

        cell.delegate = self
        
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    
}

extension HomeViewController: HomeCellDelegate {
    func headinigButtonPressed(cell: HomeCell) {
        let vc = CategoryDetailViewController()
        vc.titleText = cell.headingButton.currentTitle
        vc.imgUrls = cell.imgUrls
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}
