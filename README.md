# SSL Certificate Tool for the Preside Developer Console

This is an extension for Preside that provides tools to manage SSL certificates within the Preside developer console:

* List SSL certificates for a host
* Install SSL certificates for a host

## Installation

Install with:

```box install preside-ext-ssl-cert-dev-tools```

## Usage

When your application tries to open https connections to external sites it can happen that Java does not recognise the SSL certificate for the target host and you'll end up with a Connection Failed error. Lucee Admin allows you to import the necessary certificates into the system but there are situations where the Lucee Admin has been disabled. The extension helps in these cases. From within Preside you can make sure Lucee lets you connect.

When logged into Preside Admin open the developer console and type `sslcert`.

## What's next

Code contributions are welcome.
