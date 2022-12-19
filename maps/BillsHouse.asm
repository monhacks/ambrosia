	object_const_def
	const BILLSHOUSE_GRAMPS

BillsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

BillsGrandpa:
	faceplayer
    opentext
    checkevent EVENT_GOT_EVERSTONE_FROM_BILLS_GRANDPA
    iftrue .gotMew
    writetext BillGrampsTakeThisMewText
    yesorno
    iffalse .refused
    writetext BillGrampsImCountingOnYouText
    promptbutton
    waitsfx
    readvar VAR_PARTYCOUNT
    ifequal PARTY_LENGTH, .noRoom
    writetext ReceivedMewText
    playsound SFX_CAUGHT_MON
    waitsfx
    checkflag ENGINE_EARTHBADGE
    iffalse .midLevel
    givepoke MEW, 70
    sjump .given
.midLevel
    givepoke MEW, 50
.given
    setevent EVENT_GOT_EVERSTONE_FROM_BILLS_GRANDPA
    writetext BillGrampsMewExplain
    waitbutton
    closetext
    end
.gotMew
    writetext BillGrampsGotMew
    waitbutton
    closetext
    end
.refused
    writetext BillGrampsTooBad
    waitbutton
    closetext
    end
.noRoom
    writetext BillGrampsNoRoom
    waitbutton
    closetext
    end

BillGrampsTakeThisMewText:
	text "Hm? You know BILL?"
	line "He's my grandson."

	para "I shouldn't tell"
	line "you this..."

	para "Bill has found"
	line "an extremely"
	cont "rare and ancient"
	cont "#MON!"

	para "Apparently He"
	line "found it in a"
	cont "truck at the"
	cont "harbour."

	para "He has entrusted"
	line "it to me..."

	para "Oh my..."

	para "It seems to"
	line "like you."

	para "Hmmm..."

	para "Yes I can see"
	line "why."

	para "You are a"
	line "special trainer."

	para "Would you like"
	line "to take this"
	cont "#MON on"
	cont "your journey?"
	done

BillGrampsImCountingOnYouText:
	text "I know it will"
	line "help you reach"
	cont "your goals!"
	done

BillGrampsMewExplain:
	text "BILL tells me"
	line "this is a very"
	cont "powerful #MON."

	para "It can learn"
	line "any move!"
	done

BillGrampsGotMew:
	text "I know BILL will"
	line "understand that"
	cont "MEW will only"
	cont "reach its full"
	cont "potential with"
	cont "you."
	done

BillGrampsTooBad:
    text "Aw that is"
    line "a real shame."

    para "This #MON"
    line "is powerful"
    cont "and really seems"
    cont "to like you."
    done

BillGrampsNoRoom:
    text "Please make"
    line "room in your"
    cont "party."
    done

ReceivedMewText:
	text "<PLAYER> received"
	line "MEW!"
	done

BillsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_25, 1
	warp_event  3,  7, ROUTE_25, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 2, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BillsGrandpa, -1
