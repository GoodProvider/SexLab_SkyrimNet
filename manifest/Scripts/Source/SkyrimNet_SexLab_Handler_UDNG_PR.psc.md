<manifest>
  <metadata>
    <source_file>SkyrimNet_SexLab_Handler_UDNG_PR.psc</source_file>
    <extends>ReferenceAlias</extends>
    <dependencies>
      - SkyrimNet_SexLab_Handler_UDNG
    </dependencies>
  </metadata>

  <context>
    # High-Level Architectural Purpose
    Acts as a persistent player proxy tracker designed to anchor inventory events and ensure handlers initialize correctly across game save loads.

    ## Core Responsibilities
    * **Lifecycle Interception**: Captures standard engine initialization signals via `OnInit` and `OnPlayerLoadGame` events.
    * **Handler Re-Mounting**: Forwards processing instructions directly to the parent script handler block (`handler.Setup()`) to guarantee listener integrity.
  </context>

  <critical_issues>
    ### Outstanding Code Review Items
    * **Architecture Compliance**: This script inherits from `ReferenceAlias`. It must remain small and free of local variable assignments to avoid script bloat and trace log clutter.
  </critical_issues>
</manifest>