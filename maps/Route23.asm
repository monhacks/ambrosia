Route23_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	endcallback

IndigoPlateauSign:
	jumptext IndigoPlateauSignText

IndigoPlateauSignText:
	text "INDIGO PLATEAU"

	para "The Ultimate Goal"
	line "for Trainers!"

	para "#MON LEAGUE HQ"
	done

Route23_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  8,  5, INDIGO_PLATEAU_POKECENTER_1F, 1
	warp_event  9,  5, INDIGO_PLATEAU_POKECENTER_1F, 2
	warp_event  8, 21, VICTORY_ROAD, 10
	warp_event  9, 21, VICTORY_ROAD, 10

	def_coord_events

	def_bg_events
	bg_event 10,  8, BGEVENT_READ, IndigoPlateauSign

	def_object_events
