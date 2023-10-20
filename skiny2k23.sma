#include <amxmodx>
#include <amxmisc>
#include <fakemeta>
#include <hamsandwich>
#include <fvault>

#define PLUGIN "Menu Skinow"
#define VERSION "3.0lite" 
#define AUTHOR "PANDA"

new nazwa[] = "FragArena.pl";
new const skiny[] = "SKINY";
new const komendy[][] = { "say /skiny", "say /skin", "say /skins", "say /modele", "say /model", "say /models" };
new gracz[33][7], rozmiar_tablicy[6];
enum _: (+= 1){ MODEL_NAME, MODEL_FILE };
enum { noz, deagle, famas, m4a1, ak47, awp };

new const SkinyNoz[][][] = {
	{"Zwykly Noz", 		"models/v_knife.mdl"},
	{"Neon Purple", 	"models/skinypanda/knife/v_knife_neon_purple.mdl"},
	{"Reds Blues", 		"models/skinypanda/knife/v_knife_reds_blues.mdl"},
	{"Rentgen", 		"models/skinypanda/knife/v_5.mdl"},
	{"Fire", 		"models/skinypanda/knife/v_knife_fire.mdl"},
	{"Tatto", 		"models/skinypanda/knife/v_knife_tatto.mdl"},
	{"Grizzly", 		"models/skinypanda/knife/v_knife_grizzly.mdl"}
}

new const SkinyDeagle[][][] = {
	{"Zwykly Deagle", 	"models/v_deagle.mdl"},
	{"Asking Alexandria", 	"models/skinypanda/deagle/v_deagle.mdl"},
	{"Galaxy", 		"models/skinypanda/deagle/v_deagle_galaxy.mdl"},
	{"Rentgen", 		"models/skinypanda/deagle/v_5.mdl"},
	{"Hot Coal", 		"models/skinypanda/deagle/v_deagle_hot_coal.mdl"},
	{"Cyber", 		"models/skinypanda/deagle/v_deagle_cyber.mdl"},
	{"Asiimov", 		"models/skinypanda/deagle/v_deagle_asiimov.mdl"}
}

new const SkinyFamas[][][] = {
	{"Zwykly Famas", 	"models/v_famas.mdl"},
	{"Roll Cage", 		"models/skinypanda/famas/v_famas.mdl"},
	{"Valence", 		"models/skinypanda/famas/v_famas_valence.mdl"},
	{"Rentgen", 		"models/skinypanda/famas/v_5.mdl"},
	{"Neon Mist", 		"models/skinypanda/famas/v_famas_neon_mist.mdl"},
	{"Skull", 		"models/skinypanda/famas/v_famas_skull.mdl"},
	{"Pixel", 		"models/skinypanda/famas/v_famas_pixel.mdl"}
}

new const SkinyM4A1[][][] = {
	{"Zwykla M4A1", 	"models/v_m4a1.mdl"},
	{"Howl", 		"models/skinypanda/m4a1/v_m4a1.mdl"},
	{"Cyrex", 		"models/skinypanda/m4a1/v_m4a1_cyrex.mdl"},
	{"Rentgen", 		"models/skinypanda/m4a1/v_5.mdl"},
	{"Heat", 		"models/skinypanda/m4a1/v_m4a1_heat.mdl"},
	{"Bumblebee", 		"models/skinypanda/m4a1/v_m4a1_bumblebee.mdl"},
	{"Nuclear Leek", 	"models/skinypanda/m4a1/v_m4a1_nuclear_leek.mdl"}
}

new const SkinyAK47[][][] = {
	{"Zwykly AK47", 	"models/v_ak47.mdl"},
	{"Anubis", 		"models/skinypanda/ak47/v_23.mdl"},
	{"Redline", 		"models/skinypanda/ak47/v_ak47_redline.mdl"},
	{"Rentgen", 		"models/skinypanda/ak47/v_5.mdl"},
	{"Orange Front", 	"models/skinypanda/ak47/v_ak47_orange_front.mdl"},
	{"Sticker", 		"models/skinypanda/ak47/v_ak47_sticker.mdl"},
	{"Red Dragon", 		"models/skinypanda/ak47/v_ak47_red_dragon.mdl"}
}

new const SkinyAWP[][][] = {
	{"Zwykle AWP", 		"models/v_awp.mdl"},
	{"Dragon Lore", 	"models/skinypanda/awp/v_awp.mdl"},
	{"Fever Dream", 	"models/skinypanda/awp/v_awp_fever_dream.mdl"},
	{"Rentgen", 		"models/skinypanda/awp/v_5.mdl"},
	{"Gradient", 		"models/skinypanda/awp/v_awp_gradient.mdl"},
	{"Red Puzzle", 		"models/skinypanda/awp/v_awp_red_puzzle.mdl"},
	{"Golden", 		"models/skinypanda/awp/v_awp_golden.mdl"}
}

