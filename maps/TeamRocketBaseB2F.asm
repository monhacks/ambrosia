	object_const_def
	const TEAMROCKETBASEB2F_ROCKET1
	const TEAMROCKETBASEB2F_ROCKET_GIRL
	const TEAMROCKETBASEB2F_LANCE
	const TEAMROCKETBASEB2F_DRAGON
	const TEAMROCKETBASEB2F_ELECTRODE1
	const TEAMROCKETBASEB2F_ELECTRODE2
	const TEAMROCKETBASEB2F_ELECTRODE3
	const TEAMROCKETBASEB2F_ELECTRODE4
	const TEAMROCKETBASEB2F_ELECTRODE5
	const TEAMROCKETBASEB2F_ELECTRODE6
	;const TEAMROCKETBASEB2F_ROCKET2
	;const TEAMROCKETBASEB2F_ROCKET3
	const TEAMROCKETBASEB2F_ROCKET4
	const TEAMROCKETBASEB2F_POKE_BALL
	const TEAMROCKETBASEB2F_DAD

TeamRocketBaseB2F_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS
	scene_script .DummyScene2 ; SCENE_TEAMROCKETBASEB2F_ELECTRODES
	scene_script .DummyScene3 ; SCENE_TEAMROCKETBASEB2F_NOTHING

	def_callbacks
	callback MAPCALLBACK_TILES, .TransmitterDoorCallback

.DummyScene0:
	end

.DummyScene1:
	end

.DummyScene2:
	end

.DummyScene3:
	end

.TransmitterDoorCallback:
	checkevent EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER
	iftrue .OpenDoor
	endcallback

.OpenDoor:
	changeblock 14, 12, $07 ; floor
	endcallback

SaveThenContinueLeft:
    opentext
    writetext SaveGame_TRB
    yesorno
    closetext
    iffalse .turnBack
    opentext
    special TryQuickSave
    closetext
    iffalse .turnBack
    applymovement PLAYER, TRB2F_PlayerUp
    sjump RocketBaseBossFLeft
.turnBack
    applymovement PLAYER, Movement_TRB_TurnBack
    end

SaveThenContinueRight:
    opentext
    writetext SaveGame_TRB
    yesorno
    closetext
    iffalse .turnBack
    opentext
    special TryQuickSave
    closetext
    iffalse .turnBack
    applymovement PLAYER, TRB2F_PlayerUp
    sjump RocketBaseBossFRight
.turnBack
    applymovement PLAYER, Movement_TRB_TurnBack
    end

TRB2F_PlayerUp:
    step UP
    step_end

RocketBaseBossFLeft:
	moveobject TEAMROCKETBASEB2F_LANCE, 9, 13
	sjump RocketBaseBossFScript

RocketBaseBossFRight:
	moveobject TEAMROCKETBASEB2F_ROCKET_GIRL, 21, 16
	moveobject TEAMROCKETBASEB2F_ROCKET1, 21, 16
	moveobject TEAMROCKETBASEB2F_DRAGON, 10, 13
	moveobject TEAMROCKETBASEB2F_LANCE, 10, 13
	moveobject TEAMROCKETBASEB2F_DAD, 10, 13
	sjump RocketBaseBossFScript

