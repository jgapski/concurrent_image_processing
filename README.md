CImP - Cuncurrent IMage Processing
=====

An OTP application

Build
-----

	$ rebar3 compile
	$ erl -pa _build/default/lib/cimp/ebin
	$ application:start(cimp).
	$ cimp_api:add_collection("/path/to/directory").
    
	$ cimp_collection_sup:answer(data).
	$ cimp_collection_sup:answer({brightness_above, E}).
    	$ cimp_collection_sup:answer(sum).
