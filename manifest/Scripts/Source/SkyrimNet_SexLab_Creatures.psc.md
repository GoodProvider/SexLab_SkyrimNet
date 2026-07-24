<manifest>
  <metadata>
    <source_file>SkyrimNet_Sexlab_Creatures.psc</source_file>
    <extends>None (Static Global Utility Library)</extends>
    <dependencies>
      - PO3_SKSEFunctions
      - JContainers
    </dependencies>
  </metadata>

  <context>
    # High-Level Architectural Purpose
    Provides batch array parsing, indexing, and persistent database caching operations for non-human or creature actor structures.

    ## Core Responsibilities
    * **Form Harvesting**: Queries active load order modules (`CreatureSummoner.esp`) utilizing `PO3_SKSEFunctions` to isolate hardcoded race variants.
    * **Data Mapping**: Normalizes dynamic form collections into serializable `JMap` object models.
    * **Disk Operations**: Writes structured metadata arrays cleanly out to runtime system JSON files.
  </context>

  <critical_issues>
    ### Outstanding Code Review Items
    * **Memory Leak Risk**: In `Store_Races()`, while individual child information trees are inserted into the parent container, the root `races` database handle reference is never cleared out via a lifecycle detachment command. This leaks JContainers object allocations directly into active runtime saves.
      ```papyrus
      ; Missing cleanup hook before scope termination
      JValue.release(races)
      ```
  </critical_issues>
</manifest>