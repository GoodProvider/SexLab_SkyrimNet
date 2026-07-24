<manifest>
  <metadata>
    <source_file>SkyrimNet_SexLab_Handler_DOM.psc</source_file>
    <extends>SkyrimNet_SexLab_Handler_DOM_Interface</extends>
    <dependencies>
      - SkyrimNet_DOM_API
      - SkyrimNet_DOM_Menu
      - SkyrimNet_SexLab_Main
    </dependencies>
  </metadata>

  <context>
    # High-Level Architectural Purpose
    Acts as a concrete, script-driven bridge connecting active animation processing loops to relationship tracking states and compliance mechanics.

    ## Core Responsibilities
    * **Status Interception**: Evaluates actor submissive layers via native integrations (`SkyrimNet_DOM_API.IsDOMSlave`).
    * **Menu Routing**: Dispatches current participant metadata configurations into dynamic targeting interfaces.
    * **Scene Alteration**: Monitors orgasm-denial states and updates output text buffers based on fulfillment conditions during active scenes.
  </context>

  <critical_issues>
    ### Outstanding Code Review Items
    * **Load Order Vulnerability**: Employs hardcoded FormID index lookups (`0x800`) directly targeting `"SkyrimNet_SexLab.esp"`. If execution blocks fire before dependencies finish mounting during cell changes, it will yield a fatal `None` assignment.
  </critical_issues>
</manifest>