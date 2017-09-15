# copy-for-browser

[issues]: https://github.com/CliffS/copy-for-browser/issues

## Copy files from `node_modules` to a public path for use in the browser

This utility is designed to be used where you have both a
server and a browser client being loaded from the same tree.

It will copy files from under `node_modules` to the correct directory
in the public path, based on the `package.json` for the package.

## Install

    npm install copy-for-browser --save-dev

## Usage

In your `package.json`, your will need a section at the top level with
the key `"browserCopy"`.  This should contain one or more keys which are
destination paths for the files.  Each key should have an array of
file paths for the source files.

This is a (simplified) example of `package.json`:

```json
{
  "name": "my-package",
  "dependencies": {
    "jquery": "^3.2.1",
    "jquery-ui": "^1.12.1",
  },
  "dev-dependencies": {
    "copy-for-browser": "^1.0.0"
  },
  "browser": {
    "public/js/vendor": [
      "jquery/dist/jquery.min.js",
      "pouchdb/dist/pouchdb.min.js"
    ],
    "public/css": [
      "jquery-ui/themes/base/all.css"
    ]
  },
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "copy": "copy-for-browser"
  }
}
```

Using this, you can run `npm install` and `npm run copy` and the files
will appear in `public/js/vendor` and `public/css`, relative to the
root of your project.

Please let me know if you find this useful.  Any issues or
comments would be appreciated at [Github][issues].

### Note

In **version 1.x** of `copy-for-browser`, the key `"browser"` was used.
This has been changed to `"browserCopy"` to avoid the conflict with
[browserify](https://github.com/browserify/browserify).