RocketBaseBossFScript:
	appear TEAMROCKETBASEB2F_ROCKET_GIRL
	appear TEAMROCKETBASEB2F_ROCKET1
	appear TEAMROCKETBASEB2F_DAD
	opentext
	writetext RocketBaseExecutiveFHoldItText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement PLAYER, RocketBasePlayerApproachesBossFMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseGruntApproachesPlayerMovement
	turnobject PLAYER, UP
	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseBossFApproachesPlayerMovement
	opentext
	writetext RocketBaseBossFThrashText
	waitbutton
	closetext
	special FadeOutMusic
	opentext
	writetext DadRescueText
	waitbutton
	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseGruntBacksUpMovement
	turnobject TEAMROCKETBASEB2F_ROCKET1, LEFT
	applymovement TEAMROCKETBASEB2F_DAD, DadApproachesPlayerMovement
	turnobject TEAMROCKETBASEB2F_DAD, DOWN
	turnobject PLAYER, UP
	opentext
	writetext DadExplainText
	waitbutton
	turnobject TEAMROCKETBASEB2F_DAD, RIGHT
	turnobject PLAYER, RIGHT
	writetext RocketsThreatText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseBossBattleMovement
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseBossBattleMovement

	winlosstext RocketBaseBossLoseText, RocketBaseBossInitialWinText
	setlasttalked TEAMROCKETBASEB2F_ROCKET_GIRL
    loadvar VAR_BATTLETYPE, BATTLETYPE_BOSS_BATTLE
	loadtrainer EXECUTIVEF, EXECUTIVEF_1
	startbattle
	setevent EVENT_TEAM_ROCKET_BASE_B2F_EXECUTIVE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_GRUNT_WITH_EXECUTIVE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	setevent EVENT_BEAT_ROCKET_EXECUTIVEF_2
	reloadmap

    special HealParty
    playsound SFX_TACKLE
    applymovement PLAYER, Movement_PlayerLeft
    turnobject PLAYER, RIGHT
    applymovement TEAMROCKETBASEB2F_DAD, Movement_DadDown
    turnobject TEAMROCKETBASEB2F_DAD, RIGHT
	special FadeOutMusic
	opentext
	writetext DadDefeatedText
	waitbutton
	closetext
	opentext
	writetext RocketTauntText
	waitbutton
	closetext

	playmusic MUSIC_DRAGONS_DEN
	opentext
	writetext LanceIntroText
	waitbutton
	closetext
	opentext
	writetext WhoIsThatText
	waitbutton
	closetext
	opentext
	writetext DragoniteAttackText
	waitbutton
	closetext

	cry DRAGONITE
	turnobject TEAMROCKETBASEB2F_ROCKET_GIRL, LEFT
	turnobject PLAYER, LEFT
	appear TEAMROCKETBASEB2F_DRAGON
	applymovement TEAMROCKETBASEB2F_DRAGON, RocketBaseDragoniteAttacksMovement
	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseBossFHitMovement
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseGruntProtectsBossFMovement
	appear TEAMROCKETBASEB2F_LANCE
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesBossFMovement
	turnobject PLAYER, RIGHT
	opentext
	writetext RocketBaseRocketsDefeatedText
	waitbutton
	closetext
	opentext
	writetext RocketBaseLanceTauntText
	waitbutton
	closetext
	turnobject TEAMROCKETBASEB2F_ROCKET_GIRL, LEFT
	opentext
	writetext RocketBaseBossDefeatedText
	waitbutton

	writetext RocketBaseBossRetreatText
	waitbutton
	closetext

	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseGruntRunAwayMovement
	;applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseGirlRunAwayMovement
	opentext
	writetext GetThemText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_DAD, RocketBaseDadRunAwayMovement

	opentext
	writetext YouWontGetAway
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, Movement_RocketBaseGirlBossFight
	cry DRAGONITE
	applymovement TEAMROCKETBASEB2F_DRAGON, Movement_DragoniteDefendsPlayer

    setval CHAMPION
	writemem wOtherTrainerClass
	setval LANCE_DRAGONITE
	writemem wOtherTrainerID
	special OverridePlayerParty
	setval MUSIC_CHAMPION_BATTLE
	writemem wBattleMusicOverride
	winlosstext RocketBaseBossWinText, RocketBaseBossWinText
    loadvar VAR_BATTLETYPE, BATTLETYPE_WEAK_BATTLE
	loadtrainer EXECUTIVEF, EXECUTIVEF_1
	startbattle
	reloadmap

	special LoadPokemonData
	special HealParty
	opentext
	writetext ItsNotOverText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseGirlRunAwayMovement
	disappear TEAMROCKETBASEB2F_ROCKET1
	disappear TEAMROCKETBASEB2F_ROCKET_GIRL
	;disappear TEAMROCKETBASEB2F_ROCKET2
	;disappear TEAMROCKETBASEB2F_ROCKET3
	disappear TEAMROCKETBASEB2F_ROCKET4
	disappear TEAMROCKETBASEB2F_DAD
	special FadeOutMusic
	pause 15
	special FadeInQuickly
	playmusic MUSIC_ROCKET_HIDEOUT
	setscene SCENE_TEAMROCKETBASEB2F_ELECTRODES
	clearevent EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	turnobject TEAMROCKETBASEB2F_LANCE, DOWN
	opentext
	writetext RocketBaseLancePostBattleText
	waitbutton
	closetext
	disappear TEAMROCKETBASEB2F_DRAGON
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceChecksPlayerMovement
	turnobject PLAYER, UP
	opentext
	writetext RocketBaseLancePowerOffText
	waitbutton
	closetext
	follow TEAMROCKETBASEB2F_LANCE, PLAYER
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesMachineMovement
	stopfollow
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLancePacesMovement
	opentext
	writetext RockerBaseLanceElectrodeFaintText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesElectrodesMovement
	disappear TEAMROCKETBASEB2F_LANCE
	applymovement PLAYER, RocketBasePlayerApproachesElectrodesMovement
	end

