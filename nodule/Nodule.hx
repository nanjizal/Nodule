package nodule;
class Nodule {
    public function new(){}
    public function addChild( nodule: Nodule ){
        nodule.parent = this;
        if( firstChild == null ){
            firstChild = nodule;
            nodule.parent = this;
        } else {
            firstChild.addSister( nodule );
            nodule.parent = this;
        }
    }
    public function addSister( nodule: Nodule ){
        if( nextSister == null ){
            nextSister = nodule;
            nodule.prevSister = this;
            nodule.parent = this.parent;
        } else {
            nextSister.addSister( nodule );
        }
    }
    public function addAttribute( nodule: Nodule ){
        nodule.parent = this;
        if( firstAttribute == null ){
            firstAttribute = nodule;
            nodule.parent = this;
        } else {
            firstAttribute.addSister( nodule );
            nodule.parent = this;
        }
    }
    public var name: String;
    public var firstChild: Nodule;
    public var content: String;
    public var firstAttribute: Nodule;
    public var nextSister: Nodule;
    public var prevSister: Nodule;
    public var parent: Nodule;
    public function attributes( arr: AttributePairs ){
        if( firstAttribute != null ) firstAttribute.sistersNextArray( arr );
        return arr;
    }
    public function children( arr: ArrayPair ){
        if( firstChild != null ) firstChild.sistersNextArray( arr );
        return arr;
    }
    public function childNodules( arr: Array<Nodule> ){
        if( firstChild != null ) {
            arr[0] = firstChild;
            firstChild.sistersNextNodules( arr );
        }
        return arr;
    }
    public function sistersNextNodules( arr: Array<Nodule> ){
        var len = arr.length;
        var scope = this;
        var n = scope.nextSister;
        while( n != null  ){
            arr[ len++ ] = n;
            scope = n;
            n = scope.nextSister;
        }
        return arr;
    }
    
    
    public function sistersNextArray( arr: Array<{ name: String,value: String }> ){
        var len = 0;
        if( this.content != null ) arr[len++]=  {name: this.name, value: this.content };
        var scope = this;
        var n = scope.nextSister;
        while( n != null  ){
            if( n.content != null ) arr[ len++ ]=  { name: n.name, value: n.content };
            scope = n;
            n = scope.nextSister;
        }
        return arr;
    }
    public function attributeNames(){
        if( firstAttribute != null ) {
            trace( 'attributes' );
            firstAttribute.sistersNameNext();
        }
    }
    public function attributeContents(){
        if( firstAttribute != null ) firstAttribute.sistersContentNext();
    }
    public function childrenNames(){
        if( firstChild != null ) firstChild.sistersNameNext();
    }
    public function childrenContents(){
        if( firstChild != null ) firstChild.sistersContentNext();
    }
    public function sistersNameNext(){
        if( this.name != null ) trace( this.name );
        var scope = this;
        var n = scope.nextSister;
        while( n != null  ){
            if( this.name != null ) trace( n.name );
            scope = n;
            n = scope.nextSister;
        }
    }
    public function sistersContentNext(){
        if( this.content != null ) trace( this.content );
        var scope = this;
        var n = scope.nextSister;
        while( n != null ){
            if( n.content != null ) trace( n.content );
            scope = n;
            n = scope.nextSister;
        }
    }
    @:keep
    public function toStringPretty( ?tab: String = ''){
        var atPair: AttributePairs = attributes( new AttributePairs() );
        var out =  tab + '<' + name + atPair;
        var childs: Array<Nodule> = childNodules( new Array() );
        if( content != null ){
            if( content.length > 45 ){ // when line too long start on new line indented
                out += '>\n' + tab + '   ' + content + '\n' + tab + '</'+name + '>\n';
            } else {
                out += '>' + content + '</'+name + '>\n';
            }
        } else if( childs != null ) {
            out += '>\n';    
            for( i in 0...childs.length ){
                out += childs[i].toStringPretty( tab + '   ' );
            }
            out += tab + '</'+name + '>\n';
        } else {
            out += '/>\n';
        }
        return out;
    }
    
