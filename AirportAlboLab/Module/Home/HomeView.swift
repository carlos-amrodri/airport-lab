//
//  HomeView.swift
//  AirportAlboLab
//
//  Created by Carlos Rodriguez on 03/02/2022.
//

import UIKit
import SwiftUI

protocol HomeViewProtocol {
    var presenter : HomePresenterProtocol? {get set}
    
    func tapSearchButton()
    
    func setRadiusValue(with value: Float)

}

class HomeView: UIViewController, HomeViewProtocol {
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        addSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.getSliderValue()
    }
    
    //MARK: Protocol
    
    var presenter : HomePresenterProtocol?
    
    @objc func tapSearchButton(){
        presenter?.navigateToMapsView(with: self)
    }
    
    func setRadiusValue(with value: Float){
        self.slider.setValue(value, animated: true)
    }
    
    //MARK: Private
    
    @IBOutlet private weak var mainStack: UIStackView!
    @IBOutlet private weak var sliderLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
 
    @IBAction func sliderAction(_ sender: UISlider) {
        self.sliderLabel.text = "\(Int(sender.value))"
        presenter?.changeRadius(with: sender.value)
    }
    
    
    
    let searchButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        button.backgroundColor = .systemTeal
        button.setTitleColor(.white, for: .normal)
        button.setTitle("SEARCH", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside)
        return button
    }()
    
    private func addSearchButton(){
        mainStack.addArrangedSubview(searchButton)
    }


}
