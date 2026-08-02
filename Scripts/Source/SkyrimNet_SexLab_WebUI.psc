Scriptname SkyrimNet_SexLab_WebUI

; hasStrippedItems: focus actor has skyrimnet_sexlab_storage_items (actionSwitch gate)
; editTagsPlayer / editTagsNonPlayer: MCM Tag Edit toggles cached for TargetMenu → Scene Creator.
Function Target_Menu_Open(Actor target, Bool hasStrippedItems, Bool editTagsPlayer, Bool editTagsNonPlayer) global native
Function Target_Menu_Refresh(Bool hasStrippedItems) global native
Function Sex_Menu_Open(Form thread, bool has_player) global native
Function YesNo_Open(String question, int creator_sid) global native
Function SceneCreator_Open(String state_json) global native
Function Scene_Menu_Open(Form thread, Form sl_scene) global native
Function Scene_Menu_Show(String state_json) global native
Function WebUI_HideAllPanels() global native
; MCM: enable/disable C++ menu hotkey and set DX scancode (Escape unchanged).
Function WebUI_SetHotkey(int dxScanCode, bool enabled) global native
; Push SexLab gender + race_key enrich result to Scene Creator JS (actorAnimMetaResult).
Function ActorAnimMeta_Result(String json) global native
String Function TraceLog(String script_name, String func, String msg) global native
