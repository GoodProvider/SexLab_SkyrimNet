<manifest>
  <metadata>
    <source_file>SkyrimNet_SexLab_Handler_UDNG.psc</source_file>
    <extends>Quest</extends>
    <dependencies>
      - zadLibs (Devious Devices - Integration.esm 0xF624)
      - SkyrimNet_SexLab_WebUI.Bondage_Configure
    </dependencies>
  </metadata>

  <context>
    # High-Level Architectural Purpose
    Optional Devious Devices handler for TargetMenu BondagePanel. zadLibs types stay on this quest so the main ESP loads without DD.

    ## Core Responsibilities
    * **Module Attunement**: `Devious Devices - Assets.esm` + zadLibs from Integration.esm during Setup.
    * **Catalog**: JContainers `Data/SKSE/Plugins/SkyrimNet_SexLab/bondage/group-devices.json`.
    * **WebUI**: `TM_BondageRefresh` seeds original; `TM_BondageFinish(speaker, target, style, currentJson)` applies pending ids then CloseOverlay; `TM_BondageOnWebUIClosed` ReleaseAll only. ModEvent `SkyrimNet_SexLab_UDNG_MenuOpen` still maps to Refresh.
  </context>
</manifest>
