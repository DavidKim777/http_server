{application, 'http_server', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['http_server_app','http_server_sup']},
	{registered, [http_server_sup]},
	{applications, [kernel,stdlib]},
	{optional_applications, []},
	{mod, {'http_server_app', []}},
	{env, []}
]}.