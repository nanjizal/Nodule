# Nodule
low level ( char parsing ) generalised XML parser for Haxe

The trace output of the main example, you can see how it's fairly easy to extract information, probably needs more thought in terms of accessing data, but I think perhaps it could make a good base for custom parsing of dynamic xml.
```
_____________  _.js:46:3
testing test3  _.js:47:3
_____________  _.js:48:3
xml input >  _.js:50:3
<?xml version="1.0" encoding="UTF-8"?>
<family>
    <father name = "Kawasaki" test = "bill" test2="fred">Yasuhisa</father>
</family>  _.js:51:3
......  _.js:52:3
children of family  _.js:162:3
( name: father, value: Yasuhisa )  _.js:170:3
attributes of father  _.js:171:3
( name: name, value: Kawasaki, name: test, value: bill, name: test2, value: fred )  _.js:179:3
```