new const HamBronie[][][] = {
	{"weapon_knife", "Noz"},
	{"weapon_deagle", "Deagle"},
	{"weapon_famas", "Famas"},
	{"weapon_m4a1", "M4A1"},
	{"weapon_ak47", "AK47"},
	{"weapon_awp", "AWP"}
}

public plugin_init(){ 
	register_plugin(PLUGIN, VERSION, AUTHOR);
	for(new i=0; i<sizeof(komendy); i++){
		register_clcmd(fmt("%s", komendy[i]), "menuWyboru");
	}
	for(new i=0; i<sizeof(HamBronie); i++){
		RegisterHam(Ham_Item_Deploy, fmt("%s", HamBronie[i][0]), "SetModelHam", true);
	}
	fvault_prune(skiny, 0, get_systime()-(30 * 86400)) 
	
}

public plugin_cfg(){
	rozmiar_tablicy[0]=sizeof(SkinyNoz);
	rozmiar_tablicy[1]=sizeof(SkinyDeagle);
	rozmiar_tablicy[2]=sizeof(SkinyFamas);
	rozmiar_tablicy[3]=sizeof(SkinyM4A1);
	rozmiar_tablicy[4]=sizeof(SkinyAK47);
	rozmiar_tablicy[5]=sizeof(SkinyAWP);
}

public plugin_precache(){ 
	for(new i=0; i<sizeof(SkinyNoz); i++)
		precache_model(fmt("%s", SkinyNoz[i][MODEL_FILE]))
	for(new i=0; i<sizeof(SkinyDeagle); i++)
		precache_model(fmt("%s", SkinyDeagle[i][MODEL_FILE]))
	for(new i=0; i<sizeof(SkinyFamas); i++)
		precache_model(fmt("%s", SkinyFamas[i][MODEL_FILE]))
	for(new i=0; i<sizeof(SkinyM4A1); i++)
		precache_model(fmt("%s", SkinyM4A1[i][MODEL_FILE]))
	for(new i=0; i<sizeof(SkinyAK47); i++)
		precache_model(fmt("%s", SkinyAK47[i][MODEL_FILE]))
	for(new i=0; i<sizeof(SkinyAWP); i++)
		precache_model(fmt("%s", SkinyAWP[i][MODEL_FILE]))
}

public plugin_natives(){
	register_native("unlockskin", "unlock_skin");
	register_native("Skiny", "Native_Skiny");
}

public unlock_skin(){
	set_task(1.0, "unlockskin", get_param(1))
}

public unlockskin(id){
	Zaladuj(id);
	gracz[id][6]=1;
}

public client_putinserver(id){
	new flagi=get_user_flags(id);
	if((flagi & ADMIN_LEVEL_G) || (flagi & ADMIN_LEVEL_F)){
		Zaladuj(id);
		gracz[id][6]=1;
	}
	else{
		for(new i=0; i<=sizeof(HamBronie); i++){
			gracz[id][i]=0;
		}
	}
}

