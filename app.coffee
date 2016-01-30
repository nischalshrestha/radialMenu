# A Floating Action Button interaction
# Hold and drag to a menu item; upon release, perform action

layerBackground = new BackgroundLayer
	backgroundColor: "white"

# Selected image
layerImage = new Layer
	image: "images/Opti.jpg"
	width: layerBackground.width
	height: layerBackground.height
	y: layerBackground.y

# Overlay over image
layerForeground = new Layer
	backgroundColor: "white"
	width: layerBackground.width
	height: layerBackground.height
	y: layerBackground.y

# layerForeground sits on top of layerImage to overlay
# the image when layerShare is clicked or click and drag
layerImage.superLayer = layerForeground
	
layerForeground.states.add
	second: {opacity: 0.2}
	
layerForeground.states.animationOptions = 
	curve: "ease"
	time: .250

layerFile = new Layer
	backgroundColor: "grayscale"
	y: 0
	width: layerBackground.width
	height: 100
	opacity: 0.9
	html: "<p style='text-align:center; margin:0.8em'><span style='color:white; font-size: 1.5em'>Hold Share Button and Drag to App</span></p>"

# Floating action button with the icon on top
layerShare = new Layer
	backgroundColor:  "#eb4646",
	width: 350, height: 350
	scale: 1
	borderRadius: 500
	shadowY: 2
	shadowBlur: 8
	shadowColor: "#62626b"
	shadowSpread: 2

layerShare.borderRadius = layerShare.width
layerShare.midX = layerBackground.width
layerShare.y = layerBackground.height - layerShare.height / 2

# Extended area to make sure user can target layerShare easily
layerBox = new Layer
	x: layerShare.x - 10, y: layerShare.y - 10
	width: layerShare.width + 20
	height: layerShare.height + 20
	opacity: 0
	
layerShareIcon = new Layer
	image: "images/share-variant.png"
	scale: 0.8

# layerShareIcon
layerShareIcon.superLayer = layerShare
layerShareIcon.center()
layerShareIcon.x -= 80
layerShareIcon.y -= 80

# Main menu button
layerShare.states.add
	second: {scale: 0.8}
layerShare.states.animationOptions =
	curve: "spring(500, 15, 0)"

# Plus icon for layerShare
layerShareIcon.states.add
	second: {rotation: 180, scale: 0.3}
	
layerShareIcon.states.animationOptions =
    time: .250

# Twitter
layerTwitter = new Layer
	backgroundColor: "#59adeb"
	x: layerShare.x, y: layerShare.y
	width: 150, height: 150
	scale: 0.2
	borderRadius: 500
	opacity: 0
	shadowY: 2
	shadowBlur: 8
	shadowColor: "#62626b"
	shadowSpread: 2
	
layerTwitterIcon = new Layer
	image: "images/twitter.png"
	x: layerTwitter.x, y: layerTwitter.y
	scale: 0.6

layerTwitterIcon.superLayer = layerTwitter
layerTwitterIcon.center()
layerTwitter.placeBehind(layerShare)

# Facebook
layerFacebook = new Layer
	backgroundColor: "#3d5c98"
	x: layerShare.x, y: layerShare.y
	width: 150, height: 150
	scale: 0.2
	borderRadius: 500
	opacity: 0
	shadowY: 2
	shadowBlur: 8
	shadowColor: "#62626b"
	shadowSpread: 2
	
layerFacebookIcon = new Layer
	image: "images/facebook.png"
	x: layerFacebook.x, y: layerFacebook.y
	scale: 0.6

layerFacebookIcon.superLayer = layerFacebook
layerFacebookIcon.center()
layerFacebook.placeBehind(layerShare)

layerInsta = new Layer
	backgroundColor: "#a0805e"
	x: layerShare.x, y: layerShare.y
	width: 150, height: 150
	scale: 0
	opacity: 0
	borderRadius: 500
	shadowY: 2
	shadowBlur: 8
	shadowColor: "#62626b"
	shadowSpread: 2
	
