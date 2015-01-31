# sub-atom package

A replacement for Atom's CompositeDisposable for easy subscribing to DOM events.

This NPM module is intended only for use in add-on packages for GitHub's Atom editor.  The sub-atom repo is at https://github.com/mark-hahn/sub-atom.  Feel free to ask questions at the Atom discussion group: https://discuss.atom.io/.

Sub-atom is a wrapper of of Atom's `CompositeDisposable` which is an Atom class that collects `Disposable` objects that enable disposing of event handlers.  `CompositeDisposable` has no provision for handling events on DOM elements.  The Atom docs say to do this for each DOM event subscription ...

```coffeescript
$(window).on 'focus', focusCallback
disposables.add new Disposable ->
  $(window).off 'focus', focusCallback
```

Obviously this is not acceptable for real-world code.  Sub-atom provides the class `SubAtom` which is 100% compatible with the Atom class `CompositeDisposable` but can also replace the code above with a single line.

## Usage
  
To install sub-atom simply use `npm install sub-atom`.  Then load and initialize the sub-atom module with ...

```coffeescript
SubAtom = require('sub-atom')
subs = new SubAtom
```

The `subs` object has a function `add` that can be used exactly as `CompositeDisposable::add` is used.  An example ...

```coffeescript
subs.add editor.onDidChange ->
```

The same function `add` can add DOM events with this signature.

```coffeescript
subs.add target, events, [selector], handler
```

**target:** A DOM element or a jQuery object containing a DOM element..  

**events:** One or more space-separated event types and optional namespaces, such as "click" or "keydown.myPlugin". 

**selector:** A selector string to filter the descendants of the selected elements that trigger the event. If the selector is null or omitted, then only the target element can trigger the event.

**handler:** A function to execute when the event is triggered. The value false is also allowed as a shorthand for a function that simply does return false.

The subs object also has a function `dispose` that disposes all added events.  This is identical to the method `CompositeDisposable::dispose`. Use ...

```coffeescript
subs.dispose()
```

## License

Sub-atom is copyright Mark Hahn with the MIT license.