YouWontGetAway:
    text "I don't care"
    line "who you are!"

    para "You wont get"
    line "away with this!"
    done

RocketBaseGruntBacksUpMovement:
    big_step RIGHT
    big_step RIGHT
    step_end

DadApproachesPlayerMovement:
    big_step RIGHT
    big_step RIGHT
    big_step RIGHT
    big_step RIGHT
    big_step RIGHT
    step_end

RocketBaseGruntRunAwayMovement:
    big_step DOWN
    big_step DOWN
    big_step DOWN
    big_step RIGHT
    big_step RIGHT
    step_end

RocketBaseGirlRunAwayMovement:
    big_step RIGHT
    big_step RIGHT
    big_step DOWN
    big_step DOWN
    big_step RIGHT
    big_step RIGHT
    step_end

RocketBaseDadRunAwayMovement:
    big_step RIGHT
    big_step RIGHT
    big_step RIGHT
    big_step RIGHT
    big_step DOWN
    big_step DOWN
    big_step RIGHT
    step_end

Movement_PlayerLeft:
	fix_facing
	set_sliding
	big_step LEFT
	remove_sliding
	remove_fixed_facing
	step_end

Movement_DadDown:
    big_step DOWN
    step_end

RocketBaseBossBattleMovement:
    step LEFT
    step_end

RocketBaseBossFallbackMovement:
    big_step RIGHT
    big_step RIGHT
    step_end

Movement_RocketBaseGirlBossFight:
    big_step DOWN
    big_step LEFT
    step_end

Movement_DragoniteDefendsPlayer:
    slow_step DOWN
    turn_head RIGHT
    step_end

ItsNotOverText:
    text "UGHHH!"

    para "...."

    para "It's..."

    para "It's not over."

    para "I'll see you"
    line "again."
    done

DadRescueText:
    text "Get away from my"
    line "Kid!"
    done

DadExplainText:
    text "<PLAYER>..."

    para "You have got"
    line "tall."

    para "I'm sorry I had"
    line "to leave."

    para "I wasn't going to"
    line "let the evils of"
    cont "this world come to"
    cont "you."

    para "I'm going to"
    line "protect you."

    para "Now stay back."
    done

RocketsThreatText:
    text "How touching!"

    para "But you are in"
    line "no position to"
    cont "protect anyone."

    para "You both have"
    line "decided to make"
    cont "enemies of us."

    para "And we have"
    line "learnt not to let"
    cont "our enemies live."
    done

DadDefeatedText:
    text "UH..."

    para "I'm sorry <PLAYER>."

    para "I have failed you."

    para "What kind of"
    line "father am I!"

    para "Please let <PLAYER>"
    line "go!"

    para "I beg you..."
    done

RocketTauntText:
    text "There is nothing"
    line "more pathetic than"
    cont "a weak parent"
    cont "groveling for"
    cont "the life of the"
    cont "child they could"
    cont "not protect."

    para "Making an enemy"
    line "of us was the"
    cont "last mistake you"
    cont "two will ever"
    cont "make."
    done

LanceIntroText:
    text "You take great"
    line "pride in your"
    cont "lack of"
    cont "compassion."

    para "I shall crush"
    line "that pride."
    done

WhoIsThatText:
    text "Who is there?"

    para "Come and join"
    line "your friends in"
    cont "their last"
    cont "moments."
    done

DragoniteAttackText:
    text "DRAGONITE!"

    para "ATTACK!"
    done

RocketBaseRocketsDefeatedText:
    text "UHHHHH....."

    para "AGHHH..."

    para "Cough..."
    line "Cough....."
    done

RocketBaseLanceTauntText:
    text "Mark you the"
    cont "folly of pride."

    para "It lies broken"
    line "and helpless."

    para "It reeks now"
    line "of fear."
    done

