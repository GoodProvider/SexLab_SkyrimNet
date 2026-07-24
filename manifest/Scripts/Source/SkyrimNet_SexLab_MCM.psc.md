<manifest>
  <metadata>
    <source_file>SkyrimNet_SexLab_MCM.psc</source_file>
    <extends>SKI_ConfigBase</extends>
    <dependencies>
      - SkyrimNet_SexLab_Main
      - SkyrimNet_SexLab_Stages
      - SkyrimNet_SexLab_Scene_Manager
      - SkyrimNet_SexLab_Scene_Actions
      - UIExtensions
      - StorageUtil
    </dependencies>
  </metadata>

  <context>
    # High-Level Architectural Purpose
    Provides the player configuration menu via SkyUI's MCM interface, handles runtime diagnostics, controls keybind layouts, and opens interactive character targeting menus.

    ## Core Responsibilities
    * **UI Rendering**: Builds option lists, slider tracking elements, and toggle parameters using SkyUI's interface framework.
    * **Targeting Acquisition**: Employs an interactive targeting loop using crosshair monitoring hooks to easily gather lists of target characters.
    * **Framework Routing**: Routes active user interface choices directly into the corresponding structural action manager scripts.
  </context>

  <critical_issues>
    ### Outstanding Code Review Items
    * **Fatal Naming Typo**: Contains a broken function call inside `MultiTarget_Menu_Selection` that points to a non-existent method name. This will cause compilation to fail completely.
      ```papyrus
      ; Typo error: "Spekaer" instead of "Speaker"
      manager.StartScene_Spekaer(actors_selected[1], actors_selected, victims, "normal", "", "")
      ```
    * **Type Coercion Inconsistency**: Compares native integer settings values against raw decimal float expressions (`== 0.0`).
  </critical_issues>
</manifest>