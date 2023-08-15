//
//  ViewController.swift
//  CanvasView in Autolayout
//
//  Created by Tushar Khandaker on 15/8/23.
//

import UIKit

enum canvasRatio: String, CaseIterable {
    case oneOne = "1:1"
    case nineSixteen = "9:16"
    case sixteenNine = "16:9"
    case fourThree = "4:3"
    
    var stringValue: String {
        return self.rawValue
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sixteenNineRatio: NSLayoutConstraint!
    @IBOutlet weak var oneOneRatio: NSLayoutConstraint!
    @IBOutlet weak var nineSixteen: NSLayoutConstraint!
    @IBOutlet weak var fourThreeRatio: NSLayoutConstraint!
    
    var currentRatio = NSLayoutConstraint()
    var isLanscapeImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentRatio = nineSixteen
    }
    
    @IBAction func changeImage(_ sender: UIButton) {
        isLanscapeImage = !isLanscapeImage
        imageView.image = isLanscapeImage ? UIImage(named: "image2") : UIImage(named: "image1")
    }
    
    func changeCanvasSize(by ratio: canvasRatio) {
        
        self.currentRatio.priority = UILayoutPriority(100)
        UIView.animate(withDuration: 0.5) {
            switch ratio {
            case .oneOne:
                self.currentRatio = self.oneOneRatio
            case .nineSixteen:
                self.currentRatio = self.nineSixteen
                
            case .sixteenNine:
                self.currentRatio = self.sixteenNineRatio
                
            default:
                self.currentRatio =  self.fourThreeRatio
            }
            self.currentRatio.priority = UILayoutPriority(1000)
            self.view.layoutIfNeeded()
        }
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        canvasRatio.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCVCell", for: indexPath) as? CustomCVCell else {
            return UICollectionViewCell()
        }
        cell.ratioLabel.text = canvasRatio.allCases[indexPath.item].stringValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCanvas = canvasRatio.allCases[indexPath.item]
        changeCanvasSize(by: selectedCanvas)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: collectionView.bounds.height)
    }
}

//MARK: - CollectionViewCell
class CustomCVCell: UICollectionViewCell {
    
    @IBOutlet weak var ratioLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? .purple : .clear
        }
    }
}
