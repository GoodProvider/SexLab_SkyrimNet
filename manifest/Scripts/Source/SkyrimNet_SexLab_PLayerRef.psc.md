<manifest>
  <metadata>
    <source_file>SkyrimNet_SexLab_PlayerRef.psc</source_file>
    <extends>ReferenceAlias</extends>
    <dependencies>
      - SkyrimNet_SexLab_Main
    </dependencies>
  </metadata>

  <context>
    # High-Level Architectural Purpose
    A player alias script that acts as the initial startup engine for the framework, bootstrapping core tracking tasks every time the game finishes loading.

    ## Core Responsibilities
    * **Engine Bootstrapping**: Uses `OnInit` and `OnPlayerLoadGame` events to kick off initial configuration loops.
    * **Fallback Dependency Resolution**: Checks if the master tracking property is empty; if so, it forces an immediate lookup query against FormID `0x800` to re-establish the connection to the main framework script.
  </context>

  <critical_issues>
    ### Outstanding Code Review Items
    * **Optimization Notice**: Safe layout. Make sure this script remains entirely decoupled from high-frequency updates, such as frame-by-frame loops, to prevent resource starvation on the Papyrus virtual machine thread pool.
  </critical_issues>
</manifest>