extends Node
class_name PathData

const PATH_GAME = "/root/Game"
const PATH_PLAYER = PATH_GAME + "/Player"
const PATH_GUI = "/root/Game/GUI/Canvas"

const PATH_GAME_SCREEN_PAUSE = PATH_GUI + "/GameScreenPause"
const PATH_LIVES_COUNTER = PATH_GUI + "/Counters/LivesCounter"
const PATH_LIVES_COUNTER_VALUE = PATH_LIVES_COUNTER + "/Background/Value"

const PATH_RMS_COUNTER = PATH_GUI + "/Counters/RMCounter"
const PATH_RMS_COUNTER_VALUE = PATH_RMS_COUNTER + "/Background/Value"

const PATH_TIMEOUT = PATH_GUI + "/Counters/Timeout"
const PATH_TIME_LEVEL_VALUE = PATH_TIMEOUT + "/Background/Value"

const PATH_SPEED_BAR = PATH_GUI + "/HBoxContainer/Bars/SpeedBar"
const PATH_POWER_BAR = PATH_GUI + "/HBoxContainer/Bars/PowerBar"
const PATH_GUI_TIME = PATH_GUI + "/HBoxContainer/Time"

const PATH_SPEED_BAR_COUNT_VALUE = PATH_SPEED_BAR + "/Count/Background/Value"
const PATH_POWER_BAR_COUNT_VALUE = PATH_POWER_BAR + "/Count/Background/Value"

const PATH_JUMP_BTN = PATH_GUI + "/ControlContainer/JumpBtn"
const PATH_GO_BTN = PATH_GUI + "/ControlContainer/GoBtn"
const PATH_STOP_BTN = PATH_GUI + "/ControlContainer/StopBtn"

const END_GAME_SCREEN = "res://Game/GameScreen/EndGameScreen.tscn"
const BIKE_MENU_SCREEN = "res://BikeMenu/BikeMenu.tscn"

# scripts
const PATH_DIE_PLAYER = "res://Game/scripts/DiePlayer.gd"
const PATH_PLAYER_STOMP_DETECTER = "res://Game/scripts/PlayerStompDetecter.gd"
const PATH_ANIMATE_PEOPLE = "res://Game/Character/People/scripts/AnimatePeople.gd"
