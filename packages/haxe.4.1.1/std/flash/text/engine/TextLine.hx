package flash.text.engine;

extern final class TextLine extends flash.display.DisplayObjectContainer {
	@:flash.property var ascent(get,never) : Float;
	@:flash.property var atomCount(get,never) : Int;
	@:flash.property var descent(get,never) : Float;
	@:flash.property var hasGraphicElement(get,never) : Bool;
	@:flash.property @:require(flash10_1) var hasTabs(get,never) : Bool;
	@:flash.property var mirrorRegions(get,never) : flash.Vector<TextLineMirrorRegion>;
	@:flash.property var nextLine(get,never) : TextLine;
	@:flash.property var previousLine(get,never) : TextLine;
	@:flash.property var rawTextLength(get,never) : Int;
	@:flash.property var specifiedWidth(get,never) : Float;
	@:flash.property var textBlock(get,never) : TextBlock;
	@:flash.property var textBlockBeginIndex(get,never) : Int;
	@:flash.property var textHeight(get,never) : Float;
	@:flash.property var textWidth(get,never) : Float;
	@:flash.property var totalAscent(get,never) : Float;
	@:flash.property var totalDescent(get,never) : Float;
	@:flash.property var totalHeight(get,never) : Float;
	@:flash.property var unjustifiedTextWidth(get,never) : Float;
	var userData : Dynamic;
	@:flash.property var validity(get,set) : String;
	function new() : Void;
	function dump() : String;
	function flushAtomData() : Void;
	function getAtomBidiLevel(atomIndex : Int) : Int;
	function getAtomBounds(atomIndex : Int) : flash.geom.Rectangle;
	function getAtomCenter(atomIndex : Int) : Float;
	function getAtomGraphic(atomIndex : Int) : flash.display.DisplayObject;
	function getAtomIndexAtCharIndex(charIndex : Int) : Int;
	function getAtomIndexAtPoint(stageX : Float, stageY : Float) : Int;
	function getAtomTextBlockBeginIndex(atomIndex : Int) : Int;
	function getAtomTextBlockEndIndex(atomIndex : Int) : Int;
	function getAtomTextRotation(atomIndex : Int) : String;
	function getAtomWordBoundaryOnLeft(atomIndex : Int) : Bool;
	function getBaselinePosition(baseline : String) : Float;
	function getMirrorRegion(mirror : flash.events.EventDispatcher) : TextLineMirrorRegion;
	private function get_ascent() : Float;
	private function get_atomCount() : Int;
	private function get_descent() : Float;
	private function get_hasGraphicElement() : Bool;
	private function get_hasTabs() : Bool;
	private function get_mirrorRegions() : flash.Vector<TextLineMirrorRegion>;
	private function get_nextLine() : TextLine;
	private function get_previousLine() : TextLine;
	private function get_rawTextLength() : Int;
	private function get_specifiedWidth() : Float;
	private function get_textBlock() : TextBlock;
	private function get_textBlockBeginIndex() : Int;
	private function get_textHeight() : Float;
	private function get_textWidth() : Float;
	private function get_totalAscent() : Float;
	private function get_totalDescent() : Float;
	private function get_totalHeight() : Float;
	private function get_unjustifiedTextWidth() : Float;
	private function get_validity() : String;
	private function set_validity(value : String) : String;
	static final MAX_LINE_WIDTH : Int;
}
