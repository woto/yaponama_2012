!function($){function getVendorPropertyName(prop){if(prop in div.style)return prop;var prefixes=["Moz","Webkit","O","ms"],prop_=prop.charAt(0).toUpperCase()+prop.substr(1);if(prop in div.style)return prop;for(var i=0;i<prefixes.length;++i){var vendorProp=prefixes[i]+prop_;if(vendorProp in div.style)return vendorProp}}function checkTransform3dSupport(){return div.style[support.transform]="",div.style[support.transform]="rotateY(90deg)",""!==div.style[support.transform]}function Transform(str){return"string"==typeof str&&this.parse(str),this}function callOrQueue(self,queue,fn){queue===!0?self.queue(fn):queue?self.queue(queue,fn):fn()}function getProperties(props){var re=[];return $.each(props,function(key){key=$.camelCase(key),key=$.transit.propertyMap[key]||$.cssProps[key]||key,key=uncamel(key),support[key]&&(key=uncamel(support[key])),-1===$.inArray(key,re)&&re.push(key)}),re}function getTransition(properties,duration,easing,delay){var props=getProperties(properties);$.cssEase[easing]&&(easing=$.cssEase[easing]);var attribs=""+toMS(duration)+" "+easing;parseInt(delay,10)>0&&(attribs+=" "+toMS(delay));var transitions=[];return $.each(props,function(i,name){transitions.push(name+" "+attribs)}),transitions.join(", ")}function registerCssHook(prop,isPixels){isPixels||($.cssNumber[prop]=!0),$.transit.propertyMap[prop]=support.transform,$.cssHooks[prop]={get:function(elem){var t=$(elem).css("transit:transform");return t.get(prop)},set:function(elem,value){var t=$(elem).css("transit:transform");t.setFromString(prop,value),$(elem).css({"transit:transform":t})}}}function uncamel(str){return str.replace(/([A-Z])/g,function(letter){return"-"+letter.toLowerCase()})}function unit(i,units){return"string"!=typeof i||i.match(/^[\-0-9\.]+$/)?""+i+units:i}function toMS(duration){var i=duration;return"string"!=typeof i||i.match(/^[\-0-9\.]+/)||(i=$.fx.speeds[i]||$.fx.speeds._default),unit(i,"ms")}$.transit={version:"0.9.9",propertyMap:{marginLeft:"margin",marginRight:"margin",marginBottom:"margin",marginTop:"margin",paddingLeft:"padding",paddingRight:"padding",paddingBottom:"padding",paddingTop:"padding"},enabled:!0,useTransitionEnd:!1};var div=document.createElement("div"),support={},isChrome=navigator.userAgent.toLowerCase().indexOf("chrome")>-1;support.transition=getVendorPropertyName("transition"),support.transitionDelay=getVendorPropertyName("transitionDelay"),support.transform=getVendorPropertyName("transform"),support.transformOrigin=getVendorPropertyName("transformOrigin"),support.filter=getVendorPropertyName("Filter"),support.transform3d=checkTransform3dSupport();var eventNames={transition:"transitionEnd",MozTransition:"transitionend",OTransition:"oTransitionEnd",WebkitTransition:"webkitTransitionEnd",msTransition:"MSTransitionEnd"},transitionEnd=support.transitionEnd=eventNames[support.transition]||null;for(var key in support)support.hasOwnProperty(key)&&"undefined"==typeof $.support[key]&&($.support[key]=support[key]);div=null,$.cssEase={_default:"ease","in":"ease-in",out:"ease-out","in-out":"ease-in-out",snap:"cubic-bezier(0,1,.5,1)",easeOutCubic:"cubic-bezier(.215,.61,.355,1)",easeInOutCubic:"cubic-bezier(.645,.045,.355,1)",easeInCirc:"cubic-bezier(.6,.04,.98,.335)",easeOutCirc:"cubic-bezier(.075,.82,.165,1)",easeInOutCirc:"cubic-bezier(.785,.135,.15,.86)",easeInExpo:"cubic-bezier(.95,.05,.795,.035)",easeOutExpo:"cubic-bezier(.19,1,.22,1)",easeInOutExpo:"cubic-bezier(1,0,0,1)",easeInQuad:"cubic-bezier(.55,.085,.68,.53)",easeOutQuad:"cubic-bezier(.25,.46,.45,.94)",easeInOutQuad:"cubic-bezier(.455,.03,.515,.955)",easeInQuart:"cubic-bezier(.895,.03,.685,.22)",easeOutQuart:"cubic-bezier(.165,.84,.44,1)",easeInOutQuart:"cubic-bezier(.77,0,.175,1)",easeInQuint:"cubic-bezier(.755,.05,.855,.06)",easeOutQuint:"cubic-bezier(.23,1,.32,1)",easeInOutQuint:"cubic-bezier(.86,0,.07,1)",easeInSine:"cubic-bezier(.47,0,.745,.715)",easeOutSine:"cubic-bezier(.39,.575,.565,1)",easeInOutSine:"cubic-bezier(.445,.05,.55,.95)",easeInBack:"cubic-bezier(.6,-.28,.735,.045)",easeOutBack:"cubic-bezier(.175, .885,.32,1.275)",easeInOutBack:"cubic-bezier(.68,-.55,.265,1.55)"},$.cssHooks["transit:transform"]={get:function(elem){return $(elem).data("transform")||new Transform},set:function(elem,v){var value=v;value instanceof Transform||(value=new Transform(value)),elem.style[support.transform]="WebkitTransform"!==support.transform||isChrome?value.toString():value.toString(!0),$(elem).data("transform",value)}},$.cssHooks.transform={set:$.cssHooks["transit:transform"].set},$.cssHooks.filter={get:function(elem){return elem.style[support.filter]},set:function(elem,value){elem.style[support.filter]=value}},$.fn.jquery<"1.8"&&($.cssHooks.transformOrigin={get:function(elem){return elem.style[support.transformOrigin]},set:function(elem,value){elem.style[support.transformOrigin]=value}},$.cssHooks.transition={get:function(elem){return elem.style[support.transition]},set:function(elem,value){elem.style[support.transition]=value}}),registerCssHook("scale"),registerCssHook("translate"),registerCssHook("rotate"),registerCssHook("rotateX"),registerCssHook("rotateY"),registerCssHook("rotate3d"),registerCssHook("perspective"),registerCssHook("skewX"),registerCssHook("skewY"),registerCssHook("x",!0),registerCssHook("y",!0),Transform.prototype={setFromString:function(prop,val){var args="string"==typeof val?val.split(","):val.constructor===Array?val:[val];args.unshift(prop),Transform.prototype.set.apply(this,args)},set:function(prop){var args=Array.prototype.slice.apply(arguments,[1]);this.setter[prop]?this.setter[prop].apply(this,args):this[prop]=args.join(",")},get:function(prop){return this.getter[prop]?this.getter[prop].apply(this):this[prop]||0},setter:{rotate:function(theta){this.rotate=unit(theta,"deg")},rotateX:function(theta){this.rotateX=unit(theta,"deg")},rotateY:function(theta){this.rotateY=unit(theta,"deg")},scale:function(x,y){void 0===y&&(y=x),this.scale=x+","+y},skewX:function(x){this.skewX=unit(x,"deg")},skewY:function(y){this.skewY=unit(y,"deg")},perspective:function(dist){this.perspective=unit(dist,"px")},x:function(x){this.set("translate",x,null)},y:function(y){this.set("translate",null,y)},translate:function(x,y){void 0===this._translateX&&(this._translateX=0),void 0===this._translateY&&(this._translateY=0),null!==x&&void 0!==x&&(this._translateX=unit(x,"px")),null!==y&&void 0!==y&&(this._translateY=unit(y,"px")),this.translate=this._translateX+","+this._translateY}},getter:{x:function(){return this._translateX||0},y:function(){return this._translateY||0},scale:function(){var s=(this.scale||"1,1").split(",");return s[0]&&(s[0]=parseFloat(s[0])),s[1]&&(s[1]=parseFloat(s[1])),s[0]===s[1]?s[0]:s},rotate3d:function(){for(var s=(this.rotate3d||"0,0,0,0deg").split(","),i=0;3>=i;++i)s[i]&&(s[i]=parseFloat(s[i]));return s[3]&&(s[3]=unit(s[3],"deg")),s}},parse:function(str){var self=this;str.replace(/([a-zA-Z0-9]+)\((.*?)\)/g,function(x,prop,val){self.setFromString(prop,val)})},toString:function(use3d){var re=[];for(var i in this)if(this.hasOwnProperty(i)){if(!support.transform3d&&("rotateX"===i||"rotateY"===i||"perspective"===i||"transformOrigin"===i))continue;"_"!==i[0]&&re.push(use3d&&"scale"===i?i+"3d("+this[i]+",1)":use3d&&"translate"===i?i+"3d("+this[i]+",0)":i+"("+this[i]+")")}return re.join(" ")}},$.fn.transition=$.fn.transit=function(properties,duration,easing,callback){var self=this,delay=0,queue=!0,theseProperties=jQuery.extend(!0,{},properties);"function"==typeof duration&&(callback=duration,duration=void 0),"object"==typeof duration&&(easing=duration.easing,delay=duration.delay||0,queue=duration.queue||!0,callback=duration.complete,duration=duration.duration),"function"==typeof easing&&(callback=easing,easing=void 0),"undefined"!=typeof theseProperties.easing&&(easing=theseProperties.easing,delete theseProperties.easing),"undefined"!=typeof theseProperties.duration&&(duration=theseProperties.duration,delete theseProperties.duration),"undefined"!=typeof theseProperties.complete&&(callback=theseProperties.complete,delete theseProperties.complete),"undefined"!=typeof theseProperties.queue&&(queue=theseProperties.queue,delete theseProperties.queue),"undefined"!=typeof theseProperties.delay&&(delay=theseProperties.delay,delete theseProperties.delay),"undefined"==typeof duration&&(duration=$.fx.speeds._default),"undefined"==typeof easing&&(easing=$.cssEase._default),duration=toMS(duration);var transitionValue=getTransition(theseProperties,duration,easing,delay),work=$.transit.enabled&&support.transition,i=work?parseInt(duration,10)+parseInt(delay,10):0;if(0===i){var fn=function(next){self.css(theseProperties),callback&&callback.apply(self),next&&next()};return callOrQueue(self,queue,fn),self}var oldTransitions={},run=function(nextCall){var bound=!1,cb=function(){bound&&self.unbind(transitionEnd,cb),i>0&&self.each(function(){this.style[support.transition]=oldTransitions[this]||null}),"function"==typeof callback&&callback.apply(self),"function"==typeof nextCall&&nextCall()};i>0&&transitionEnd&&$.transit.useTransitionEnd?(bound=!0,self.bind(transitionEnd,cb)):window.setTimeout(cb,i),self.each(function(){i>0&&(this.style[support.transition]=transitionValue),$(this).css(properties)})},deferredRun=function(next){this.offsetWidth,run(next)};return callOrQueue(self,queue,deferredRun),this},$.transit.getTransitionValue=getTransition}(jQuery),function(){$(document).on("click",".rotate-button",function(event){var angle;return event.preventDefault(),angle=parseInt($("#upload_angle").val()),angle-=$(this).data("angle"),$("#upload_angle").val(angle),$("#img-rotate").transition({rotate:angle})})}.call(this);