public client_disconnected(id){
	if(gracz[id][6]==1 && (gracz[id][noz]>0 || gracz[id][deagle]>0 || gracz[id][famas]>0 || gracz[id][m4a1]>0 || gracz[id][ak47]>0 || gracz[id][awp]>0)){
		new key[33];
		if(is_steam(id)) get_user_authid(id, key, charsmax(key));
		else get_user_name(id, key, charsmax(key)), replace_all(key, charsmax(key), " ", "\");
		fvault_set_data(skiny, key, fmt("%d#%d#%d#%d#%d#%d", gracz[id][noz], gracz[id][deagle], gracz[id][famas], gracz[id][m4a1], gracz[id][ak47], gracz[id][awp]));
		gracz[id][6]=0;
	}
}

public Native_Skiny(){
	new id = get_param(1);
	menuWyboru(id);
}

public menuWyboru(id){
	if(gracz[id][6]!=1){
		client_print_color(id, print_chat, "^4[Skiny] ^1Nie posiadasz flagi ^3eVIP^1/^3sVIP^1, by korzystac ze skinow.");
		return PLUGIN_HANDLED;
	}
	
	new menu = menu_create(fmt("\d[\r*\y%s\r*\d] \w^nMenu Skinow:", nazwa), "skinsmenu");
	new menucallback = menu_makecallback("skins_menucallback");
	menu_additem(menu, fmt("%s \y-> \d%s", HamBronie[0][1], SkinyNoz[gracz[id][noz]][MODEL_NAME]));
	menu_additem(menu, fmt("%s \y-> \d%s", HamBronie[1][1], SkinyDeagle[gracz[id][deagle]][MODEL_NAME]));
	menu_additem(menu, fmt("%s \y-> \d%s", HamBronie[2][1], SkinyFamas[gracz[id][famas]][MODEL_NAME]));
	menu_additem(menu, fmt("%s \y-> \d%s", HamBronie[3][1], SkinyM4A1[gracz[id][m4a1]][MODEL_NAME]));
	menu_additem(menu, fmt("%s \y-> \d%s", HamBronie[4][1], SkinyAK47[gracz[id][ak47]][MODEL_NAME]));
	menu_additem(menu, fmt("%s \y-> \d%s", HamBronie[5][1], SkinyAWP[gracz[id][awp]][MODEL_NAME]));
	menu_addblank(menu, 0);
	menu_additem(menu, "\rReset skinow", _, _, menucallback);

	menu_setprop(menu, MPROP_EXITNAME, "Wyjscie");
	menu_display(id, menu);
	return PLUGIN_HANDLED;
}

public skins_menucallback(id, menu, item){
	if(gracz[id][noz]>0 || gracz[id][deagle]>0 || gracz[id][famas]>0 || gracz[id][m4a1]>0 || gracz[id][ak47]>0 || gracz[id][awp]>0)
		return ITEM_ENABLED;

	return ITEM_DISABLED;
}

public skinsmenu(id, menu, item){
	if(item==MENU_EXIT){
		menu_destroy(menu);
		return PLUGIN_HANDLED;
	}
	if(item==6){
		for(new i=0; i<sizeof(HamBronie); i++){
			gracz[id][i]=0;
		}
		new key[33];
		if(is_steam(id)) get_user_authid(id, key, charsmax(key));
		else get_user_name(id, key, charsmax(key)), replace_all(key, charsmax(key), " ", "\");
		if(fvault_get_keynum(skiny, key)!=-1) fvault_remove_key(skiny, key);
	}
	else{
		if(gracz[id][item]==rozmiar_tablicy[item]-1) gracz[id][item]=0;
		else gracz[id][item]+=1;
	}
	menu_destroy(menu);
	SetModelMenu(id);
	menuWyboru(id);
	return PLUGIN_HANDLED;
}

public SetModelMenu(id){
	switch(get_user_weapon(id)){
		case CSW_KNIFE: set_pev(id, pev_viewmodel2, SkinyNoz[gracz[id][noz]][MODEL_FILE]);
		case CSW_DEAGLE: set_pev(id, pev_viewmodel2, SkinyDeagle[gracz[id][deagle]][MODEL_FILE]);
		case CSW_FAMAS: set_pev(id, pev_viewmodel2, SkinyFamas[gracz[id][famas]][MODEL_FILE]);
		case CSW_M4A1: set_pev(id, pev_viewmodel2, SkinyM4A1[gracz[id][m4a1]][MODEL_FILE]);
		case CSW_AK47: set_pev(id, pev_viewmodel2, SkinyAK47[gracz[id][ak47]][MODEL_FILE]);
		case CSW_AWP: set_pev(id, pev_viewmodel2, SkinyAWP[gracz[id][awp]][MODEL_FILE]);
	}
	return PLUGIN_CONTINUE;  
}

public SetModelHam(ent){
	new id=get_pdata_cbase(ent, 41, 4);
	switch(get_pdata_int(ent, 43, 4)){
		case CSW_KNIFE: set_pev(id, pev_viewmodel2, SkinyNoz[gracz[id][noz]][MODEL_FILE]);
		case CSW_DEAGLE: set_pev(id, pev_viewmodel2, SkinyDeagle[gracz[id][deagle]][MODEL_FILE]);
		case CSW_FAMAS: set_pev(id, pev_viewmodel2, SkinyFamas[gracz[id][famas]][MODEL_FILE]);
		case CSW_M4A1: set_pev(id, pev_viewmodel2, SkinyM4A1[gracz[id][m4a1]][MODEL_FILE]);
		case CSW_AK47: set_pev(id, pev_viewmodel2, SkinyAK47[gracz[id][ak47]][MODEL_FILE]);
		case CSW_AWP: set_pev(id, pev_viewmodel2, SkinyAWP[gracz[id][awp]][MODEL_FILE]);
	}
	return PLUGIN_CONTINUE;	
}

Zaladuj(id){ 
	new key[33], vaultdata[34];
	if(is_steam(id)) get_user_authid(id, key, charsmax(key));
	else get_user_name(id, key, charsmax(key)), replace_all(key, charsmax(key), " ", "\");
	if(fvault_get_data(skiny, key, vaultdata, 33)){
		new bron[6][3];
		replace_all(vaultdata, charsmax(vaultdata), "#", " ");
		parse(vaultdata, bron[0], 2, bron[1], 2, bron[2], 2, bron[3], 2, bron[4], 2, bron[5], 2);
		gracz[id][noz]=str_to_num(bron[0]);
		gracz[id][deagle]=str_to_num(bron[1]);
		gracz[id][famas]=str_to_num(bron[2]);
		gracz[id][m4a1]=str_to_num(bron[3]);
		gracz[id][ak47]=str_to_num(bron[4]);
		gracz[id][awp]=str_to_num(bron[5]);
	}
	else{
		for(new i=0; i<sizeof(HamBronie); i++){
			gracz[id][i]=0;
		}
	}
}

stock bool:is_steam(id){
        new auth[65];
        get_user_authid(id,auth,64)
        if(contain(auth, "STEAM_0:0:") != -1 || contain(auth, "STEAM_0:1:") != -1)
                return true;
        return false;
}
