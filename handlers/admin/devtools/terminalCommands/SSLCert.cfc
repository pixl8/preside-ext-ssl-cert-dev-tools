component hint="SSL certificates" {

	property name="jsonRpc2Plugin" inject="JsonRpc2";

	private function index( event, rc, prc ) {
		var params             = jsonRpc2Plugin.getRequestParams();
		var subCommands        = [ "import", "list" ];

		params = isArray( params.commandLineArgs ?: "" ) ? params.commandLineArgs : [];

		if ( !params.len() || !arrayFindNoCase( subCommands, params[ 1 ] ) ) {
			return chr(10) & "[[b;white;]Usage:] sslcert sub_command" & chr(10) & chr(10)
			               & "Valid sub commands:" & chr(10) & chr(10)
			               & "    [[b;white;]list] : Lists a host's ssl certificates" & chr(10)
			               & "    [[b;white;]import] : Imports a host's ssl certificate" & chr(10);
		}

		try {
			return runEvent( event="admin.devtools.terminalCommands.sslcert.#params[1]#", private=true, prePostExempt=true );
		} catch ( any e ) {
			return chr(10) & "[[b;red;]Error processing your request:] " & e.message & chr(10);
		}
	}

	private function import( event, rc, prc ) {
		var params           = jsonRpc2Plugin.getRequestParams();
		var userInputPrompts = [];

		if ( !structKeyExists( params, "host" ) ) {
			arrayAppend( userInputPrompts, { prompt="Host: ", required=true, paramName="host"} );
		}
		if ( !structKeyExists( params, "port" ) ) {
			arrayAppend( userInputPrompts, { prompt="Port: ", required=false, paramName="port", default="443", validityRegex="^\d+$"} );
		}

		if ( arrayLen( userInputPrompts ) ) {
			return {
				  echo        = chr(10) & "[[b;white;]:: SSL Certificate Tool]" & chr(10) & chr(10)
				, inputPrompt = userInputPrompts
				, method      = "sslcert"
				, params      = params
			};
		}

		try {
			sslCertificateInstall( params.host, params.port?:443 );
		} catch ( any e ) {
			return chr(10) & "[[b;red;]Error importing certificate for #params.host#:#(params.port?:443)#:] [[b;white;]#e.message#]" & chr(10);
		}

		var msg = chr(10) & "[[b;white;]The SSL certificate for #params.host#:#(params.port?:443)# has been imported.]";

		return msg;
	}

	private any function list( event, rc, prc ) {
		var params           = jsonRpc2Plugin.getRequestParams();
		var userInputPrompts = [];

		if ( !structKeyExists( params, "host" ) ) {
			arrayAppend( userInputPrompts, { prompt="Host: ", required=true, paramName="host"} );
		}
		if ( !structKeyExists( params, "port" ) ) {
			arrayAppend( userInputPrompts, { prompt="Port: ", required=false, paramName="port", default="443", validityRegex="^\d+$"} );
		}

		if ( arrayLen( userInputPrompts ) ) {
			return {
				  echo        = chr(10) & "[[b;white;]:: SSL Certificate Tool]" & chr(10) & chr(10)
				, inputPrompt = userInputPrompts
				, method      = "sslcert"
				, params      = params
			};
		}

		var result = new Query();

		try {
			result = sslCertificateList( params.host, params.port?:443 );
		} catch ( any e ) {
			return chr(10) & "[[b;red;]Error fetching certificates for #params.host#:#(params.port?:443)#:] [[b;white;]#e.message#]" & chr(10);
		}

		var msg = chr(10) & "[[b;white;]The SSL certificate for #params.host#:#(params.port?:443)#: #serializeJSON(result)#]";

		return msg;
	}
}