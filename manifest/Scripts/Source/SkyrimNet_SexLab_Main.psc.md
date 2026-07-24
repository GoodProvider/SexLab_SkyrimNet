<manifest>
  <metadata>
    <source_file>SkyrimNet_SexLab_Main.psc</source_file>
    <extends>Quest</extends>
    <dependencies>
      - JContainers
      - UIExtensions
      - StorageUtil
      - SexLabFramework
      - SkyrimNet_SexLab_Handler_DOM_Interface
    </dependencies>
  </metadata>

  <context>
    # High-Level Architectural Purpose
    The core master hub script for the mod framework. It manages global engine tracking flags, coordinates conditional third-party framework integrations, and caches actor equipment states.

    ## Core Responsibilities
    * **Integration Validation**: Performs verification passes across external script layers (`ostimnet_found`) to toggle corresponding sub-features safely.
    * **Animation Interception**: Updates global state monitors (`skyrimnet_sexlab_active_sex`) to temporarily pause non-essential engine tasks during scenes.
    * **Inventory Safeguarding**: Employs `StorageUtil` lists to index items unequipped during sl_scene actions, ensuring they are safely restored to characters upon sl_scene completion.
  </context>

  <critical_issues>
    ### Outstanding Code Review Items
    * **Race Conditions**: `Setup()` runs direct casting lookups for external interfaces via `Game.GetFormFromFile` without validating that the returned forms are active. This can cause errors if the game engine hasn't fully loaded the target objects.
  </critical_issues>
</manifest>