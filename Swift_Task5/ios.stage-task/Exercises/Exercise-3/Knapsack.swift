import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        let foodMatrix = getMatrix(maxWeight, foods.count, foods)
        let drinkMatrix = getMatrix(maxWeight, drinks.count, drinks)
        
        var maximumDistance = 0
        for i in 0...maxWeight {
            let currentFoodVariation = foodMatrix[foods.count][i]
            let currentDrinkVariation = drinkMatrix[drinks.count][maxWeight-i]
            
            if min(currentFoodVariation, currentDrinkVariation) > maximumDistance {
                maximumDistance = min(currentFoodVariation, currentDrinkVariation)
            }
        }
        
        return maximumDistance
    }


    func getMatrix (_ maxWeight: Int, _ numberOfElements: Int, _ array: [Supply]) -> [[Int]] {
        var profits = [0]
        var weights = [0]
        for i in 0..<array.count {
            profits.append(array[i].value)
            weights.append(array[i].weight)
        }
        
        var matrix = Array(repeating: Array(repeating: 0, count: maxWeight + 1), count: profits.count)
        
        for i in 0...numberOfElements {
            for w in 0...maxWeight {
                if i == 0 || w == 0 {
                    matrix[i][w] = 0
                } else if weights[i] <= w {
                    matrix[i][w] = max((profits[i] + matrix[i-1][w-weights[i]]), matrix[i-1][w])
                } else {
                    matrix[i][w] = matrix[i-1][w]
                }
            }
        }
        
        return matrix
    }
}
