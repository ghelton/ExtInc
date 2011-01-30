/**
 ##########################################################################################
 ScaleUtil
 
 Copyright (c) 2010 Screamstream Interactive. All rights reserved.
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 ##########################################################################################
 */
package com.UI
{
	
	
	
	/**
	 * [Description]
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 * @author philipbroadway
	 * @since  Jan 20, 2010
	 */
	public class ScaleUtil
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		public static const version:uint				= 1.0;
		private static var instance:ScaleUtil			= null;
		
		/**
		 * Resizes a for b 
		 * @param a
		 * @param b
		 * @return 
		 * 
		 */		
		public static function scaleLow(a:Number,b:Number):Number
		{
			return ( a < b ) ? a : b;
		}
		
		public static function scaleHeigh(a:Number,b:Number):Number
		{
			return ( a < b ) ? b : a;
		}
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function ScaleUtil():void
		{
			super();
		}	
	}
}