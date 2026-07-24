<manifest>
  <metadata>
    <source_file>SkyrimNet_SexLab_Handler_UDNG.psc</source_file>
    <extends>Quest</extends>
    <dependencies>
      - SkyrimNet_UDNG_Groups
    </dependencies>
  </metadata>

  <context>
    # High-Level Architectural Purpose
    Handles specialized dynamic device events and system listener tasks to properly maintain inventory states during active scenes.

    ## Core Responsibilities
    * **Module Attunement**: Listens for active framework presence (`SkyrimNetUDNG.esp`) during primary startup routines.
    * **Event Subscriptions**: Registers for custom `ModEvent` listeners to safely capture framework interface updates.
    * **Device Synchronization**: Intercepts `MenuOpen` event signals to force real-time restraint updates on affected actors.
  </context>

  <critical_issues>
    ### Outstanding Code Review Items
    * **Alias Alignment**: Ensure that event listener bindings (`SkyrimNet_SexLab_UDNG_MenuOpen`) remain perfectly synchronized with the event strings emitted by external master asset frameworks.
  </critical_issues>
</manifest>