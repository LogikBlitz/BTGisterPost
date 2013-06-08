BTGisterPost
============

A small plugin for Xcode 4.\* that allows for posting of Gist's directly from Xcode.
It is purposely meant to be very small and not to intrusive.
It is not the most pretty little thing, but it gets the job done.
Think of it a you friendly Gist hammer:-D
It has been tested in Xcode 4.6.2 on OS X 10.8*.

# Getting started
To install the plugin do the following.
* Clone repo.
* Copy the precompiled plugin from the folder: `"PathToRepo/PluginIsHere/BTGisterPost.xcplugin"`
to `~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins`
* Alternatively build the solution and the plugin will automatically be installed. Remember to restart XCode for the plugin to be activated.

## How to use the plugin
In Xcode the plugin will add a new menupoint in the `edit` menu: `Post Gist To Github`.
Alternatively you can also use the shortcut `⌥ + c` i.e. `(option + c)`
to trigger the plugin.  
It will post the currently selected text as a gist.
If no text is selected all text in the current open document will be converted into a gist.

### Github user credentials.
To post a gist the plugin requires a username and login to a valid GitHub account. Your information is not in any way used for anything else but creating Gist's. If you have any concerns feel free to check the source.

# Uninstall
To uninstall the plugin simply delete it from the folder where it resides:
`~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/BTGisterPost.xcplugin`

# Dependencies
The plugin uses a modified version of [UAGithubEngine](https://github.com/owainhunt/uagithubengine) for GitHub communication. The framework has been scaled down a bit, and converted to not use ARC, since ARC is not supported in Xcode plugins.

# Future Improvements
* Better visual layout. Especially modal view with user/password request needs some work.

# Contributions
If you would like to contribute to the plugin, simply fork the project and submit a pull request. See [GitHub help](https://help.github.com/articles/fork-a-repo)

# License
The MIT License (MIT)

Copyright (c) 2013 Thomas Blitz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


