/* global RB */
RB.$.fn.windowTopToElBottom = function() {
    return this.offset().top + this.outerHeight(true);
};

RB.$.fn.windowLeftToElRight = function() {
    return this.offset().left + this.outerWidth(true);
};

RB.$.fn.heightOfBottomBoxShadow = function() {
    var cssString = this.css('box-shadow');
    if (!cssString || cssString === 'none') return 0;

    // rm color
    cssString = cssString.replace(/rgba?\([^\)]+\)/gi, '')
                         .replace(/#[0-9a-f]+/gi, '');

    // rm alpha characters
    cssString = $.trim(cssString.replace(/[a-z]+/gi, ''));

    // split into remaining 4 parts
    cssString = cssString.split(' ');
    var horizontalOffset = parseInt(cssString[0]),
        verticalOffset = parseInt(cssString[1]),
        length = parseInt(cssString[2]);

    return verticalOffset + length;
};
