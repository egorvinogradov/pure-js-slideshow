# pure-js-slideshow
Simple image carousel written with pure JS

### Initialization

#### 1. Add JS and CSS files
```html
<link rel="stylesheet" href="../dist/pure-js-slideshow.css">
<script src="../dist/pure-js-slideshow.js"></script>
```

#### 2. Create slideshow container within body element
```html
<body>
    <!-- Container -->
    <div id="carousel"></div>
</body>
```

#### 3. Initialize slideshow. Place the following code after slideshow container
```html
<script>

    // Create an instance, pass container id
    var pureJSSlideshow = new PureJSSlideshow('carousel');

    // Initialize and pass images
    pureJSSlideshow.initialize([
        'images/image-1.jpg',
        'images/image-2.jpg',
        'images/image-3.jpg',
        'images/image-4.jpg',
        'images/image-5.jpg'
    ]);

</script>
```
