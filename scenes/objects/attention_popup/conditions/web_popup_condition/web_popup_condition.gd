extends RefCounted

func condition():
#	return true
	return OS.get_name() == 'Web'
