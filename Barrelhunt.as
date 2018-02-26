//0 = Unassigned / Lobby
//1 = Spectators
//2 = Survivors
//3 = Zombies

const int UNASSIGNED = 0;
const int TEAM_SPECTATOR = 1;
const int TEAM_HUMAN = 2;
const int TEAM_ZOMBIE = 3;

bool enabled = false;

void PluginInit() {

	PluginData.SetName( "Barrelhunt" );
	PluginData.SetAuthor( "Majorpayne327" );
	PluginData.SetMinimumLifetime( PluginLifetime::HOTRELOADABLE );
	PluginData.SetVersion( "2.0.0" );
	
	Engine.PrecacheFile( model, "models/props_c17/oildrum001.mdl" );
	Events::Player::OnPlayerSpawn.Hook( @OnPlayerSpawn );
}

void MapInit(){
	if(Utils.StrContains("barrelhunt", Globals.CurrentMap())){
		Engine.Log(notice, "[Barrelhunt] --- Enabling Barrelhunt");
		enabled = true;
	}
}

HookReturnCode OnPlayerSpawn(CHL2MP_Player@ pPlayer){
	if(enabled && pPlayer.GetTeamNumber() == TEAM_ZOMBIE ) {
		pPlayer.SetModel( "models/props_c17/oildrum001.mdl" );
	}
		
	return HOOK_CONTINUE;
}

void MapShutdown(){
	if(enabled){
		Engine.Log(notice, "[Barrelhunt] --- Disabling Barrelhunt");
		enabled = false;
	}
}
