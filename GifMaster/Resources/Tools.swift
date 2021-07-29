//
//  GameTools.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/6/30.
//

import UIKit

struct Tools {



    public static func setUpBackButton() -> UIButton{
        let backButton: UIButton = {
            let floatingButton = UIButton()
            floatingButton.setTitle("返回", for: .normal)
            floatingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            floatingButton.backgroundColor = .systemPink
            floatingButton.layer.cornerRadius = 20
            floatingButton.addShadow()
            floatingButton.translatesAutoresizingMaskIntoConstraints = false
            floatingButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            floatingButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            return floatingButton
        }()
        
        return backButton
    }
    
    public static func setUpTableView() -> UITableView {
        let tableView: UITableView = {
            let tv = UITableView()
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.separatorStyle = .none
            tv.isScrollEnabled = true
            tv.showsVerticalScrollIndicator = false

            return tv
        }()
        return tableView
    }
    
    
    public static func setUpCollectionView(_ lineSpacing: Int, _ interItemSpacing: Int, _ direction: UICollectionView.ScrollDirection) -> UICollectionView {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        layout.minimumLineSpacing = CGFloat(lineSpacing)
        layout.minimumInteritemSpacing = CGFloat(interItemSpacing)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }
    public static func LoadImage(_ imgUrlString: String) -> UIImage{
        let imgUrl = URL(string: imgUrlString)
        
        let data = try? Data(contentsOf: imgUrl!)
        return UIImage(data: data!)!
    }
    
    public static func setUpProfileButton(_ btnTitle: String) -> UIButton {
        let button: UIButton = {
            let btn = UIButton()
            btn.layer.cornerRadius = 10
            btn.backgroundColor = K.brandGreen
            btn.setTitle(btnTitle, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .black)
            btn.widthAnchor.constraint(equalToConstant: (K.screenWidth - 96) / 3).isActive = true
            return btn
        }()
        
        return button
    }
    
    public static func setUpButton(_ btnTitle: String, _ color: UIColor, _ fontSize: Int) -> UIButton {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = color
        btn.setTitle(btnTitle, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: CGFloat(fontSize), weight: .bold)
        return btn
    }
    
    public static func setHeight( _ sender: UIView, _ height: Int){
        sender.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }
    

    
    public static func setUpLabel(_ text: String, _ fontSize: Int, _ weight: UIFont.Weight, _ color: UIColor) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.font = .systemFont(ofSize: CGFloat(fontSize), weight: weight)
        lbl.textColor = color
        return lbl
    }
    
    public static func setUpTextField(_ placeHolderText: String, _ borderWidth: Float, _ boderColor: UIColor, _ cornerRadius: Float) -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = placeHolderText
        tf.borderStyle = .none
        tf.layer.borderWidth = CGFloat(borderWidth)
        tf.layer.borderColor = boderColor.cgColor
        tf.layer.cornerRadius = CGFloat(cornerRadius)
        return tf
    }
    


    
}

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 0.5)
        self.layer.shadowOpacity = 0.9
        self.layer.shadowRadius = 1.0
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    

}

enum LinePosition {
    case top
    case bottom
}

extension UIView {
    func addLine(position: LinePosition, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .top:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .bottom:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}

extension UserDefaults {
    func imageArray(forKey key: String) -> [UIImage]? {
        guard let array = self.array(forKey: key) as? [Data] else {
            return nil
        }
        return array.compactMap() { UIImage(data: $0) }
    }

    func set(_ imageArray: [UIImage], forKey key: String) {
        self.set(imageArray.compactMap({ $0.pngData() }), forKey: key)
    }
}

extension CGImage {
    var isDark: Bool {
        get {
            guard let imageData = self.dataProvider?.data else { return false }
            guard let ptr = CFDataGetBytePtr(imageData) else { return false }
            let length = CFDataGetLength(imageData)
            let threshold = Int(Double(self.width * self.height) * 0.45)
            var darkPixels = 0
            for i in stride(from: 0, to: length, by: 4) {
                let r = ptr[i]
                let g = ptr[i + 1]
                let b = ptr[i + 2]
                let luminance = (0.299 * Double(r) + 0.587 * Double(g) + 0.114 * Double(b))
                if luminance < 150 {
                    darkPixels += 1
                    if darkPixels > threshold {
                        return true
                    }
                }
            }
            return false
        }
    }
}

extension UIImage {
    var isDark: Bool {
        get {
            return self.cgImage?.isDark ?? false
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}



