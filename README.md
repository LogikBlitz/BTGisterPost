## For XCode 5. dev6 support
The plugin works in XCode 5 dev. 6. Just checkout the branch: xcode5-dev6
This branch is experimental!

## BTGisterPost for XCode 4.\*  
A small plug-in for Xcode 4.\* that allows for posting of Gist's directly from Xcode.
It is purposely meant to be very small and not to intrusive.
It is not the most pretty little thing, but it gets the job done.   
Think of it as your friendly Gist hammer:-D.  

__It has been tested in Xcode 4.6.2 on OS X 10.8\*__ but should work just fine in Xcode 4.\* and OS X 10.7 (Without user notifications).

### Getting started
If you just want to install the plug-in the best way is to use the XCode package manager [Alcatraz](http://mneorr.github.com/Alcatraz).
This plug-in is available in the package list, just look for **BTGisterPost** and check it for installation.  
You can also build the plug-in directly from the source:
* Clone this repository.
* Open the project in Xcode 4+
* Build the solution -- the plug-in will automatically be installed.
* Restart Xcode for the plug-in to be activated.

#### How to use the plug-in
In Xcode the plug-in will add a new menu-point in the `edit` menu: `Post Gist To Github`.
Alternatively you can also use the shortcut `⌥ + c` i.e. `(option + c)`
to trigger the plug-in.  
It will use the currently selected text to create a gist.  
If no text is selected all text in the current open document will be converted into a gist.

##### GitHub user credentials.
To post a gist the plug-in requires a **username*** and **password** to a valid GitHub account. Your information is not in any way used for anything else but creating Gist's. If you have any concerns feel free to check the source.

### Uninstall
To uninstall the plug-in simply delete it from the folder where it resides:
`~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/BTGisterPost.xcplugin`  
Or if using **Alzatraz** just uncheck the plug-in in the package list, and it should be removed.  
Remember to restart Xcode for the removal to take effect.

### Dependencies
The plug-in uses a modified version of [UAGithubEngine](https://github.com/owainhunt/uagithubengine) for GitHub communication. The framework has been scaled down a bit, and converted to not use ARC, since ARC is not supported in Xcode plug-ins.


### Contributions
If you would like to contribute to the plug-in, simply fork the project and submit a pull request. See [GitHub help](https://help.github.com/articles/fork-a-repo)

### License
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


