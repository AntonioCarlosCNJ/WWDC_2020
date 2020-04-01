import Foundation

public enum zPositionOfElements: CGFloat {
    public typealias RawValue = CGFloat
    
    case backgroundColor = 0
    case boardDesk = 1
    case mouth = 2
    case chemicalReaction = 3
    case arrows = 4
    case item = 5
    
}

/** maxReproductionSpeed: more highest more slower, so if the reproductionSpeed is equal
    to maxReproductionSpeed the reproduction of bacteria is very slow*/

/** minReproductionSpeed: inverse of maxReproductionSpeed*/

public let MAX_REPRODUCTION_SPEED: Double = 4.0
public let MIN_REPRODUCTION_SPEED: Double = 1.0

public let MAX_ACIDITY_LEVEL: Double = 7.2
public let MIN_ACIDITY_LEVEL: Double = 4.5

public let MAX_BACTERIA_AMOUNT: Int = 1600
public let MAX_BACTERIA_AMOUNT_PER_TOOTH: Int = 100

public let DECREASE_ACID_LEVEL_PER_BACTERIUM: Double = (MAX_ACIDITY_LEVEL - MIN_ACIDITY_LEVEL) / Double(MAX_BACTERIA_AMOUNT)

public let REPRODUCTION_ACTION_KEY: String = "reproduceActionKey"
