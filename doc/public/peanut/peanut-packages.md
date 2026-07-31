# Peanut Packages

A Peanut package (not to be confused with a Concrete CMS package) is a directory containing code for a Peanut feature, or
feature set expected to be used across multiple sites. Like the code directories and the tq-peanut/application directories,
packages contain view models, services, database code and other resources.

If your code is intended for use on a site, it is recommeded you place it in the tq-peanut/application directory.

## Create a Package

In the package directory, web.root/tq-peanut/pnut/packages, create a new directory for your package.
Name as lower case, hyphenated, resolves to pascal case for namespace. Eg. wordpress-tools = WordpressTools.

Create directory structure with configuration files.<br>
<pre>
package-name
  /config
    translations.ini (optional)
    viewmodels.ini
  /src
  package.ini
</pre>
<br>

Optional source directories may be created as needed.<br>
<pre>
    /view
    /vm
    /src
        /services
        /db
            /model
                /entity
                /repository
</pre>

All view models used in the package are declared in the viewmodels.ini file.

### Example package ini

The ini file must be present for the bootstrap routine to register autoloading.

```ini
[package]
name=permissions
version=1.1
author='Terry SoRelle'
description='Permission management'
```
## Testing

### Add a service class

Example<br>
Package name: wordpress-tools<br>
File location: web.root/tq-peanut/pnut/packages/wordpress-tools/src/services/MakeWpuserCommand.php<br>
Source:
```php
namespace Peanut\WordpressTools\services;
use Tops\services\TServiceCommand;
class MakeWpuserCommand extends TServiceCommand
{
    protected function run()
    {
        // TODO: Implement run() method.
    }
}
```
Note that the root namespace must match the package directory name. E.g.<br>
Package directory name: wordpress-tools<br>
Namespace root: Peanut\WordpressTools<br>
In our example the class file is in the 'services' directory below the package directory, so the namespace is:<br>
Peanut\WordpressTools\services;

Add class name to web.root/tq-peanut/bootstrap/required-classes.php
```php
<?php
return [
    'Smalot\\PdfParser\\Parser',
    '\Peanut\WordpressTools\services\MakeWpuserCommand',
];
```
On startup, if the bootstrap routine fails to register the class for autoloading, it will exit with an error message
showing the namespaces that failed.  Usual errors:
- Package.ini missing
- Package directory name doesn't match namespace declared in the class.
- Class file in wrong directory.

## Service calls from view models
in the TypeScript view model, use the executeService() method to call the service. Prepend the service name with
'peanut.' + the package name + '::'.

```typescript
me.services.executeService('peanut.wordpress-tools::MakeWpUser'
```
