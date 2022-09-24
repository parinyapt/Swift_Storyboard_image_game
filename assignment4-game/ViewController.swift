//
//  ViewController.swift
//  assignment4-game
//
//  Created by Parinya Termkasipanich on 24/9/2565 BE.
//

import UIKit

class ViewController: UIViewController {
    
    var randomValue:Int = 10
    var randomImageArray:[Int] = []
    var randomCount:Int = 0
    
    var randomLogArray:[Int] = []
    
    var mostResultCount:[Int:Int] = [:]
    var mostResultArray:[Int] = []
    var maxMostResult:Int = 0

    @IBOutlet weak var ImageView: UICollectionView!
    @IBOutlet weak var MostImageView: UICollectionView!
    @IBOutlet weak var randomVSliderValue: UISlider!
    @IBOutlet weak var randomBtnLabel: UIButton!
    @IBOutlet weak var mostResultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ImageView.dataSource = self
        ImageView.delegate = self
        ImageView.collectionViewLayout = UICollectionViewFlowLayout()
        
        MostImageView.dataSource = self
        MostImageView.delegate = self
        MostImageView.collectionViewLayout = UICollectionViewFlowLayout()
        
        setRandomSlider()
        setRandomBtnText()
    }

    @IBAction func randomBtn(_ sender: Any) {
        randomCount += 1
        randomImage(count:randomValue)
        randomLogArray.append(contentsOf: randomImageArray)
        setMostImage()
        
        ImageView.reloadData()
    }
    
    @IBAction func randomValueSlider(_ sender: Any) {
        let sliderValue:UISlider = sender as! UISlider
        randomValue = Int(sliderValue.value)
        setRandomBtnText()
    }
    
    @IBAction func resetBtn(_ sender: Any) {
        randomImageArray.removeAll()
        randomCount = 0
        randomLogArray.removeAll()
        mostResultCount.removeAll()
        mostResultArray.removeAll()
        maxMostResult = 0
        
        ImageView.reloadData()
        MostImageView.reloadData()
        
        mostResultLabel.text = ""
        
    }
    
    func setRandomBtnText() {
        randomBtnLabel.setTitle("Random \(String(randomValue)) Image", for: .normal)
    }
    
    func setRandomSlider() {
        randomVSliderValue.value = Float(randomValue)
    }
    
    func randomImage(count:Int) {
        randomImageArray.removeAll()
        
        for _ in 1...count {
            randomImageArray.append(Int.random(in: 0..<imageConfig.count))
        }
    }
    
    func setMostImage() {
        calculateMostResult()
        mostResultLabel.text = "The most found image in \(randomLogArray.count) image of \(randomCount) time randomly."
        
        MostImageView.reloadData()
    }
    
    func calculateMostResult() {
        for i in randomLogArray {
            mostResultCount[i] = (mostResultCount[i] ?? 0 ) + 1
        }
        maxMostResult = 0
        for (key,value) in mostResultCount {
            if value > maxMostResult {
                maxMostResult = value
                mostResultArray.removeAll()
                mostResultArray.append(key)
            }else if value == maxMostResult {
                mostResultArray.append(key)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.MostImageView {
            return mostResultArray.count
        }
        
        return randomImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.MostImageView {
            let cell = MostImageView.dequeueReusableCell(withReuseIdentifier: "MostImageCell_ID", for: indexPath) as! MostImageCell
//            cell.config(imgName: imageConfig[mostResultArray[indexPath.item]])
            cell.config(imgName: imageConfig[indexPath.item])
            
            return cell
        } else {
            let cell = ImageView.dequeueReusableCell(withReuseIdentifier: "ImageCell_ID", for: indexPath) as! ImageCell
            cell.config(imgName: imageConfig[randomImageArray[indexPath.item]])
            
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width:CGFloat
        var height:CGFloat
        
        if collectionView == self.MostImageView {
            width = (collectionView.frame.size.width - 2) / CGFloat(mostResultArray.count + 1)
            height = (collectionView.frame.size.height)
        }else{
            width = (collectionView.frame.size.width - 2) / 4
            height = (collectionView.frame.size.height) / 5
        }
        
        return CGSize(width: width, height: height)
    }
}
