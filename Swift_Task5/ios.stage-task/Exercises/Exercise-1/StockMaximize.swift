import Foundation

class StockMaximize {
//    [1, 7, 3, 5]
    
    func countProfit(prices: [Int]) -> Int {
        var profit = 0
        var max = 0
        
        if prices.count > 0 {
            for i in 1..<prices.count {
                if prices[i] >= prices[i-1] {
                    for j in i..<prices.count {
                        if prices[j] > prices[i] {
                            max = prices[j]
                        } else {
                            max = prices[i]
                        }
                    }
                    profit += max - prices[i-1]
                }
            }
        }

        return profit
    }
}
