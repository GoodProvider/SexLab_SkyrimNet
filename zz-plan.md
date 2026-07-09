
Fix my response

<plugin_response>
I see... Changing how JC stores strings is a much bigger request than I can reasonably tackle right now as it deserves some careful considerations of all the depedencies.

Hasn't this issue come up before? The toJSONString() function has been available for several months now when you asked for a release. Perhaps the string it returns could be normalized instead.

Also, SkyrimNet really needs a better way to work with Skyrim if it relies solely on case-sensitive string matching. This is the general functionality of Skyrim. It is not only JC that should be fixed here. I briefly looked at Inja as well and it already provide helpers like lowercase()?
</plugin_response>

<my_response>
I was waiting for you to push it to [nexusmods](https://www.nexusmods.com/skyrimspecialedition/mods/16495) before I converted all my manually crafted JSON into JContainers and forced everyone to add one more non-nexusmods download.  But your code is too useful :)  and I didn't want to wait anymore. 

I understand if its too much for you right now. I going to create an issue for SkyrimNet, but I think this issue would be generally useful to anyone who does any post processing of the JSON files. For now I'm checking the 

Inja uses the same nesting solver syntax as JContainer.  So you have actor.body.hand.figures.0. It would be too much to include all the permutations of all the letters in that path. lowercase will only work on strings, not on path resolution. 

Thanks for your work.
</my_response> 