package nodule;

class ReadXML {
    public static inline function parse( str_: String ): Nodule {
        var s: String;
        var spaces: Int = 0;
        var strIter = new StringCodeIterator( str_ );
        strIter.next();
        var rootNodule = new Nodule();
        rootNodule.name = 'root';
        // change as parsed
        var parent = rootNodule; 
        var nodule: Nodule = null;
        var spaceBuf = new StringBuf();
        while( strIter.hasNext() ){
            switch( strIter.c ){
                case '\n'.code, '\r'.code:
                    // new line ignore
                case '<'.code:
                    s = spaceBuf.toString();
                    if( spaces != s.length ) {
                        // add content to nodule
                        // trace( '   ' + s );/
                        if( nodule != null ) nodule.content = s;
                    }
                    spaces = 0;
                    strIter.next();
                    spaceBuf = new StringBuf();
                    strIter.resetBuffer();
                    switch( strIter.c ){
                        case '/'.code:
                            // closing tag
                            strIter.next();
                            strIter.resetBuffer();
                            while( strIter.c  != '>'.code ){
                                strIter.addChar();
                                strIter.next();
                            }
                            var s = strIter.toStr();
                            // trace( '</' + s + '>' );
                            if( s == parent.name ){
                                parent = parent.parent;
                            }
                        case '?'.code:
                            // header
                            strIter.next();
                            strIter.resetBuffer();
                            while( strIter.c  != '?'.code ){
                                strIter.addChar();
                                strIter.next();
                            }
                            var s = strIter.toStr();
                            // trace( '<?' + s + '?>');
                            strIter.next();
                        case '!'.code:
                            // comment 
                            // ignore ?
                            strIter.resetBuffer();
                            while( strIter.c  != '>'.code ){
                                strIter.addChar();
                                strIter.next();
                            }
                            var s = strIter.toStr();
                            s = s.substr( 3, s.length - 5 );
                            // trace( '<!--' + s + '-->');
                            strIter.next();
                        default:
                            // opening tag
                            strIter.resetBuffer();
                            while( strIter.c  != '>'.code && strIter.c != ' '.code ){
                                strIter.addChar();
                                strIter.next();
                            }
                            var s = strIter.toStr();
                            // trace( '<' + s + '>' );
                            var node = new Nodule();
                            node.name = s;
                            nodule = node;
                            parent.addChild( nodule );
                            parent = nodule;
                            var att: Nodule = null;
                            var toggle = true;
                            while( strIter.c  != '>'.code ){
                                switch( strIter.c ){
                                    case ' '.code, '='.code:
                                        strIter.next();
                                    default:
                                        strIter.resetBuffer();
                                        while( strIter.c  != '>'.code && strIter.c != ' '.code && strIter.c != '='.code ){
                                            strIter.addChar();
                                            strIter.next();
                                        }
                                        var s = strIter.toStr();
                                        if( toggle ){
                                            var att_ = new Nodule();
                                            att = att_;
                                            att.name = s;
                                            nodule.addAttribute( att );
                                        } else {
                                            att.content = firstLast( s );
                                            // add attribute
                                            // trace( '@' + att.name + " : "  + att.content );
                                        }
                                        toggle = !toggle;
                                }
                            }
                    }
                default:
                    if( strIter.c == ' '.code ) spaces++; // keeps track of spaces added
                    spaceBuf.addChar( strIter.c );
            }
            strIter.next();
        }
        strIter = null;
        return rootNodule;
    }
    public static inline function firstLast( s: String ){
        return s.substr( 1, s.length-2 );
    }
    public static inline function last( s: String ){
        return s.substr( 0, s.length-1 );
    }
}