layerInstaIcon = new Layer
	image: "images/instagram.png"
	x: layerFacebook.x
	y: layerTwitter.y
	scale: 0.6

layerInstaIcon.superLayer = layerInsta
layerInstaIcon.center()
layerTwitter.placeBehind(layerShare)

# States for share menu items
layerTwitter.states.add
	second: {x: layerShare.x, y: layerShare.y - 300, scale: 1, opacity: 1}
layerTwitter.states.animationOptions =
	curve: "spring(220, 25, 20)"
	
layerFacebook.states.add
	second: {x: layerShare.x - 300, y: layerShare.y, scale: 1, opacity: 1}
layerFacebook.states.animationOptions =
	curve: "spring(200, 25, 20)"
	
layerInsta.states.add
	second: {x: layerFacebook.x - 200, y: layerTwitter.y - 200, scale: 1, opacity: 1}
layerInsta.states.animationOptions =
	curve: "spring(200, 25, 20)"

# Convenience function for stepping through layer states
changeState = ->
	layerForeground.states.next()
	layerShareIcon.states.next()
	layerShare.states.next()
	layerTwitter.states.next()
	layerFacebook.states.next()
	layerInsta.states.next()
	
layerBox.draggable.enabled = true

layerBox.on Events.DragStart, ->
	changeState()

# Keeping track of whether mouse hovered over items while dragging
onFacebook = 0
onInstagram = 0
onTwitter = 0

# Animations to scale and un-scale when hover over/away
animFacebook = new Animation
    layer: layerFacebook
    properties: scale: 1.2
    curve: "spring(200, 25, 20)"
   
animFacebookRev = new Animation
    layer: layerFacebook
    properties: scale: 1
    curve: "spring(200, 25, 20)"
    
animInsta = new Animation
    layer: layerInsta
    properties: scale: 1.2
    curve: "spring(200, 25, 20)"

animInstaRev = new Animation
    layer: layerInsta
    properties: scale: 1
    curve: "spring(200, 25, 20)"
   
animTwitter = new Animation
    layer: layerTwitter
    properties: scale: 1.2
    curve: "spring(200, 25, 20)"

animTwitterRev = new Animation
    layer: layerTwitter
    properties: scale: 1
    curve: "spring(200, 25, 20)"

# Scale up item if finger is over it; scale others down if they were scaled up
layerBox.on Events.DragMove, (event) ->
# 	FB
	if this.y > (layerInsta.y + layerInsta.height) and this.x < layerFacebook.x + layerFacebook.width
		animFacebook.start() and onFacebook = 1 if onFacebook == 0 # Scale up layerFacebook
		animInstaRev.start() and onInstagram = 0 if onInstagram == 1 # Scale down layerInsta
		animTwitterRev.start() and onTwitter = 0 if onTwitter == 1 # Scale down layerTwitter
# 	Insta
	if this.y <= layerFacebook.y and this.y > layerTwitter.y and this.x >= layerInsta.x and this.x <= layerInsta.x + layerInsta.width
		animInsta.start() and onInstagram = 1 if onInstagram == 0 # Scale up layerInsta
		animFacebookRev.start() and onFacebook = 0 if onFacebook == 1 # Scale down layerFacebook
		animTwitterRev.start() and onTwitter = 0 if onTwitter == 1 # Scale down layerTwitter
# 	Twitter
	if this.y < layerShare.y and this.x >= layerShare.x
		animTwitter.start() and onTwitter = 1 if onTwitter == 0 # Scale up layerTwitter
		animFacebookRev.start() and onFacebook = 0 if onFacebook == 1 # Scale down layerFacebook
		animInstaRev.start() and onInstagram = 0 if onInstagram == 1 # Scale down layerInsta
		
# Snap back layerBox to its origin
layerBox.on Events.DragEnd, ->
	changeState()
	layerBox.animate
		properties: {
			x: layerShare.x - 10
			y: layerShare.y - 10
		}
		time: 0