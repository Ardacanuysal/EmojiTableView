//
//  EmojiTableViewController.swift
//  EmojiTableView
//
//  Created by ARDA CAN UYSAL on 17.04.2023.
//

import UIKit
// UITableViewDataSource && UITableViewDelegate
class EmojiTableViewController: UITableViewController {
    
    // MARK: - Properties
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face",
              description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face",
              description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes",
              description: "A smiley face with hearts for eyes.",
              usage: "love of something; attractive"),
        Emoji(symbol: "👮", name: "Police Officer",
              description: "A police officer wearing a blue cap with a gold badge.",
              usage: "person of authority"),
        Emoji(symbol: "🐢", name: "Turtle",
              description: "A cute turtle.",
              usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant",
              description: "A gray elephant.",
              usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti",
              description: "A plate of spaghetti.",
              usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die",
              description: "A single die.",
              usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent",
              description: "A small tent.",
              usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books",
              description: "Three colored books stacked on each other.",
              usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart",
              description: "A red, broken heart.",
              usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore",
              description: "Three blue \'z\'s.",
              usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag",
              description: "A black-and-white checkered flag.",
              usage: "completion")
    ]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 1 section varsa bu fonksiyonu yazmak zorunda değilsiniz.
        // Çünkü: Varsayılan section sayısı zaten 1'dir.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Her section için 1 kez çalışıyor. Örneğin, 4 section'a sahip bir tableView varsa,
        // Bu fonksiyon her section için 1kez olmak üzere toplam 4 kez çalışacaktır.
        // section parametresi, o an çizilmekte olan section bilgisini verir.
        return emojis.count // Elimizdeki emoji sayısı kadar hücre olması...
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Bir hücre, ne zamanki ekrana gelecek; cellForRow ile çizilir.
        // Bu fonksiyonun kaç kez çalışacağı belli değildir.
        // Örnek 1: Kullanıcı hiç scrool etmez ise, ekranda görünebilir olan hücre sayısı kadar çalılır.
        // Örnek 2: Kullanıcı scroll etmeye başlarsa scroll ettiği sürece bu fonksiyon çalışır.
        
        // indexPath: O an çizilmekte olan hücrenin konum bilgisi.
        // Adım 1: O an çizilmekte olan emoji nesnesine indexPath değeri ile ulaşmak.
        let emoji = emojis[indexPath.row]
        
        // Adım 2: Hücre Oluşturmak
        // reuseIdentifier: Storyboard'da hücre için verdiğiniz identifier değeri.
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell")!
        
        // Adım 3: Hücreyi data ile doldurmak.
        cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)" // Title
        cell.detailTextLabel?.text = emoji.description // Subtitle
        
        // Adım 4: Oluşturmuş ve içini doldurmuş olduğunuz hücreyi 'return' edin.
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Bu fonksiyon, kullanıcı bir hücrenizi seçtiği zaman (üstüne tıkladığı zaman) çalışır.
        // indexPath: Üzerine tıklanılan hücrenin konum bilgisi.
        
        // indexPath'in row property'sini kullanarak üzerine tıklanan emoji nesnesine ulaşılabilir.
        let selectedEmoji = emojis[indexPath.row]
        print("\(selectedEmoji.symbol) \(indexPath)")
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // sourceIndexPath: Sırası değiştirilmek istenen hücrenin konumu.
        // destinationIndexPath: Gidilmesi istenilen konum. (Parmak ekran kaldırılınca)
        
        // ÇOK ÖNEMLİ: 'emojis' array'in, tableView hücre sırası ile her zaman aynı kalması gerekir.
        // Bu senkronu sağlayabilmek için hareket ettirilen objenin, array'de de konumu değiştirilir.
        
        // Adım 1: Hareket ettirilen Emoji nesnesine ulaşmak ve array'den silmek.
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        
        // Adım 2: Silinen elemanı, array'de yeni konumuna (gidilecek konuma) yerleştirmek.
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
        
        // Adım 3: TableView'ın yeniden çizilmesini sağlamak.
        // Böylece TableView, güncellenen array sırası ile tüm elemanlarını tekrar çizecek.
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func editButtonTapped(_ button: UIBarButtonItem) {
        // isEditing: O an TableView'ın edit modda olup olmadığı bilgisini verir.
        let tableViewEditingMode = tableView.isEditing
        
        // TableView elemanının editing moda girmesini ve çıkmasını sağlar.
        // '!' Boolean değerinin tersini alır. Örnek: !true = false
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
}