RocketBaseBossDefeatedText:
    text "The other..."

    para "The other"
    line "intruder..."

    para "Is CHAMPION"
    line "LANCE!"

    para "We can't win this."

    para "We must retreat!"
    done

GetThemText:
    text "They are weakened!"

    para "I wont let them"
    line "get away!"
    done

RocketBaseCantLeaveScript:
	applymovement PLAYER, RocketBasePlayerCantLeaveElectrodesMovement
	end

RocketBaseLancesSideScript:
	opentext
	writetext RocketBaseLancesSideText
	waitbutton
	closetext
	applymovement PLAYER, RocketBasePlayerCantGoRightMovement
	end

LanceHealsScript1:
	turnobject PLAYER, UP
	sjump LanceHealsCommon

LanceHealsScript2:
	turnobject PLAYER, RIGHT
	turnobject TEAMROCKETBASEB2F_LANCE, LEFT
LanceHealsCommon:
	opentext
	writetext LanceHealsText1
	waitbutton
	closetext
	special FadeOutPalettes
	special StubbedTrainerRankings_Healings
	playsound SFX_FULL_HEAL
	special HealParty
	special FadeInPalettes
	opentext
	writetext LanceHealsText2
	waitbutton
	closetext
	setscene SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS
	setevent EVENT_LANCE_HEALED_YOU_IN_TEAM_ROCKET_BASE
	readvar VAR_FACING
	ifequal RIGHT, .FacingRight
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesAfterHealMovement
	disappear TEAMROCKETBASEB2F_LANCE
	end

.FacingRight:
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesAfterHealRightMovement
	disappear TEAMROCKETBASEB2F_LANCE
	end

TrainerGruntM17:
	trainer GRUNTM, GRUNTM_17, EVENT_BEAT_ROCKET_GRUNTM_17, GruntM17SeenText, GruntM17BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM17AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntM18:
	trainer GRUNTM, GRUNTM_18, EVENT_BEAT_ROCKET_GRUNTM_18, GruntM18SeenText, GruntM18BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM18AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntM19:
	trainer GRUNTM, GRUNTM_19, EVENT_BEAT_ROCKET_GRUNTM_19, GruntM19SeenText, GruntM19BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM19AfterBattleText
	waitbutton
	closetext
	end

RocketElectrode1:
	cry ELECTRODE
	loadwildmon ELECTRODE, 40
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE1
	disappear TEAMROCKETBASEB2F_ELECTRODE4
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement1
	sjump RocketBaseElectrodeScript

RocketElectrode2:
	cry ELECTRODE
	loadwildmon ELECTRODE, 40
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE2
	disappear TEAMROCKETBASEB2F_ELECTRODE5
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement2
	sjump RocketBaseElectrodeScript

RocketElectrode3:
	cry ELECTRODE
	loadwildmon ELECTRODE, 40
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE3
	disappear TEAMROCKETBASEB2F_ELECTRODE6
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement3
	sjump RocketBaseElectrodeScript

TeamRocketBaseB2FReloadMap:
	reloadmapafterbattle
	end

RocketBaseElectrodeScript:
	moveobject TEAMROCKETBASEB2F_LANCE, 18, 6
	appear TEAMROCKETBASEB2F_LANCE
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesElectrodesMovement
	turnobject PLAYER, RIGHT
	opentext
	writetext RocketBaseLanceElectrodeDoneText
	promptbutton
	verbosegiveitem HM_WHIRLPOOL
	setevent EVENT_GOT_HM06_WHIRLPOOL
	writetext RocketBaseLanceWhirlpoolText
	waitbutton
	closetext
	turnobject TEAMROCKETBASEB2F_LANCE, DOWN
	opentext
	writetext RocketBaseLanceMonMasterText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesBaseMovement
	disappear TEAMROCKETBASEB2F_LANCE
	setevent EVENT_CLEARED_ROCKET_HIDEOUT
	clearflag ENGINE_ROCKET_SIGNAL_ON_CH20
	setevent EVENT_ROUTE_43_GATE_ROCKETS
	setevent EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_GYM
	setscene SCENE_TEAMROCKETBASEB2F_NOTHING
	clearevent EVENT_LAKE_OF_RAGE_CIVILIANS
	setevent EVENT_TURNED_OFF_SECURITY_CAMERAS
	setevent EVENT_SECURITY_CAMERA_1
	setevent EVENT_SECURITY_CAMERA_2
	setevent EVENT_SECURITY_CAMERA_3
	setevent EVENT_SECURITY_CAMERA_4
	setevent EVENT_SECURITY_CAMERA_5
	end

