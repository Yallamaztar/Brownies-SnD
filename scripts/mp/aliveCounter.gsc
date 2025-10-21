// https://github.com/2-Millimeter-Nahkampfwachter/SnDAliveCounter/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
	level thread sndAliveCount();
}

sndAliveCount() {
	level createTeams();
	for(i = 0; i < level.teamNames.size; i++) {
		team = level.teamNames[i];
		level thread monitorTeam(team);
	}
}

monitorTeam(team) {
	oldalive = 0;
	oldcount = 0;
	for(;;) {
		wait 0.05;
		alive = 0;
		count = 0;
		players = level.players;
		for(i = 0; i < players.size; i++){
			player = players[i];
			if(player.team == team){
				count++;
				if(isAlive(player)){
					alive++;
				}
			}
		}
		if(count != oldcount || alive != oldalive ){
			level remakeTeamHud(team, alive, count);
			oldalive = alive;
			oldcount = count;
		}
	}
}

createTeams(){
	if(!isdefined(level.sndAliveCounterTeams)){
		level.sndAliveCounterTeams = [];
		level.teamNames = array();
	}
	_a71 = level.teams;
	_k71 = getFirstArrayKey( _a71 );
	i = 0;
	while ( isDefined( _k71 ) )
	{
		team = _a71[ _k71 ];
		print(team);
		if(!isDefined(level.sndAliveCounterTeams[team])){
			level.teamNames[level.teamNames.size] = team;
			level.sndAliveCounterTeams[team] = spawnStruct();
			level.sndAliveCounterTeams[team].x = -400;
			level.sndAliveCounterTeams[team].y = 90 + (i * 15);
			level.sndAliveCounterTeams[team].dotsX = -355;
			level.sndAliveCounterTeams[team].dotsY = 95 + (i * 15);
			level.sndAliveCounterTeams[team].iconname = game[ "headicon_" + team ];
			preCacheShader(level.sndAliveCounterTeams[team].iconname);
			level.sndAliveCounterTeams[team].iconX = -370;
			level.sndAliveCounterTeams[team].color = getColorByTeam(team);
		}
		_k71 = getNextArrayKey( _a71, _k71 );
		i++;
	}
}

getColorByTeam(team){
	color = (0, 0, 0);
	switch(game[ team ]){
		case "seals":
			color = (0, 0.58, 1);
		break;
		case "pmc":
			color = (1, 0.85, 0.05);
		break;
		case "pla":
			color = (0.53, 0.03, 0.03);
		break;
		case "fbi":
			color = (0.25, 0.87, 0.81);
		break;
		case "isa":
			color = (0, 0.63, 0.42);
		break;
		case "cd":
			color = (0.98, 0.92, 0.36);
		break;
	}
	return color;
}

remakeTeamHud(team, alive, count){
	x = level.sndAliveCounterTeams[team].x;
	y = level.sndAliveCounterTeams[team].y;
	if(!isDefined(level.sndAliveCounterTeams[team].hud)){
		level.sndAliveCounterTeams[team].hud = createserverfontstring( "default", 1.4 );
		level.sndAliveCounterTeams[team].hud.x = x;
		level.sndAliveCounterTeams[team].hud.y = y;
		level.sndAliveCounterTeams[team].hud.hidewheninkillcam = 1;
		level.sndAliveCounterTeams[team].hud.hidewheninmenu = 1;
		//level.sndAliveCounterTeams[team].hud.hidewhendead = 1;
		level.sndAliveCounterTeams[team].hud.label = &"Alive: ";
		level.sndAliveCounterTeams[team].hud setValue(alive);
		level.sndAliveCounterTeams[team].dots = array();
		level.sndAliveCounterTeams[team].icon = drawshader(level.sndAliveCounterTeams[team].iconname, level.sndAliveCounterTeams[team].iconX, y - 1, 18, 18, (1, 1, 1), 1);
	}
	level.sndAliveCounterTeams[team].hud setValue(alive);
	array_thread(level.sndAliveCounterTeams[team].dots, ::CustomDestroy);
	
	level.sndAliveCounterTeams[team].dots = array();
	color = level.sndAliveCounterTeams[team].color;
	dotsx = level.sndAliveCounterTeams[team].dotsX;
	dotsy = level.sndAliveCounterTeams[team].dotsY;
	for(i = 0; i < count; i++){
		if(i <= (alive - 1)){
			level.sndAliveCounterTeams[team].dots[level.sndAliveCounterTeams[team].dots.size] = drawshader("white", (dotsx + (level.sndAliveCounterTeams[team].dots.size * 10)), dotsy, 5, 7, color, 1);
		} else {
			level.sndAliveCounterTeams[team].dots[level.sndAliveCounterTeams[team].dots.size] = drawshader("white", (dotsx + (level.sndAliveCounterTeams[team].dots.size * 10)), dotsy, 5, 7, (0.41, 0.41, 0.41), 1);
		}
	}
}

drawshader( shader, x, y, width, height, color, alpha )
{
	hud = newhudelem();
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.children = [];
	hud.hidewheninmenu = 1;
	//hud.hidewhendead = 1;
	hud.hidewheninkillcam = 1;
	hud setparent( level.uiparent );
	hud setshader( shader, width, height );
	hud.x = x;
	hud.y = y;
	return hud;
}

CustomDestroy(){
	self destroy();
}