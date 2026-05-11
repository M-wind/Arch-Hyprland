require("mime-ext.local"):setup {
	-- Expand the existing filename database (lowercase), for example:
	with_files = {
		makefile = "text/makefile",
		-- ...
	},

	-- Expand the existing extension database (lowercase), for example:
	with_exts = {
		nu = "text/nu",
		tgz = "application/gzip",
		-- ...
	},

	-- If the MIME type is not in both filename and extension databases,
	-- then fallback to Yazi's preset `mime.local` plugin, which uses `file(1)`
	fallback_file1 = false,
}