TeamRocketBaseB2FLockedDoor:
	conditional_event EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER, .Script

.Script:
	opentext
	checkevent EVENT_LEARNED_HAIL_GIOVANNI
	iftrue .KnowsPassword
	writetext RocketBaseDoorNoPasswordText
	waitbutton
	closetext
	end

.KnowsPassword:
	writetext RocketBaseDoorKnowPasswordText
	waitbutton
	playsound SFX_ENTER_DOOR
	changeblock 14, 12, $07 ; floor
	reloadmappart
	closetext
	setevent EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER
	waitsfx
	end

TeamRocketBaseB2FTransmitterScript:
	opentext
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .Deactivated
	writetext RocketBaseB2FTransmitterText
	waitbutton
	closetext
	end

.Deactivated:
	writetext RocketBaseB2FDeactivateTransmitterText
	waitbutton
	closetext
	end

TeamRocketBaseB2FTMThief:
	itemball TM_THUNDER_WAVE

TeamRocketBaseB2FHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_TEAM_ROCKET_BASE_B2F_HIDDEN_FULL_HEAL

RocketBaseLanceLeavesAfterHealMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBaseLanceLeavesAfterHealRightMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBasePlayerApproachesBossFMovement:
	step DOWN
	step DOWN
	step DOWN
	turn_head RIGHT
	step_end

RocketBaseBossFApproachesPlayerMovement:
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	turn_head DOWN
	step_end

RocketBaseGruntApproachesPlayerMovement:
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	step_end

RocketBaseDragoniteAttacksMovement:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	step_end

RocketBaseBossFHitMovement:
	fix_facing
	set_sliding
	jump_step RIGHT
	remove_sliding
	remove_fixed_facing
	step_end

RocketBaseBossFFacesPlayerMovement:
	slow_step DOWN
	turn_head LEFT
	step_end

RocketBaseLanceApproachesBossFMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBaseBossFBattlesPlayerMovement:
	big_step LEFT
	step_end

RocketBaseGruntBattlesLanceMovement:
	big_step LEFT
	step_end

RocketBaseGruntProtectsBossFMovement:
	;big_step LEFT
	big_step UP
	big_step RIGHT
	turn_head LEFT
	step_end

RocketBaseLanceChecksPlayerMovement:
	step RIGHT
	turn_head DOWN
	step_end

RocketBaseLanceApproachesMachineMovement:
	step UP
	step UP
	step UP
	step_end

RocketBaseLancePacesMovement:
	step_sleep 8
	step LEFT
	step LEFT
	turn_head UP
	step_sleep 8
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_sleep 8
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

RocketBaseLanceApproachesElectrodesMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

RocketBasePlayerApproachesElectrodesMovement:
    step UP
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    turn_head UP
    step_end

RocketBasePlayerCantLeaveElectrodesMovement:
	step UP
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

RocketBasePlayerCantGoRightMovement:
	step LEFT
	step_end

RocketBaseLanceLeavesElectrodesMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step_end

RocketBaseLanceLeavesBaseMovement:
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

RocketBasePlayerLeavesElectrodesMovement1:
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBasePlayerLeavesElectrodesMovement2:
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBasePlayerLeavesElectrodesMovement3:
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

SaveGame_TRB:
    text "This could get"
    line "dangerous."

    para "Save your game"
    line "to continue?"
    done

Movement_TRB_TurnBack:
    step DOWN
    turn_head UP
    step_end

RocketBaseExecutiveFHoldItText:
	text "Hold it right"
	line "there!"
	done

RocketBaseBossFThrashText:
	text "We can't have a"
	line "brat like you on"
	cont "the loose."

	para "It's harmful to"
	line "TEAM ROCKET's"
	cont "pride, you see."

	para "However strong you"
	line "may be, you can't"

	para "take both of us at"
	line "the same time."

	para "Sorry, baby. Now"
	line "get ready to be"
	cont "thrashed."
	done

RocketBaseLanceShareFunText:
	text "Hey! Don't be so"
	line "selfish. Spread"
	cont "the fun around."
	done

