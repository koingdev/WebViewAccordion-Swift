//
//  ViewController.swift
//  TestWebViewAccordion
//
//  Created by KoingDev on 5/19/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tagCount = 0
    var cellTag = -1
    var arrCellTags: [Int] = []
    var lastCell = AccordionCell()
    var arrHtmlString = [String]()
    
    var webViewHeight: [CGFloat] = [0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrHtmlString = [htmlString0, htmlString1, htmlString2, htmlString3, htmlString4]
        let bgColor = UIColor.init(red: 50/255, green: 54/255, blue: 64/255, alpha: 1)
        view.backgroundColor = bgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = bgColor
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == cellTag {
            return webViewHeight[cellTag]
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccordionCell") as! AccordionCell
        let index = indexPath.row
        cell.webView.delegate = self
        cell.webView.loadHTMLString(arrHtmlString[index], baseURL: nil)
        cell.webView.tag = index
        cell.toggleAccordion.tag = index
        cell.toggleAccordion.setTitle("Accordion \(index)", for: .normal)
        cell.toggleAccordion.addTarget(self, action: #selector(cellOpened), for: .touchUpInside)
        return cell
    }
    
    @objc func cellOpened(_ sender: UIButton) {
        tableView.beginUpdates()
        let previousCellTag = cellTag
        if lastCell.cellExists {
            lastCell.cellExists = false
            lastCell.animate(duration: 0.15, completion: { [unowned self] in
                self.view.layoutIfNeeded()
            })
            if sender.tag == cellTag {
                cellTag = -1
                lastCell = AccordionCell()
            }
        }
        if sender.tag != previousCellTag {
            cellTag = sender.tag
            lastCell = tableView.cellForRow(at: IndexPath(row: cellTag, section: 0)) as! AccordionCell
            lastCell.cellExists = true
            lastCell.animate(duration: 0.15, completion: { [unowned self] in
                self.view.layoutIfNeeded()
            })
        }
        tableView.endUpdates()
    }
    
    let htmlString0 = """
    </html>コンパス(以下、「本サービス」といいます)においては、本サービスの利用者情報の管理責任者である株式会社Rise UP(以下「弊社」といいます。)は、この個人情報保護方針に基づき、個人情報を取扱います。弊社は、個人情報の保護に関する法律(個人情報保護法)、その他個人情報の取扱いについて定められた法令、関係省庁のガイドライン等を遵守した運営を行います。弊社が提供する本サービス以外のサービスにおける個人情報の取扱につきましては、それぞれのウェブサイトの利用規約・プライバシーポリシーなどをご確認くださいますようお願いします。株式会社Rise UP<br/>201x年xx月xx日制定</body></html>
    """
    let htmlString1 = """
    </html>コンパス(以下、「本サービス」といいます)においては、本サービスの利用者情報の管理責任者である株式会社Rise UP(以下「弊社」といいます。)は、この個人情報保護方針に基づき、個人情報を取扱います。弊社は、個人情報の保護に関する法律(個人情報保護法)、その他個人情報の取扱いについて定められた法令、関係省庁のガイドライン等を遵守した運営を行います。弊社が提供する本サービス以外のサービスにおける個人情報の取扱につきましては、それぞれのウェブサイトの利用規約・プライバシーポリシーなどをご確認くださいますようお願いします。株式会社Rise UP<br/>201x年xx月xx日制定 <ul> <li> 初めてコンタクトレンズを装用する時又はレンズの種類を変更する時は、眼科を受診し目の状態を確認し、自分にあったレンズを選んでもらいましょう。 </li> <li> 初めてコンタクトレンズを装用する時又はレンズの種類を変更する時は、眼科を受診し目の状態を確認し、自分にあったレンズを選んでもらいましょう。 </li><li> 初めてコンタクトレンズを装用する時又はレンズの種類を変更する時は、眼科を受診し目の状態を確認し、自分にあったレンズを選んでもらいましょう。 </li></ul></body></html>
    """
    let htmlString2 = """
        </html><body><h1 class = 'title'> 正しく使おう!コンタクトレンズ</h1></body></html>
    """
    let htmlString3 = """
        </html><body><span class = ''>レンズを取扱う前に必ず石鹸で手指を洗いましょう </span></body></html>
    """
    let htmlString4 = """
        </html><body><p>コンタクトレンズは目に直接のせて使用する医療機器です。眼科医に指示されたことや添付文書に書かれているレンズの取扱い方 法やレンズケアの方法に従い使用しましょう。使い方を誤ると角膜潰瘍などの重い眼障害が発生することがあります。</p></body></html>
    """
    
}

extension ViewController: UIWebViewDelegate {

    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.frame.size = webView.scrollView.contentSize
        webViewHeight[webView.tag] = webView.scrollView.contentSize.height
    }

}
