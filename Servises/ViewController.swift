import UIKit
import Kingfisher
import SafariServices

protocol ViewControllerProtocol: AnyObject {
    func reloadData()
}

final class ViewController: UIViewController {
    
    private lazy var servisesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        var servisesCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        servisesCollection.register(ServisesCollectionViewCell.self, forCellWithReuseIdentifier: "ServisesCell")
        servisesCollection.isScrollEnabled = true
        servisesCollection.backgroundColor = .clear
        return servisesCollection
    }()
    
    private lazy var servisesLabel: UILabel = {
        var servisesLabel = UILabel()
        servisesLabel.text = "Сервисы"
        servisesLabel.textColor = .white
        
        return servisesLabel
    }()
    
    private let presenter: ViewControllerPresenterProtocol
    
    init(presenter: ViewControllerPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewController(viewController: self)
        servisesCollection.delegate = self
        servisesCollection.dataSource = self
        configureConstraints()
    }
    
    func configureConstraints() {
        [servisesLabel, servisesCollection].forEach() {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            servisesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            servisesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            servisesCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            servisesCollection.topAnchor.constraint(equalTo: servisesLabel.bottomAnchor, constant: 20),
            servisesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            servisesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            servisesCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }


}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 80)
    }
}

extension ViewController: UICollectionViewDelegate {

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getServicesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = servisesCollection.dequeueReusableCell(withReuseIdentifier: "ServisesCell", for: indexPath) as? ServisesCollectionViewCell else { return ServisesCollectionViewCell() }
        let services = presenter.getServices()
        let service = services[indexPath.row]
        let url = URL(string: service.iconURL)
        cell.icon.kf.setImage(with: url)
        cell.nameLabel.text = service.name
        cell.descriptionLabel.text = service.description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let services = presenter.getServices()
        guard let url = URL(string: services[indexPath.row].link) else { return }
        let safariView = SFSafariViewController(url: url)
        self.present(safariView, animated: true)
    }
    
    
}

extension ViewController: ViewControllerProtocol {
    func reloadData() {
        servisesCollection.reloadData()
    }
}

