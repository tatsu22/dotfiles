return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" },
	root_markers = { "go.mod", ".git" },
	settings = {
		gopls = {
			gofumpt = true,
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedParams = true,
			},
		},
	},
}
