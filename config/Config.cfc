component {

	public void function configure( required struct config ) {
		var settings = arguments.config.settings ?: {};

		settings.features[ "devtools.sslcert" ] = { enabled=true , siteTemplates=[ "*" ], widgets=[] }

	}
}