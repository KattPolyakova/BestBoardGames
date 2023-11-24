//
//  FilterVC.swift
//  BestBoardGames
//
//  Created by Kate on 23.11.2023.
//


import UIKit
import SnapKit

class FilterVC: UIViewController {
    
    private let releaseDateLabel = {
        let label = UILabel()
        label.text = "Release date"
        return label
    }()
    
    private let fromLabel = {
     let label = UILabel()
        label.text = "From"
        return label
    }()
    
    private let toLabel = {
     let label = UILabel()
        label.text = "To"
        return label
    }()
    
    private let firstYearTextField = {
        let textField = UITextField()
        textField.placeholder = "  min year"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
    
    private let lastYearTextField = {
        let textField = UITextField()
        textField.placeholder = "  max year"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var applyButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: 0x219653)
        button.setTitle("Apply", for: .normal)
        button.addTarget(self, action: #selector(reloadPage), for: .touchUpInside)
        return button
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let fromStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let toStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.title = "Filters"
        
        view.backgroundColor = UIColor(hex: 0xDEDEDE)
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(fromStackView)
        stackView.addArrangedSubview(toStackView)
        
        fromStackView.addArrangedSubview(fromLabel)
        fromStackView.addArrangedSubview(firstYearTextField)
        
        toStackView.addArrangedSubview(toLabel)
        toStackView.addArrangedSubview(lastYearTextField)
       
        view.addSubview(applyButton)
    }
    
    private func addConstraints() {
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-19)
            make.top.equalToSuperview().offset(73)
        }
        
        fromLabel.snp.makeConstraints { make in
            make.width.equalTo(toLabel.snp.width)
            make.width.equalTo(60)
        }
        
        applyButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-10)
            make.height.equalTo(60)
        }
    }
    
    @objc func reloadPage() {
        print("ok")
    }
}
