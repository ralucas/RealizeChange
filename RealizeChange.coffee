root = global ? window

if root.Meteor.isClient
        root.Template.hello.greeting = ->
                "Welcome to RealizeChange."

        root.Template.hello.events = 'click input' : ->
                console.log "You pressed the button"

if root.Meteor.isServer
        root.Meteor.startup = ->  console.log("none")
        
