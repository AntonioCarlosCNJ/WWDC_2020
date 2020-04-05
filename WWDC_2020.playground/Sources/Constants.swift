import Foundation


// ----- BACKGROUND LAYER TEXTURES ----- //

public let BOARD_DESK_TX = "background/board_desk"
public let SHELF_TX = "background/shelf"
public let MOUTH_TX = "mouth/mouth"
public let REAGENT_TX = "Main_Reaction/reagent"
public let REAGENT_FULL_TX = "Main_Reaction/reagent_full"
public let DIRECT_ARROW_TX = "Main_Reaction/direct"
public let REVERSE_ARROW_TX = "Main_Reaction/reverse"
public let PRODUCT_TX = "Main_Reaction/product"
public let PRODUCT_FULL_TX = "Main_Reaction/product_full"
public let PH_TITLE_TX = "chemistry/pH"
public let UP_ARROW_TX = "chemistry/up_arrow"
public let DOWN_ARROW_TX = "chemistry/down_arrow"

// ----- BACKGROUND LAYER SPRITE NAMES ----- //

public let BOARD_DESK_NAME = "boardDesk"
public let SHELF_1_NAME = "shelf1"
public let SHELF_2_NAME = "shelf2"
public let SHELF_3_NAME = "shelf3"
public let REAGENT_NAME = "reagent"
public let REAGENT_FULL_NAME = "reagentFull"
public let REVERSE_ARROW_NAME = "reverseArrow"
public let DIRECT_ARROW_NAME = "directArrow"
public let PRODUCT_NAME = "product"
public let PRODUCT_FULL_NAME = "productFull"
public let PH_TITLE_NAME = "pHTitleNode"
public let UP_ARROW_NAME = "upArrow"
public let DOWN_ARROW_NAME = "downArrow"

// ----- BACKGROUND LAYER FONT NAMES ----- //

public let PH_LABEL_FONT = "Hey October"

// ----- BACKGROUND LAYER FONT SIZES ----- //

public let PH_LABEL_FONT_SIZE: CGFloat = 26


public enum zPositionOfElements: CGFloat {
    public typealias RawValue = CGFloat
    
    case backgroundColor = 0
    case boardDesk = 1
    case mouth = 2
    case chemicalReaction = 3
    case item = 4
    
}

/** maxReproductionSpeed: more highest more slower, so if the reproductionSpeed is equal
    to maxReproductionSpeed the reproduction of bacteria is very slow*/

/** minReproductionSpeed: inverse of maxReproductionSpeed*/

public let MAX_REPRODUCTION_SPEED: Double = 4.5
public let MIN_REPRODUCTION_SPEED: Double = 0.5

public let MAX_ACIDITY_LEVEL: Double = 7.2
public let MIN_ACIDITY_LEVEL: Double = 4.5
public let MIN_GOOD_ACIDITY_LEVEL: Double = 6.8

public let MAX_BACTERIA_AMOUNT: Int = 1600
public let MAX_BACTERIA_AMOUNT_PER_TOOTH: Int = 100

public let ACID_LEVEL_PER_BACTERIUM: Double = (MAX_ACIDITY_LEVEL - MIN_ACIDITY_LEVEL) / Double(MAX_BACTERIA_AMOUNT)
public let BACTERIA_AMOUNT_MIN_GOOD_ACIDITY_LEVEL: Int = Int((MIN_GOOD_ACIDITY_LEVEL - MIN_ACIDITY_LEVEL) / ACID_LEVEL_PER_BACTERIUM) - 160

public let REPRODUCTION_ACTION_KEY: String = "reproduceActionKey"

public let MAX_ALPHA_REAGENT: CGFloat = 0.8
public let MAX_ALPHA_PRODUCT: CGFloat = 1.0

public let PRODUCT_ALPHA_PER_BACTERIUM: CGFloat = MAX_ALPHA_PRODUCT / CGFloat(BACTERIA_AMOUNT_MIN_GOOD_ACIDITY_LEVEL)
public let REAGENT_ALPHA_PER_BACTERIUM: CGFloat = MAX_ALPHA_REAGENT / CGFloat(BACTERIA_AMOUNT_MIN_GOOD_ACIDITY_LEVEL)




