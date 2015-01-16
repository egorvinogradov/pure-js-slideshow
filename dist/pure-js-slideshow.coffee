class PureJSSlideshow

    container: null
    containerClass: "pure-js-slideshow"

    activeItemIndex: 0
    visibleItemsNumber: 3

    selectors:
        item: ".pure-js-slideshow-item"
        image: ".pure-js-slideshow-image"

    constructor: (@containerId) ->

        @container = document.getElementById @containerId
        unless @container
            throw new Error "No container provided"

    initialize: (files) ->

        @files = files

        @render()

        @item = document.querySelectorAll @selectors.item
        @image = document.querySelectorAll @selectors.image

        @width = @getItemsWidth()

        @prev.addEventListener "click", =>
            @switchItem "prev"
        , false

        @next.addEventListener "click", =>
            @switchItem "next"
        , false

    render: ->

        @container.classList.add @containerClass

        @inner = @createElement "div", className: "pure-js-slideshow-inner", @container

        @prev = @createElement "button", {
            className: "pure-js-slideshow-button pure-js-slideshow-prev"
            innerHTML: "Prev"
        }, @container

        @next = @createElement "button", {
            className: "pure-js-slideshow-button pure-js-slideshow-next",
            innerHTML: "Next"
        }, @container

        for file in @files
            item = @createElement "div", className: "pure-js-slideshow-item", @inner
            image = @createElement "img", {
                className: "pure-js-slideshow-image",
                src: file
            }, item

    createElement: (tagName, attributes, container) ->

        element = document.createElement tagName
        for key, value of attributes
            element[key] = value

        if container
            container.appendChild element

        element

    switchItem: (direction) ->

        if direction is "next"
            nextIndex = @getNextIndex()

        else if direction is "prev"
            nextIndex = @getPrevIndex()

        @inner.style.left = - @getShiftByIndex(nextIndex) + "px"
        @activeItemIndex = nextIndex

    getPrevIndex: ->

        if @activeItemIndex > 0
            @activeItemIndex - 1
        else
            @item.length - @visibleItemsNumber

    getNextIndex: ->

        if @activeItemIndex < @item.length - @visibleItemsNumber
            @activeItemIndex + 1
        else
            0

    getShiftByIndex: (index) ->

        shift = 0
        for i in [0 .. index]
            width = @width[i - 1]
            if width
                shift += width
        shift

    getItemsWidth: ->

        width = []
        for item in @item
            width.push item.offsetWidth
        width
