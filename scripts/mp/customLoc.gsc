init() {
	level thread onplayerconnect();
	game["strings"]["match_begins_in"] = "^1@Brownies ^7Starting In...";
	game["strings"]["match_starting_in"] = "^1@Brownies ^7Starting In...";
}

OnPlayerConnect() {
	level endon("game_ended");
	for (;;) {
		level waittill("connected", player);
		player thread customendgame();
	}
}

customendgame() {
	game[ "strings" ][ "draw" ] = "^1@Brownies";
	game[ "strings" ][ "round_draw" ] = "^1@Brownies";
	game[ "strings" ][ "round_win" ] = "^1@Brownies ^0(Win)";
	game[ "strings" ][ "round_loss" ] = "^1@Brownies ^0(Loss)";
	game[ "strings" ][ "victory" ] = "^1@Brownies ^0(Victory)";
	game[ "strings" ][ "defeat" ] = "^1@Brownies ^0(Defeat)";
	game[ "strings" ][ "game_over" ] = "^1@Brownies";
	game[ "strings" ][ "halftime" ] = "^1@Brownies";
	game[ "strings" ][ "overtime" ] = "^1@Brownies";
	game[ "strings" ][ "roundend" ] = "^1@Brownies";
	game[ "strings" ][ "intermission" ] = "^1@Brownies";
	game[ "strings" ][ "side_switch" ] = "^1@Brownies";
	game[ "strings" ][ "tie" ] = "^1@Brownies";
	game[ "strings" ][ "score_limit_reached" ] = "^0FUCK FRENCHIES";
	game[ "strings" ][ "time_limit_reached" ] = "^0FUCK FRENCHIES";
}