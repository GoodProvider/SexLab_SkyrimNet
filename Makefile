VERSION=0.30.5
NAME=SkyrimNet SexLab

RELEASE_FILE=versions/SkyrimNet_SexLab ${VERSION}.7z

ANIM_SRC= C:\Skyrim\dev\overwrite\SKSE\Plugins\SkyrimNet_SexLab\animations\_local_
ANIM_DST= SKSE\Plugins\SkyrimNet_SexLab\animations\GoodProvider

merge:
	uv run ./python_scripts/merge_animations.py -s ${ANIM_SRC} -d ${ANIM_DST}
	git add ${ANIM_DST}/*
	git commit ${ANIM_DST}

update: 
	updateSpriggit.bat 
	serialize.bat 

dd: 
	cd headers
	git clone https://github.com/IHateMyKite/PapyrusSourcesDD
	python3 ./python_scripts/FOMOD-info.py -v ${VERSION} -n '${NAME}' -o FOMOD/info.xml FOMOD-source/info.xml

release: 
	python3 ./python_scripts/info.py -v ${VERSION} -n '${NAME}' -o SKSE/Plugins/SkyrimNet_SexLab/info.json
	python3 ./python_scripts/fomod-update-name-version.py -v ${VERSION} -n '${NAME}' -o FOMOD/info.xml FOMOD_source/info.xml
	python3 ./python_scripts/fomod-update-name-version.py -v ${VERSION} -n '${NAME}' -o FOMOD/ModuleConfig.xml FOMOD_source/ModuleConfig.xml
	if exist '${RELEASE_FILE}' rm /Q /S '${RELEASE_FILE}'

	if exist "$(subst /,\\,core)" rmdir /s /q "$(subst /,\\,core)"	
	mkdir core 
	powershell -NoProfile -Command "Copy-Item -Path 'Scripts','SKSE','SkyrimNet_SexLab.esp' -Destination 'core/.' -Recurse -Force"


	if exist "$(subst /,\\,handler_udng)" rmdir /s /q "$(subst /,\\,handler_udng)"	
	mkdir handler_udng 
	powershell -NoProfile -Command "Copy-Item -Path 'SkyrimNet_SexLab_Handler_UDNG.esp' -Destination 'handler_udng/.' -Recurse -Force"

	7z -bb1 a '${RELEASE_FILE}' -aoa FOMOD \
		core \
		images \
		handler_udng 
	if exist "$(subst /,\\,core)" rmdir /s /q "$(subst /,\\,core)"		

group_tags:
	python3 ./python_scripts/group-tags.py animations > SkyrimNet_SexLab/group_tags.json