RocketBaseBossDontMeddleText:
	text "What? You had an"
	line "accomplice?"

	para "Where is your"
	line "sense of honor?"

	para "As the interim"
	line "boss in place of"

	para "GIOVANNI, I'll"
	line "show you how wrong"

	para "it is to meddle"
	line "with TEAM ROCKET!"
	done

RocketBaseBossLoseText:
	text "That is not"
	line "meant to"
	cont "happen!"
	done

RocketBaseBossInitialWinText:
	text "Such a weak"
	line "display on the"
	cont "last battle of"
	cont "your life."
	done

RocketBaseBossWinText:
	text "If LANCE wasn't"
	line "here to save"
	cont "you."

	para "You would be"
	line "dead right now!"

	para "LANCE wont be"
	line "here next time"
	cont "we meet."
	done

RocketBaseBossRetreatText:
	text "…This hideout is"
	line "done for…"

	para "But that's fine."
	line "The broadcast ex-"
	cont "periment was a"
	cont "total success."

	para "It doesn't matter"
	line "what happens to"
	cont "this hideout now."

	para "Your victory"
	line "means nothing."
	done

RocketBaseLancePostBattleText:
	text "I've never seen"
	line "such a thing."

	para "DRAGONITE took"
	line "you as its"
	cont "trainer."

	para "DARGONITE is a"
	line "much better judge"
	cont "of character than"
	cont "I."

	para "If you have"
	line "earned his respect"
	cont "then you have mine"
	cont "also."
	done

RocketBaseLancePowerOffText:
	text "Sorry, <PLAY_G>."
	line "I saw how well you"

	para "were doing, so I"
	line "just hung back."

	para "Now all there is"
	line "left to do is to"

	para "turn off that odd"
	line "radio signal."
	done

RockerBaseLanceElectrodeFaintText:
	text "It's this machine"
	line "that's causing all"
	cont "the problems."

	para "I don't see a"
	line "switch on it…"

	para "We have no choice."
	line "We have to make"

	para "all the ELECTRODE"
	line "faint."

	para "That should stop"
	line "this machine from"

	para "transmitting that"
	line "strange signal."

	para "It's no fault of"
	line "the #MON, so it"

	para "makes me feel"
	line "guilty."

	para "<PLAY_G>, let's"
	line "split the job."
	done

RocketBaseLancesSideText:
	text "LANCE: Leave this"
	line "side to me."
	done

RocketBaseLanceElectrodeDoneText:
	text "LANCE: That odd"
	line "signal has finally"
	cont "stopped."

	para "The LAKE should be"
	line "back to normal."

	para "You're the hero!"
	line "Let me thank you"

	para "on behalf of all"
	line "the #MON."

	para "Oh, yes. You"
	line "should take this."

	para "I found it here,"
	line "but I don't have"
	cont "any need for it."
	done

RocketBaseReceivedHM06Text: ; unreferenced
	text "<PLAYER> received"
	line "HM06."
	done

RocketBaseLanceWhirlpoolText:
	text "That's WHIRLPOOL."
	line "Teach it to a"

	para "#MON to get"
	line "across wild water."

	para "But keep this in"
	line "mind."

	para "You can use that"
	line "out of battle only"

	para "with the BADGE"
	line "from MAHOGANY GYM."
	done

RocketBaseLanceMonMasterText:
	text "<PLAY_G>…"

	para "The journey to be-"
	line "coming the #MON"

	para "MASTER is long and"
	line "difficult."

	para "Knowing that, will"
	line "you keep going?"

	para "…"

	para "I see. No, you're"
	line "right."

	para "If you would give"
	line "up that easily,"

	para "you would have"
	line "never chased that"

	para "dream in the first"
	line "place."

	para "I look forward to"
	line "seeing you again!"
	done

LanceHealsText1:
	text "LANCE: Are you all"
	line "right?"

	para "Your #MON are"
	line "hurt and tired."

	para "Here, give them"
	line "some of my medi-"
	cont "cine."
	done

LanceHealsText2:
	text "LANCE: <PLAY_G>,"
	line "let's give it our"
	cont "best for #MON."
	done

GruntM17SeenText:
	text "The door won't"
	line "open?"

	para "Well, duh."
	line "It has to have a"

	para "password that only"
	line "TEAM ROCKET knows."
	done

