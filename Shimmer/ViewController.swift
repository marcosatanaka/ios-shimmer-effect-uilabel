import UIKit

class ViewController: UIViewController {

    private lazy var label: ShimmerableUILabel = {
        let label = ShimmerableUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private lazy var label2: ShimmerableUILabel = {
        let label2 = ShimmerableUILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.textAlignment = .center
        label2.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(label2)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32),
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label2.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.showLoading()
        label2.showLoading()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.label.hideLoading()
            self.label2.hideLoading()

            self.label.text = "finished"
            self.label2.text = "loading"
        }
    }

}
