//
//  SearchViewController.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/20.
//

import UIKit

class SearchViewController: UIViewController {

    let searchTextField = Tools.setUpTextField("Search icons", 2.0, .black, 10)
    let headingLabel = Tools.setUpLabel("Trending", 25, .bold, .black)
    let searchTableView = Tools.setUpTableView()
    
    var searchResult: SearchModel?
    var names: [String] = []
    var platforms: [String] = []
    var namesToPass:[String] = []
    var platformsToPass: [String] = []
    var imageUrls: [String] = []
    var searchTerm: String?
    
    
    func getSearchResults(onCompletion:@escaping () -> ()){
        let urlString = "https://search.icons8.com/api/iconsets/v5/search?term=\(searchTerm ?? "mood")&token=\(K.token)"

        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { [self]data, response, error in
            if error == nil {
                do{
                    self.searchResult = try JSONDecoder().decode(SearchModel.self, from: data!)
                    
                    for doc in (searchResult?.icons)! {
                        names.append(doc.commonName)
                        platforms.append(doc.platform)
                    }
                    namesToPass = names
                    platformsToPass = platforms
    
                    DispatchQueue.main.async {
                        onCompletion()
                    }

                }catch{
                    print(error)
                }
            }
        }).resume()
    }
    @objc func dismissKeyboard() {
        searchTextField.endEditing(true)
    }
        

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Search"
        searchTextField.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.rowHeight = 80

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
                tap.cancelsTouchesInView = false
                view.addGestureRecognizer(tap)
        searchTextField.setLeftPaddingPoints(10)
        searchTableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        searchTextField.clearButtonMode = .always
        
        searchTerm = "icon"
        getSearchResults { [self] in

            self.imageUrls = []
            
            for i in 0..<self.names.count {
               
                let imgUrl = "https://img.icons8.com/" + platforms[i] + "/256/000000/" + names[i] + ".png"
                imageUrls.append(imgUrl)
            }
            self.searchTableView.reloadData()
            self.names = []
            self.platforms = []
        }
        view.addSubview(searchTextField)
        view.addSubview(headingLabel)
        view.addSubview(searchTableView)
        
        
        Tools.setHeight(searchTextField, 40)
        searchTextField.snp.makeConstraints {  make  in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        headingLabel.snp.makeConstraints { make  in
            make.top.equalTo(searchTextField.snp_bottomMargin).offset(16)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        searchTableView.snp.makeConstraints { make  in
            make.top.equalTo(headingLabel.snp_bottomMargin).offset(16)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell

        cell.iconImage.af.setImage(withURL: URL(string: imageUrls[indexPath.row])!)
        cell.name.text = namesToPass[indexPath.row]
        cell.platform.text = platformsToPass[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = IconDetailViewController()
        vc.imgUrl = imageUrls[indexPath.row]
        vc.platform = platformsToPass[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.borderColor = UIColor.black.cgColor
        
        searchTerm = searchTextField.text
        
        headingLabel.text =  searchTerm == "" ?  "Trending"  :  "Results for \(searchTerm!)"
        
        if searchTextField.text == "" {
            searchTerm = "icons"
        }
        
        getSearchResults { [self] in

            self.imageUrls = []
            
            for i in 0..<self.names.count {
               
                let imgUrl = "https://img.icons8.com/" + platforms[i] + "/256/000000/" + names[i] + ".png"
                imageUrls.append(imgUrl)
            }
            self.searchTableView.reloadData()
            self.names = []
            self.platforms = []
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.layer.borderWidth = 3.0
        searchTextField.layer.borderColor = UIColor.orange.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}

