class Carousel

    container: null
    containerClass: "carousel"

    activeItemIndex: 0
    visibleItemsNumber: 3

    selectors:
        item: ".carousel-item"
        image: ".carousel-image"

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

        console.log('Initialized carousel', @container, @files)

    render: ->

        @container.classList.add @containerClass

        @inner = @createElement "div", className: "carousel-inner", @container

        @prev = @createElement "button", {
            className: "carousel-button carousel-prev"
            innerHTML: "Prev"
        }, @container

        @next = @createElement "button", {
            className: "carousel-button carousel-next",
            innerHTML: "Next"
        }, @container

        for file in @files
            item = @createElement "div", className: "carousel-item", @inner
            image = @createElement "img", {
                className: "carousel-image",
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
