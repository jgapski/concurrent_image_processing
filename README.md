CImP - Cuncurrent IMage Processing
=====

An OTP application

Build
-----

	$ rebar3 compile
	$ erl -pa _build/default/lib/cimp/ebin
	$ application:start(cimp).
	$ cimp_collection_sup:start_link().
	$ cimp_collection_sup:load_directory("home/kirahvi/Pictures").