    @:keep
    public function toString(){
        var atPair: AttributePairs = attributes( new AttributePairs() );
        var out =  '<' + name + atPair;
        var childs: Array<Nodule> = childNodules( new Array() );
        if( content != null ){
            out += '>' + content + '</'+name + '>';
        } else if( childs != null ) {
            out += '>';    
            for( i in 0...childs.length ){
                out += childs[i].toString();
            }
            out += '</'+name + '>';
        } else {
            out += '/>';
        }
        return out;
    }
    #if kha
    public function toKhaScreen(  g:    kha.graphics2.Graphics
                                , tab:  String
                                , x:    Float, y: Float
                                , font: kha.Font
                                , size: Int
                                , coloring: { arrows: kha.Color, nodeName: kha.Color
                                , attributeName: kha.Color, attributeEquals: kha.Color, attributeQuotes: kha.Color, attributeValue: kha.Color
                                , content: kha.Color, backSlash: kha.Color } ): Float {
        var dx: Float = x;
        var dy: Float = y;
        var str: String = '';
        var strHi =  g.font.height( size );
        g.font = font;
        g.fontSize = size;
        trace( 'drawing ');
        str = tab + '<';
        g.color = coloring.arrows;
        g.drawString( str, dx, dy );
        trace( 'drawing ' + str );
        dx += g.font.width( size, str );
        str = name;
        g.color = coloring.nodeName;
        g.drawString( str, dx, dy );
        dx += g.font.width( size, str );
        var atPair: AttributePairs = attributes( new AttributePairs() );
        var at = { name: String, value: String }
        for( i in 0...atPair.length ){
            at = cast atPair[ i ];
            str = ' ' + at.name;
            g.color = coloring.attributeName;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = '=';
            g.color = coloring.attributeEquals;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = '"';
            g.color = coloring.attributeQuotes;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = cast at.value;
            g.color = coloring.attributeValue;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = '" ';
            g.color = coloring.attributeQuotes;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
        }
        var childs: Array<Nodule> = childNodules( new Array() );
        if( content != null ){
            str = '>';
            g.color = coloring.arrows;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            var strIter = new nodule.StringCodeIterator( content );
            strIter.next();
            strIter.addChar();
            str = strIter.toStr();
            while( strIter.hasNext() ){
                switch( strIter.c ){
                    case '\r'.code | '\n'.code:
                        if( str != '' ){
                            g.color = coloring.content;
                            g.drawString( str, dx, dy );
                            dx += g.font.width( size, str );
                        }
                        strIter.resetBuffer();
                        strIter.next();
                        dy = dy + strHi;
                        dx = g.font.width( size, tab );  
                    default:
                        strIter.next();
                        strIter.addChar();
                        str = strIter.toStr();
                }
            }
            str = strIter.toStr();
            if( str != '' ){
                g.color = coloring.content;
                g.drawString( str, dx, dy );
                dx += g.font.width( size, str );
            }
            str = '<';
            g.color = coloring.arrows;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = '/';
            g.color = coloring.backSlash;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = name;
            g.color = coloring.nodeName;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = '>';
            g.color = coloring.arrows;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
        } else if( childs != null ) {
            str = '>';
            g.color = coloring.arrows;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            for( i in 0...childs.length ){
                dy = dy + strHi;
                dx = 0;
                dy = childs[ i ].toKhaScreen(  g, tab + '   ', dx, dy, font, size, coloring );
            }
            dy = dy + strHi;
            dx = 0; 
            str = tab + '<';
            g.color = coloring.arrows;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = '/';
            g.color = coloring.backSlash;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = name;
            g.color = coloring.nodeName;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = '>';
            g.color = coloring.arrows;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
        } else {
            str = '>';
            g.color = coloring.arrows;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            str = '/';
            g.color = coloring.backSlash;
            g.drawString( str, dx, dy );
            dx += g.font.width( size, str );
            dy = dy + strHi;
            dx = 0; 
        }
        return dy;
    }
    #end
}