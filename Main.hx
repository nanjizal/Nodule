package;
import nodule.*;
import DevTools.*;
class Main { static public function main():Void { new Main(); }
    public function new(){
        //var tests = [ 'test0','test1','test2','test3','test4','test5','test8','test9'];
        //var tests = ['test7'];
        //for( test in tests ) testParse( test );
        var doxTest = ['cpp','cs','flash','hl','java','js','lua','macro','neko','php','python'];
        for( test in doxTest ) testParse( test );
    }
    public function testParse( file: String ){
        trace( '_____________');
        trace( 'testing ' + file );
        trace( '_____________');
        var str = haxe.Resource.getString( file );
        trace( 'xml input >');
        trace( str );
        trace( '......');
        var x0: Xml;
        var x1: Xml;
        var x2: Xml;
        var x3: Nodule;
        var x4: Xml;
        var s0: String = '';
        var s1: String = '';
        measure( x0 = Xml.parse(str) );
        measure( x1 = haxe.xml.Parser.parse( str ) );
        measure( x2 = ReadXML.toXml( str ) );
        measure( x3 = ReadXML.toNodule( str ) );
        measure( x4 = ReadXML.toNoduleAndXML( str ) );
        measure( s0 = x3.toStringPretty() ); 
        measure( s1 = x0.toString() );
        trace( 'nodule to string ' + s0 );
        trace( 'xml to string ' + s1 );
        //trace( x1.toString() );
        //trace( x4.toString() );
    }
}