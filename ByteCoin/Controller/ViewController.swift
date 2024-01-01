import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,CoinDelegate {
   
    
    var coinManager = CoinManager()
    @IBOutlet weak var bitCoinLabel: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: "Bitcoin")
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        image.layer.borderWidth=1.0
         image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
         image.layer.cornerRadius = image.frame.size.height/2
         image.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? coinManager.cryptoArray.count : coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        component == 0 ? coinManager.cryptoArray[row] : coinManager.currencyArray[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = coinManager.currencyArray[pickerView.selectedRow(inComponent: 1)]
        let crypto = coinManager.cryptoArray[pickerView.selectedRow(inComponent: 0)]
        let cryptocurreny = coinManager.cryptocurrencies[crypto]
//        print(crypto)
//        print(country)
        coinManager.getCoinPrice(for: country, crypto: cryptocurreny!)
        currencyLabel.text = country
        image.image = UIImage(named: crypto)
        
    }
    func getRate(_ rate: String) {
        DispatchQueue.main.async {
            [unowned self] in
            self.bitCoinLabel.text = rate
        }
        
        
    }

}

