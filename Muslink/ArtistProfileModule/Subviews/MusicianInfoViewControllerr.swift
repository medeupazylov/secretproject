//
//  MusicianInfoViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 06.08.2023.
//


import UIKit

final class MusicianInfoViewControllerr: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Об исполнителе"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = Color.neutral100.color
        label.backgroundColor = Color.primaryBgColor.color
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var musicianNameStack = MusicianNameStack()
    
    private let mainStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.spacing = 24
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        
        return view
    }()
    
    
    //    private lazy var socialNetworkStack = SocialNetworksStackView()
    
    private var pageControl: UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = images.count
        pageControl.pageIndicatorTintColor = Color.neutral16.color
        pageControl.currentPageIndicatorTintColor = Color.neutral100.color
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }
    
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
    //    func setupNavigationBar() {
    //        let title = UILabel()
    //        title.text = "Профиль музыканта"
    //        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    //        title.textColor = Color.neutral100.color
    //        navigationItem.titleView = title
    //        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: nil, action: nil)
    //        item.tintColor = Color.neutral72.color
    //        navigationItem.leftBarButtonItem = item
    //    }
    
    
    private var descriptionLabel: UILabel {
        let label = UILabel()
        label.text = "Молодой исполнитель атмосферной, ангельской готроники, одновременно и яркой, и мрачной и жуткой музыки. Тромбон, пронзительная скрипка, виолончель, гитарные саундскейпы и глубокий бас, чарующие многоголосые вокальные наслоения, прихотливые ударные петли — сочетание живых инструментов и безукоризненной электроники создают уникальное звучание и настроение. Одна из самых странных и любопытных европейских околоджазовых групп."
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = Color.neutral72.color
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    private func setup() {
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(collectionView)
        mainStack.setCustomSpacing( 10, after: collectionView)
        mainStack.addArrangedSubview(pageControl)
        mainStack.addArrangedSubview(descriptionLabel)
        
        view.addSubview(mainStack)
//        view.addSubview(musicianNameStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 278),
//            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
//            musicianNameStack.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
//            musicianNameStack.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -30)
        ])
        
    }
    
    //MARK: - CollectionView
    
    private var images: [String] = ["musician", "musician2", "musician3"]
    private let cellIdentifier = "PhotoCarouselCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(PhotoCarouselCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    //MARK: - UICollectionViewDataSource
    
}

extension MusicianInfoViewControllerr:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UICollectionViewDelegate {
    

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PhotoCarouselCell else {
                return UICollectionViewCell()
            }
            cell.imageView.image = UIImage(named: images[indexPath.item])
            pageControl.currentPage = indexPath.row
            return cell
        }
        
        //MARK: - UICollectionViewDelegateFlowLayout
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return collectionView.bounds.size
        }
    
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let width = scrollView.frame.width
            self.pageControl.currentPage = Int(scrollView.contentOffset.x / width)
        }
    
    
    
}
