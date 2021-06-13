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
        var finalFoodBag = [Supply]()
        var finalDrinkBag = [Supply]()
        
        var foodBag = [Supply]()
        var drinkBag = [Supply]()
        
        var foodProfitDWeight = Dictionary<Int, Double>()
        var drinkProfitDWeight = Dictionary<Int, Double>()
        
        for i in 0..<foods.count {
            foodProfitDWeight[i] = Double(foods[i].value/foods[i].weight)
        }
        for i in 0..<drinks.count {
            drinkProfitDWeight[i] = Double(drinks[i].value/drinks[i].weight)
        }
        
        var sortedFoodProfitXWeight = foodProfitDWeight.sorted(by: { $0.1 > $1.1 })
        var sortedDrinkProfitXWeight = drinkProfitDWeight.sorted(by: { $0.1 > $1.1 })
        
        var maximumValue = 0
        for var kg in 0..<maxWeight {
            if let last = sortedFoodProfitXWeight.popLast() {
                if kg+foods[last.key].weight <= maxWeight {
                    foodBag.append((foods[last.key].weight, foods[last.key].value))
                    kg += foods[last.key].weight
                }
            }
            if let last = sortedDrinkProfitXWeight.popLast() {
                if kg+drinks[last.key].weight <= maxWeight {
                    drinkBag.append((drinks[last.key].weight, drinks[last.key].value))
                    kg += drinks[last.key].weight
                }
            }
            if min(allValueInBag(foodBag), allValueInBag(drinkBag)) > maximumValue {
                finalFoodBag = foodBag
                finalDrinkBag = drinkBag
                maximumValue = min(allValueInBag(finalFoodBag), allValueInBag(finalDrinkBag))
            }
        }

        return maximumValue
    }
}

func allWeightInBag(_ bag: [Supply]) -> Int {
    var weight = 0
    for i in 0..<bag.count {
        weight += bag[i].weight
    }
    return weight
}

func allValueInBag(_ bag: [Supply]) -> Int {
    var value = 0
    for i in 0..<bag.count {
        value += bag[i].value
    }
    return value
}
