package;
import nodule.*;
class Main { static public function main():Void { new Main(); }
    public function new(){
        //var tests = [ 'test0','test1','test2','test3','test4','test5','test8'];
        var tests = ['test3'];
        for( test in tests ) testParse( test );
    }
    public function testParse( file: String ){
        trace( '_____________');
        trace( 'testing ' + file );
        trace( '_____________');
        var str = haxe.Resource.getString( file );
        trace( 'xml input >');
        trace( str );
        trace( '......');
        var nodule = ReadXML.parse( str );
        trace( 'children of ' + nodule.firstChild.name );
        trace( nodule.firstChild.children(new ArrayPair()) );
        trace( 'attributes of ' + nodule.firstChild.firstChild.name );
        trace( nodule.firstChild.firstChild.attributes(new ArrayPair()) );
    }
}