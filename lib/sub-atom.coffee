###
  lib/sub-atom.coffee
###

{CompositeDisposable, Disposable} = require 'atom'
$ = require 'jquery'

module.exports = 
class SubAtom
  
  constructor: -> @disposables = new CompositeDisposable
  
  add: (target, events, selector, handler) ->
  
    # if target instanceof Disposable
    if not events
      @disposables.add target
      return

    if not handler 
      handler = selector
      selector = null

    subscription = $(target).on events, selector, handler

    @disposables.add new Disposable ->
      subscription.off events, handler

  dispose: -> @disposables.dispose()
