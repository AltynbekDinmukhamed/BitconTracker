//
//  VewsElements.swift
//  BitconTracker
//
//  Created by Димаш Алтынбек on 03.03.2023.
//

import UIKit

class ViewsElements: UIView {
    //MARK: -Views-
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "ByteCoin"
        label.textColor = UIColor(named: "Title Color")
        label.font = .systemFont(ofSize: 50, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: -Coin part
    let coinView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coinStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let imageLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bitcoinsign.circle.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named: "Title Color")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let numberLable: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usdSignLable: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: -Picker View-
    
    let pick: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.contentMode = .scaleAspectFill
        pickerView.semanticContentAttribute = .unspecified
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    var coinManager = CoinManager()
    
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super .init(frame: frame)
        setUpViews()
        pick.dataSource = self
        pick.delegate = self
        coinManager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -functions-
    private func setUpViews() {
        backgroundColor = UIColor(named: "Background Color")
        addSubview(mainStack)
        mainStack.addArrangedSubview(nameLabel)
        mainStack.addArrangedSubview(coinView)
        coinView.addSubview(coinStack)
        coinStack.addArrangedSubview(imageLogo)
        coinStack.addArrangedSubview(numberLable)
        coinStack.addArrangedSubview(usdSignLable)
        addSubview(pick)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: mainStack.topAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: mainStack.centerXAnchor),
            
            coinView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            coinView.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 20),
            coinView.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -20),
            //coinView.heightAnchor.constraint(equalToConstant: frame.height / 6),
            
            coinStack.topAnchor.constraint(equalTo: coinView.topAnchor),
            coinStack.leadingAnchor.constraint(equalTo: coinView.leadingAnchor),
            coinStack.trailingAnchor.constraint(equalTo: coinView.trailingAnchor),
            
            imageLogo.widthAnchor.constraint(equalToConstant: 80),
            imageLogo.heightAnchor.constraint(equalToConstant: 80),
            
            usdSignLable.trailingAnchor.constraint(equalTo: coinStack.trailingAnchor),
            usdSignLable.leadingAnchor.constraint(equalTo: numberLable.trailingAnchor, constant: 5),
            usdSignLable.widthAnchor.constraint(equalToConstant: 60),
            
            numberLable.leadingAnchor.constraint(equalTo: imageLogo.trailingAnchor),
            numberLable.trailingAnchor.constraint(equalTo: usdSignLable.leadingAnchor, constant: -5),
            
            pick.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            pick.leadingAnchor.constraint(equalTo: leadingAnchor),
            pick.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
    
}

extension ViewsElements: CoinManagerProtocol {
    func didUpdatePrice(price: String, currnecy: String) {
        DispatchQueue.main.async {
            self.numberLable.text = price
            self.usdSignLable.text = currnecy
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension ViewsElements: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}
