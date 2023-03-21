extends ConsoleCommand


func execute():
	super()
	if not has_arguments():
		for pack in SceneLoader._map_packs:
			for collection in pack.map_collections:
				for level in collection.maps:
					Logger.debug_log(level.resource_path)
