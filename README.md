# Nodule
low level ( char parsing ) generalised XML parser for Haxe

The trace output of the main example, you can see how it's fairly easy to extract information.

## Nodule 
Nodule is used to store 'nodes' or 'attributes' with data stored as a double linked tree structure, it keeps access to it's 'sisters', 'firstChild', 'firstAttribute' and 'parent'.
The reader is also setup to process normal XML structures.

See Console log trace for the test here shows comparative parsing speed ( best viewed in firefox ).
https://rawgit.com/nanjizal/Nodule/master/index.html

Recently added a toKhaScreen method to Nodule, this is fast enough to be called in the Kha render loop to render the Nodule as XML with color coding.

<img width="993" alt="noduleimage" src="https://user-images.githubusercontent.com/20134338/30983269-d8f1207e-a481-11e7-89f6-ad352f0da395.png">

This can be used quite simply.

```haxe
class Empty {
   var droidSans: Font;
    var nodule: Nodule;
    public function new() {
        Assets.loadEverything(loadAll);
    } 
    public function loadAll() {
       droidSans = Assets.fonts.DroidSans;
       nodule = ReadXML.toNodule( Assets.blobs.test_xml.toString() );
       System.notifyOnRender(render);
       Scheduler.addTimeTask(update, 0, 1 / 60);
    }

  function render(framebuffer: Framebuffer): Void {
    var g = framebuffer.g2;
    g.begin(0xFF181818);
    g.font = droidSans;
    // some twilight colors grabbed from textmate
    var txtCol = 0xFF8F9D6A;
    var txtCol2 = 0xFF9FAD7A;
    var keywordCol = 0xFFCDA869;
    var variableCol = 0xFF7587A6;
    var entityCol = 0xFF9B703F;
    var storageCol = 0xFFF9EE98;
    var constantCol = 0xFFCF6A4C;
    var foldingsCol = 0xFF5A6A65;
    var stringCol = 0xFF8F9D6A;
    var commentCol = 0xFF5F5A60;
    var stringVarCol = 0xFF8A9A95;
    var supportFuncCol = 0xFFDAD085;
    var backSlashCol = 0xFF8B604F;
    var x = 0.;
    var y = 0.;
    var tab = '   ';
    nodule.toKhaScreen( g, tab, x, y, droidSans, 18, { arrows: entityCol, nodeName: keywordCol
                                , attributeName: supportFuncCol, attributeEquals:stringCol
                                , attributeQuotes: txtCol, attributeValue: txtCol2
                                , content: storageCol, backSlash: backSlashCol });
    g.end();
  }
}
```
