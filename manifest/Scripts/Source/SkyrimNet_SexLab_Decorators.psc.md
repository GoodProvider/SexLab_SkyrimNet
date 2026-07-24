<manifest>
  <metadata>
    <source_file>SkyrimNet_SexLab_Decorators.psc</source_file>
    <extends>None (Static Global Utility Library)</extends>
    <dependencies>
      - SkyrimNet_SexLab_Main
      - SkyrimNet_SexLab_Stages
      - SkyrimNet_SexLab_Utilities
      - PO3_SKSEFunctions
    </dependencies>
  </metadata>

  <context>
    # High-Level Architectural Purpose
    Exposes functional parsing decorators, environment spatial evaluations, and character layout adapters to the broad framework API.

    ## Core Responsibilities
    * **API Registration**: Injects script execution paths dynamically into core engine modules via `SkyrimNetApi.RegisterDecorator`.
    * **Spatial Auditing**: Tracks relative distance layers and active Line-of-Sight variables (`hasLOS`) across active actors.
    * **Equipment Scanning**: Evaluates active body slots (specifically Slots 32, 49, and 52) to check clothing thresholds and determine current exposure metrics.
  </context>

  <critical_issues>
    ### Outstanding Code Review Items
    * **Fragile Formatting Methods**: Uses hardcoded inline text concatenations (`"{" + '"' + "distance" ...`) to manually generate JSON metadata buffers in `Outfit_Options` and `Player_LOS_Distance`. This must be updated to use clean, stable object creation patterns.
  </critical_issues>
</manifest>