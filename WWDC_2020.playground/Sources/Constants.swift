import Foundation


// ----- BACKGROUND LAYER TEXTURES ----- //

public let BOARD_DESK_TX = "background/board_desk"
public let SHELF_TX = "background/shelf"
public let MOUTH_TX = "mouth/mouth"
public let REAGENT_TX = "Main_Reaction/reagent"
public let REAGENT_FULL_TX = "Main_Reaction/reagent_full"
public let DIRECT_ARROW_TX = "Main_Reaction/direct"
public let DIRECT_ACTIVE_ARROW_TX = "Main_Reaction/direct_active"
public let REVERSE_ARROW_TX = "Main_Reaction/reverse"
public let REVERSE_ACTIVE_ARROW_TX = "Main_Reaction/reverse_active"
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

// ----- BACKGROUND LAYER ZPOSITION ----- //

public enum zPositionBackgroundLayer: CGFloat {
    public typealias RawValue = CGFloat
    case mouth = 0
    case chemical = -1
    case background = -2
}

// ----- GAME LAYER CONSTANTS ----- //

/** maxReproductionSpeed: more highest more slower, so if the reproductionSpeed is equal
    to maxReproductionSpeed the reproduction of bacteria is very slow*/

/** minReproductionSpeed: inverse of maxReproductionSpeed*/
public let MAX_REPRODUCTION_SPEED: Double = 4.5
public let MIN_REPRODUCTION_SPEED: Double = 0.5

public let MAX_ACIDITY_LEVEL: Double = 7.2
public let MIN_ACIDITY_LEVEL: Double = 4.5
public let MIN_GOOD_ACIDITY_LEVEL: Double = 6.8

public let MAX_BACTERIA_AMOUNT: Int = 2400
public let MAX_BACTERIA_AMOUNT_PER_TOOTH: Int = 150

public let ACID_LEVEL_PER_BACTERIUM: Double = (MAX_ACIDITY_LEVEL - MIN_ACIDITY_LEVEL) / Double(MAX_BACTERIA_AMOUNT)
public let BACTERIA_AMOUNT_MIN_GOOD_ACIDITY_LEVEL: Int = Int((MIN_GOOD_ACIDITY_LEVEL - MIN_ACIDITY_LEVEL) / ACID_LEVEL_PER_BACTERIUM) - 160

public let MAX_ALPHA_REAGENT: CGFloat = 0.7
public let MAX_ALPHA_PRODUCT: CGFloat = 1.0

public let PRODUCT_ALPHA_PER_BACTERIUM: CGFloat = MAX_ALPHA_PRODUCT / CGFloat(BACTERIA_AMOUNT_MIN_GOOD_ACIDITY_LEVEL)
public let REAGENT_ALPHA_PER_BACTERIUM: CGFloat = MAX_ALPHA_REAGENT / CGFloat(BACTERIA_AMOUNT_MIN_GOOD_ACIDITY_LEVEL)

public let DURATION_OF_CHEMICAL_LOG: TimeInterval = MIN_GOOD_ACIDITY_LEVEL / 4.0

// ----- GAME LAYER ACTION KEYS ----- //

public let REPRODUCTION_ACTION_KEY: String = "reproduceActionKey"
public let INCREASE_LOG_ACTION_KEY = "increaseLog"
public let DECREASE_LOG_ACTION_KEY = "descreaseLog"

// ----- GAME LAYER SPRITE NAMES ----- //

public let SUFFIX_DUPLICATE_ITEM_NODE = "Selected"
public let SUFFIX_CLONE_CHEMICAL_LOG_NODE = "Cloned"
public let SODA_SELECTED_NAME = "sodaSelected"
public let SANDWICH_SELECTED_NAME = "sandwichSelected"

// ----- GAME LAYER SOUND EFFECTS ----- //

public let EATING_SOUND_EFFECT = "Sound_Effects/eating_sound"
public let DRINKING_SOUND_EFFECT = "Sound_Effects/drinking_sound.mp4"

// -----