GruntM17BeatenText:
	text "What? I lost?"
	done

GruntM17AfterBattleText:
	text "Heh, I'm just a"
	line "GRUNT."

	para "I don't know the"
	line "password. Too bad"
	cont "for you."
	done

GruntM18SeenText:
	text "Oh, a kid? I don't"
	line "really like this,"

	para "but eliminate you"
	line "I must."
	done

GruntM18BeatenText:
	text "I knew I'd lose…"
	done

GruntM18AfterBattleText:
	text "I got wiped out on"
	line "the last mission"
	cont "by a kid too."

	para "When we were ab-"
	line "ducting #MON,"

	para "this kid with long"
	line "red hair and mean-"

	para "looking eyes just"
	line "creamed me…"
	done

GruntM19SeenText:
	text "You rotten little"
	line "pest!"
	done

GruntM19BeatenText:
	text "Grrrr…"
	done

GruntM19AfterBattleText:
	text "Heh, only the boss"
	line "knows the password"
	cont "for that door."

	para "Where's the boss?"
	line "Who knows? Go look"
	cont "for yourself."
	done

RocketBaseDoorNoPasswordText:
	text "The door's closed…"

	para "It needs a pass-"
	line "word to open."
	done

RocketBaseDoorKnowPasswordText:
	text "The door's closed…"

	para "<PLAYER> entered"
	line "the password."

	para "The door opened!"
	done

RocketBaseB2FTransmitterText:
	text "It's the radio"
	line "transmitter that's"

	para "sending the"
	line "sinister signal."

	para "It's working at"
	line "full capacity."
	done

RocketBaseB2FDeactivateTransmitterText:
	text "The radio trans-"
	line "mitter has finally"

	para "stopped its evil"
	line "broadcast."
	done

TeamRocketBaseB2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3, 14, TEAM_ROCKET_BASE_B1F, 2
	warp_event  3,  2, TEAM_ROCKET_BASE_B3F, 1
	warp_event 27,  2, TEAM_ROCKET_BASE_B3F, 2
	warp_event  3,  6, TEAM_ROCKET_BASE_B3F, 3
	warp_event 27, 14, TEAM_ROCKET_BASE_B3F, 4

	def_coord_events
	coord_event  5, 14, SCENE_DEFAULT, LanceHealsScript1
	coord_event  4, 13, SCENE_DEFAULT, LanceHealsScript2
	coord_event 14, 11, SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS, RocketBaseBossFLeft
	coord_event 15, 11, SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS, RocketBaseBossFRight
	coord_event 14, 12, SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS, SaveThenContinueLeft
	coord_event 15, 12, SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS, SaveThenContinueRight
	coord_event 14, 12, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseCantLeaveScript
	coord_event 15, 12, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseCantLeaveScript
	coord_event 12,  3, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseLancesSideScript
	coord_event 12, 10, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseLancesSideScript
	coord_event 12, 11, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseLancesSideScript

	def_bg_events
	bg_event 14, 12, BGEVENT_IFNOTSET, TeamRocketBaseB2FLockedDoor
	bg_event 15, 12, BGEVENT_IFNOTSET, TeamRocketBaseB2FLockedDoor
	bg_event 17,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 16,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 15,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 14,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 13,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  8, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  7, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  6, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  5, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 13,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 14,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 15,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 16,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  5, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  6, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  7, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  8, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 26,  7, BGEVENT_ITEM, TeamRocketBaseB2FHiddenFullHeal

	def_object_events
	object_event 20, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_GRUNT_WITH_EXECUTIVE
	object_event 20, 16, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_EXECUTIVE
	object_event  5, 13, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	object_event  9, 13, SPRITE_DRAGON, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_DRAGONITE
	object_event  7,  5, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode1, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	object_event  7,  7, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode2, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	object_event  7,  9, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode3, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	object_event 22,  5, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	object_event 22,  7, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	object_event 22,  9, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	;object_event 25, 13, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM17, EVENT_TEAM_ROCKET_BASE_POPULATION
	;object_event  4,  1, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 1, TrainerGruntM18, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 21, 14, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, TrainerGruntM19, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  3, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB2FTMThief, EVENT_TEAM_ROCKET_BASE_B2F_TM_THIEF
	object_event  9, 13, SPRITE_SURGE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_EXECUTIVE

