//
//  ChoseCityView.swift
//  Muslink
//
//  Created by Arystan on 05.08.2023.
//

import Foundation
import UIKit

final class ChooseCityView: UIViewController {
    //MARK: - Properties
    
    private var item: SearchItem?
    private let viewModel: ArtistRegistrationViewModel
    private let window: UIWindow
    
    //MARK: - Lifecycle
    
    init(viewModel: ArtistRegistrationViewModel, window: UIWindow) {
        self.viewModel = viewModel
        self.window = window
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getCities { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let cities):
                self.page.data = cities
            case .failure(_):
                print("NetworkingError")
                self.page.data = [City(id: 12, name: "ads")]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        setupUI()
        setupNavigationBar()
        continueButton.isEnabled = false
    }
    
    var chosenCityIndex: IndexPath?
    let page = SearchTableView(title: "Город")
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Откуда вы"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = Color.neutral100.color
        label.backgroundColor = Color.primaryBgColor.color
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var cityLabel = createLabel(text: "Город", fontSize: 14, color: Color.neutral32.color)
    private lazy var choseLabel = createLabel(text: "Выберите город", fontSize: 16, color: Color.neutral80.color)
    private let continueButton = DefaultButton(buttonType: .primary)
    
    private let chevronIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.chevronDown.image
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return imageView
    }()
    
    private let progressView: DefaultProgressBar = {
        let progressView = DefaultProgressBar()
        progressView.updateProgress(withScreenOrder: 1)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
   
    private lazy var cityButton: UIControl = {
        let button = UIControl()
        button.addSubview(choseLabel)
        button.addSubview(chevronIcon)
        button.backgroundColor = Color.neutral32.color
        button.layer.cornerRadius = 10
        
        choseLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronIcon.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            choseLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 12),
            choseLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            chevronIcon.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            chevronIcon.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return button
    }()
    
    func setupNavigationBar() {
        let title = UILabel()
        title.text = "Профиль музыканта"
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: self, action: #selector(moveBack))
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
        continueButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func moveBack() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc
    private func nextButtonPressed() {
        guard let item = item as? City else {
            return
        }
        viewModel.userDidEnterCity(city: item )
        navigationController?.pushViewController(ChooseSocialNetworksViewContoller(viewModel: viewModel, window: window), animated: false)
    }
    
    private func createLabel(text: String, fontSize: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = UIFont(name: "YSText-Bold", size: fontSize)
        
        return label
    }
    
    private func updateChoseLabel(city: String) {
        choseLabel.text = city
    }
    
    private func setupUI() {
        cityButton.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)

        view.addSubview(progressView)
        view.addSubview(titleLabel)
        view.addSubview(cityLabel)
        view.addSubview(cityButton)
        view.addSubview(continueButton)
        
        continueButton.setTitle(title: "Продолжить")
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityButton.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: progressView.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            cityButton.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            cityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cityButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func radioButtonTapped() {
        page.delegate = self
        page.updateChosenItem(index: chosenCityIndex ?? nil, item: choseLabel.text)
        page.searchController.searchBar.text = nil
        let tt = UINavigationController(rootViewController: page)
        self.present(tt, animated: true)
    }
}

extension ChooseCityView: ChosenItemDelegate {
    func chosenItem(index: IndexPath?, item: SearchItem?) {
        self.item = item
        updateChoseLabel(city: item!.title)
        continueButton.isEnabled = true
        chosenCityIndex = index
    }
}
