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
    public function attributes( arr: ArrayPair){
        if( firstAttribute != null ) firstAttribute.sistersNextArray( arr );
        return arr;
    }
    public function children( arr: ArrayPair ){
        if( firstChild != null ) firstChild.sistersNextArray( arr );
        return arr;
    }
    public function sistersNextArray( arr: ArrayPair ){
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
}