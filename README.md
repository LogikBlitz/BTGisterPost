BTGisterPost
============

A small plugin for Xcode that allows for posting of Gist's directly from Xcode.
It is purposely meant to be very small and not to intrusive.
It is not the most pretty little thing, but it gets the job done.
Think of it a you friendly Gist hammer:-D



# Getting started
To install the plugin do the following.
* Clone repo.
* Copy the precompiled plugin from the folder: `"PathToRepo/PluginIsHere/BTGisterPost.xcplugin"`
to `~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins`
* Alternatively build the solution and the plugin will automatically be installed. Remember to restart XCode for the plugin to be activated.

## How to use the plugin
In Xcode the plugin will add a new menupoint in the `edit` menu: `Post Gist To Github`.
Alternatively you can also use the shortcut `⌥ + c` `(option + c)`
to trigger the plugin.  
It will post the currently selected text as a gist.
If no text is selected all text in the current open document will be converted into a gist.

### Github user credentials.
To post a gist the plugin requires a username and login to a valid GitHub account. These info are not misused. If you have any concerns feel free to check the source.

# Uninstall
To uninstall the plugin simply delete it from the folder where it resides:
`~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/BTGisterPost.xcplugin`

# Plugin state
The plugin is in beta state. It works for posting gists but it is a 

# Dependencies
The plugin uses a modified version of [UAGithubEngine](https://github.com/owainhunt/uagithubengine) for GitHub communication. The framework has been scaled down a bit, and converted to not use ARC, since ARC is not supported in Xcode plugins.

# Future Improvements
* Better visual layout. Especially modal view with user/password request needs some work.

# Contributions
If you would like to contribute to the plugin, simply fork the project and submit a pull request. See [GitHub help](https://help.github.com/articles/fork-a-repo)



