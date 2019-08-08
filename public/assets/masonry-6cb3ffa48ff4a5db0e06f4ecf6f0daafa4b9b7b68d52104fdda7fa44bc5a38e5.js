(function(t){function e(){}function i(p){function i(t){t.prototype.option||(t.prototype.option=function(t){p.isPlainObject(t)&&(this.options=p.extend(!0,this.options,t))})}function n(a,h){p.fn[a]=function(e){if("string"!=typeof e)return this.each(function(){var t=p.data(this,a);t?(t.option(e),t._init()):(t=new h(this,e),p.data(this,a,t))});for(var t=f.call(arguments,1),i=0,n=this.length;i<n;i++){var o=this[i],r=p.data(o,a);if(r)if(p.isFunction(r[e])&&"_"!==e.charAt(0)){var s=r[e].apply(r,t);if(void 0!==s)return s}else u("no such method '"+e+"' for "+a+" instance");else u("cannot call methods on "+a+" prior to initialization; attempted to call '"+e+"'")}return this}}if(p){var u="undefined"==typeof console?e:function(t){console.error(t)};return p.bridget=function(t,e){i(e),n(t,e)},p.bridget}}var f=Array.prototype.slice;"function"==typeof define&&define.amd?define("jquery-bridget/jquery.bridget",["jquery"],i):i(t.jQuery)})(window),function(n){var t=document.documentElement,e=function(){};t.addEventListener?e=function(t,e,i){t.addEventListener(e,i,!1)}:t.attachEvent&&(e=function(e,t,i){e[t+i]=i.handleEvent?function(){var t=n.event;t.target=t.target||t.srcElement,i.handleEvent.call(i,t)}:function(){var t=n.event;t.target=t.target||t.srcElement,i.call(e,t)},e.attachEvent("on"+t,e[t+i])});var o=function(){};t.removeEventListener?o=function(t,e,i){t.removeEventListener(e,i,!1)}:t.detachEvent&&(o=function(t,e,i){t.detachEvent("on"+e,t[e+i]);try{delete t[e+i]}catch(o){t[e+i]=void 0}});var i={bind:e,unbind:o};"function"==typeof define&&define.amd?define("eventie/eventie",i):n.eventie=i}(this),function(e){function o(t){"function"==typeof t&&(o.isReady?t():s.push(t))}function i(t){var e="readystatechange"===t.type&&"complete"!==r.readyState;if(!o.isReady&&!e){o.isReady=!0;for(var i=0,n=s.length;i<n;i++){(0,s[i])()}}}function t(t){return t.bind(r,"DOMContentLoaded",i),t.bind(r,"readystatechange",i),t.bind(e,"load",i),o}var r=e.document,s=[];o.isReady=!1,"function"==typeof define&&define.amd?(o.isReady="function"==typeof requirejs,define("doc-ready/doc-ready",["eventie/eventie"],t)):e.docReady=t(e.eventie)}(this),function(){function t(){}function r(t,e){for(var i=t.length;i--;)if(t[i].listener===e)return i;return-1}function e(t){return function(){return this[t].apply(this,arguments)}}var i=t.prototype;i.getListeners=function(t){var e,i,n=this._getEvents();if("object"==typeof t)for(i in e={},n)n.hasOwnProperty(i)&&t.test(i)&&(e[i]=n[i]);else e=n[t]||(n[t]=[]);return e},i.flattenListeners=function(t){var e,i=[];for(e=0;t.length>e;e+=1)i.push(t[e].listener);return i},i.getListenersAsObject=function(t){var e,i=this.getListeners(t);return i instanceof Array&&((e={})[t]=i),e||i},i.addListener=function(t,e){var i,n=this.getListenersAsObject(t),o="object"==typeof e;for(i in n)n.hasOwnProperty(i)&&-1===r(n[i],e)&&n[i].push(o?e:{listener:e,once:!1});return this},i.on=e("addListener"),i.addOnceListener=function(t,e){return this.addListener(t,{listener:e,once:!0})},i.once=e("addOnceListener"),i.defineEvent=function(t){return this.getListeners(t),this},i.defineEvents=function(t){for(var e=0;t.length>e;e+=1)this.defineEvent(t[e]);return this},i.removeListener=function(t,e){var i,n,o=this.getListenersAsObject(t);for(n in o)o.hasOwnProperty(n)&&(-1!==(i=r(o[n],e))&&o[n].splice(i,1));return this},i.off=e("removeListener"),i.addListeners=function(t,e){return this.manipulateListeners(!1,t,e)},i.removeListeners=function(t,e){return this.manipulateListeners(!0,t,e)},i.manipulateListeners=function(t,e,i){var n,o,r=t?this.removeListener:this.addListener,s=t?this.removeListeners:this.addListeners;if("object"!=typeof e||e instanceof RegExp)for(n=i.length;n--;)r.call(this,e,i[n]);else for(n in e)e.hasOwnProperty(n)&&(o=e[n])&&("function"==typeof o?r.call(this,n,o):s.call(this,n,o));return this},i.removeEvent=function(t){var e,i=typeof t,n=this._getEvents();if("string"===i)delete n[t];else if("object"===i)for(e in n)n.hasOwnProperty(e)&&t.test(e)&&delete n[e];else delete this._events;return this},i.removeAllListeners=e("removeEvent"),i.emitEvent=function(t,e){var i,n,o,r=this.getListenersAsObject(t);for(o in r)if(r.hasOwnProperty(o))for(n=r[o].length;n--;)!0===(i=r[o][n]).once&&this.removeListener(t,i.listener),i.listener.apply(this,e||[])===this._getOnceReturnValue()&&this.removeListener(t,i.listener);return this},i.trigger=e("emitEvent"),i.emit=function(t){var e=Array.prototype.slice.call(arguments,1);return this.emitEvent(t,e)},i.setOnceReturnValue=function(t){return this._onceReturnValue=t,this},i._getOnceReturnValue=function(){return!this.hasOwnProperty("_onceReturnValue")||this._onceReturnValue},i._getEvents=function(){return this._events||(this._events={})},"function"==typeof define&&define.amd?define("eventEmitter/EventEmitter",[],function(){return t}):"object"==typeof module&&module.exports?module.exports=t:this.EventEmitter=t}.call(this),function(t){function e(t){if(t){if("string"==typeof r[t])return t;t=t.charAt(0).toUpperCase()+t.slice(1);for(var e,i=0,n=o.length;i<n;i++)if(e=o[i]+t,"string"==typeof r[e])return e}}var o="Webkit Moz ms Ms O".split(" "),r=document.documentElement.style;"function"==typeof define&&define.amd?define("get-style-property/get-style-property",[],function(){return e}):t.getStyleProperty=e}(window),function(t){function E(t){var e=parseFloat(t);return-1===t.indexOf("%")&&!isNaN(e)&&e}function L(){for(var t={width:0,height:0,innerWidth:0,innerHeight:0,outerWidth:0,outerHeight:0},e=0,i=S.length;e<i;e++){t[S[e]]=0}return t}function e(t){function e(t){if("string"==typeof t&&(t=document.querySelector(t)),t&&"object"==typeof t&&t.nodeType){var e=z(t);if("none"===e.display)return L();var i={};i.width=t.offsetWidth,i.height=t.offsetHeight;for(var n=i.isBorderBox=!(!b||!e[b]||"border-box"!==e[b]),o=0,r=S.length;o<r;o++){var s=S[o],a=e[s];a=v(t,a);var h=parseFloat(a);i[s]=isNaN(h)?0:h}var p=i.paddingLeft+i.paddingRight,u=i.paddingTop+i.paddingBottom,f=i.marginLeft+i.marginRight,l=i.marginTop+i.marginBottom,d=i.borderLeftWidth+i.borderRightWidth,c=i.borderTopWidth+i.borderBottomWidth,m=n&&_,y=E(e.width);!1!==y&&(i.width=y+(m?0:p+d));var g=E(e.height);return!1!==g&&(i.height=g+(m?0:u+c)),i.innerWidth=i.width-(p+d),i.innerHeight=i.height-(u+c),i.outerWidth=i.width+f,i.outerHeight=i.height+l,i}}function v(t,e){if(s||-1===e.indexOf("%"))return e;var i=t.style,n=i.left,o=t.runtimeStyle,r=o&&o.left;return r&&(o.left=t.currentStyle.left),i.left=e,e=i.pixelLeft,i.left=n,r&&(o.left=r),e}var _,b=t("boxSizing");return function(){if(b){var t=document.createElement("div");t.style.width="200px",t.style.padding="1px 2px 3px 4px",t.style.borderStyle="solid",t.style.borderWidth="1px 2px 3px 4px",t.style[b]="border-box";var e=document.body||document.documentElement;e.appendChild(t);var i=z(t);_=200===E(i.width),e.removeChild(t)}}(),e}var i=document.defaultView,s=i&&i.getComputedStyle,z=s?function(t){return i.getComputedStyle(t,null)}:function(t){return t.currentStyle},S=["paddingLeft","paddingRight","paddingTop","paddingBottom","marginLeft","marginRight","marginTop","marginBottom","borderLeftWidth","borderRightWidth","borderTopWidth","borderBottomWidth"];"function"==typeof define&&define.amd?define("get-size/get-size",["get-style-property/get-style-property"],e):t.getSize=e(t.getStyleProperty)}(window),function(t,o){function i(t,e){return t[a](e)}function r(t){t.parentNode||document.createDocumentFragment().appendChild(t)}function e(t,e){r(t);for(var i=t.parentNode.querySelectorAll(e),n=0,o=i.length;n<o;n++)if(i[n]===t)return!0;return!1}function n(t,e){return r(t),i(t,e)}var s,a=function(){if(o.matchesSelector)return"matchesSelector";for(var t=["webkit","moz","ms","o"],e=0,i=t.length;e<i;e++){var n=t[e]+"MatchesSelector";if(o[n])return n}}();if(a){var h=i(document.createElement("div"),"div");s=h?i:n}else s=e;"function"==typeof define&&define.amd?define("matches-selector/matches-selector",[],function(){return s}):window.matchesSelector=s}(0,Element.prototype),function(t){function m(t,e){for(var i in e)t[i]=e[i];return t}function y(t){for(var e in t)return!1;return!null}function g(t){return t.replace(/([A-Z])/g,function(t){return"-"+t.toLowerCase()})}function e(t,e,r){function i(t,e){t&&(this.element=t,this.layout=e,this.position={x:0,y:0},this._create())}var n=r("transition"),o=r("transform"),s=n&&o,a=!!r("perspective"),h={WebkitTransition:"webkitTransitionEnd",MozTransition:"transitionend",OTransition:"otransitionend",transition:"transitionend"}[n],p=["transform","transition","transitionDuration","transitionProperty"],u=function(){for(var t={},e=0,i=p.length;e<i;e++){var n=p[e],o=r(n);o&&o!==n&&(t[n]=o)}return t}();m(i.prototype,t.prototype),i.prototype._create=function(){this._transition={ingProperties:{},clean:{},onEnd:{}},this.css({position:"absolute"})},i.prototype.handleEvent=function(t){var e="on"+t.type;this[e]&&this[e](t)},i.prototype.getSize=function(){this.size=e(this.element)},i.prototype.css=function(t){var e=this.element.style;for(var i in t){e[u[i]||i]=t[i]}},i.prototype.getPosition=function(){var t=v(this.element),e=this.layout.options,i=e.isOriginLeft,n=e.isOriginTop,o=parseInt(t[i?"left":"right"],10),r=parseInt(t[n?"top":"bottom"],10);o=isNaN(o)?0:o,r=isNaN(r)?0:r;var s=this.layout.size;o-=i?s.paddingLeft:s.paddingRight,r-=n?s.paddingTop:s.paddingBottom,this.position.x=o,this.position.y=r},i.prototype.layoutPosition=function(){var t=this.layout.size,e=this.layout.options,i={};e.isOriginLeft?(i.left=this.position.x+t.paddingLeft+"px",i.right=""):(i.right=this.position.x+t.paddingRight+"px",i.left=""),e.isOriginTop?(i.top=this.position.y+t.paddingTop+"px",i.bottom=""):(i.bottom=this.position.y+t.paddingBottom+"px",i.top=""),this.css(i),this.emitEvent("layout",[this])};var f=a?function(t,e){return"translate3d("+t+"px, "+e+"px, 0)"}:function(t,e){return"translate("+t+"px, "+e+"px)"};i.prototype._transitionTo=function(t,e){this.getPosition();var i=this.position.x,n=this.position.y,o=parseInt(t,10),r=parseInt(e,10),s=o===this.position.x&&r===this.position.y;if(this.setPosition(t,e),!s||this.isTransitioning){var a=t-i,h=e-n,p={},u=this.layout.options;a=u.isOriginLeft?a:-a,h=u.isOriginTop?h:-h,p.transform=f(a,h),this.transition({to:p,onTransitionEnd:{transform:this.layoutPosition},isCleaning:!0})}else this.layoutPosition()},i.prototype.goTo=function(t,e){this.setPosition(t,e),this.layoutPosition()},i.prototype.moveTo=s?i.prototype._transitionTo:i.prototype.goTo,i.prototype.setPosition=function(t,e){this.position.x=parseInt(t,10),this.position.y=parseInt(e,10)},i.prototype._nonTransition=function(t){for(var e in this.css(t.to),t.isCleaning&&this._removeStyles(t.to),t.onTransitionEnd)t.onTransitionEnd[e].call(this)},i.prototype._transition=function(t){if(parseFloat(this.layout.options.transitionDuration)){var e=this._transition;for(var i in t.onTransitionEnd)e.onEnd[i]=t.onTransitionEnd[i];for(i in t.to)e.ingProperties[i]=!0,t.isCleaning&&(e.clean[i]=!0);if(t.from){this.css(t.from);this.element.offsetHeight;null}this.enableTransition(t.to),this.css(t.to),this.isTransitioning=!0}else this._nonTransition(t)};var l=o&&g(o)+",opacity";i.prototype.enableTransition=function(){this.isTransitioning||(this.css({transitionProperty:l,transitionDuration:this.layout.options.transitionDuration}),this.element.addEventListener(h,this,!1))},i.prototype.transition=i.prototype[n?"_transition":"_nonTransition"],i.prototype.onwebkitTransitionEnd=function(t){this.ontransitionend(t)},i.prototype.onotransitionend=function(t){this.ontransitionend(t)};var d={"-webkit-transform":"transform","-moz-transform":"transform","-o-transform":"transform"};i.prototype.ontransitionend=function(t){if(t.target===this.element){var e=this._transition,i=d[t.propertyName]||t.propertyName;if(delete e.ingProperties[i],y(e.ingProperties)&&this.disableTransition(),i in e.clean&&(this.element.style[t.propertyName]="",delete e.clean[i]),i in e.onEnd)e.onEnd[i].call(this),delete e.onEnd[i];this.emitEvent("transitionEnd",[this])}},i.prototype.disableTransition=function(){this.removeTransitionStyles(),this.element.removeEventListener(h,this,!1),this.isTransitioning=!1},i.prototype._removeStyles=function(t){var e={};for(var i in t)e[i]="";this.css(e)};var c={transitionProperty:"",transitionDuration:""};return i.prototype.removeTransitionStyles=function(){this.css(c)},i.prototype.removeElem=function(){this.element.parentNode.removeChild(this.element),this.emitEvent("remove",[this])},i.prototype.remove=function(){if(n&&parseFloat(this.layout.options.transitionDuration)){var t=this;this.on("transitionEnd",function(){return t.removeElem(),!0}),this.hide()}else this.removeElem()},i.prototype.reveal=function(){delete this.isHidden,this.css({display:""});var t=this.layout.options;this.transition({from:t.hiddenStyle,to:t.visibleStyle,isCleaning:!0})},i.prototype.hide=function(){this.isHidden=!0,this.css({display:""});var t=this.layout.options;this.transition({from:t.visibleStyle,to:t.hiddenStyle,isCleaning:!0,onTransitionEnd:{opacity:function(){this.isHidden&&this.css({display:"none"})}}})},i.prototype.destroy=function(){this.css({position:"",left:"",right:"",top:"",bottom:"",transition:"",transform:""})},i}var i=document.defaultView,v=i&&i.getComputedStyle?function(t){return i.getComputedStyle(t,null)}:function(t){return t.currentStyle};"function"==typeof define&&define.amd?define("outlayer/item",["eventEmitter/EventEmitter","get-size/get-size","get-style-property/get-style-property"],e):(t.Outlayer={},t.Outlayer.Item=e(t.EventEmitter,t.getSize,t.getStyleProperty))}(window),function(p){function l(t,e){for(var i in e)t[i]=e[i];return t}function o(t){return"[object Array]"===e.call(t)}function u(t){var e=[];if(o(t))e=t;else if(t&&"number"==typeof t.length)for(var i=0,n=t.length;i<n;i++)e.push(t[i]);else e.push(t);return e}function d(t,e){var i=n(e,t);-1!==i&&e.splice(i,1)}function c(t){return t.replace(/(.)([A-Z])/g,function(t,e,i){return e+"-"+i}).toLowerCase()}function t(t,e,i,o,f,n){function r(t,e){if("string"==typeof t&&(t=m.querySelector(t)),t&&_(t)){this.element=t,this.options=l({},this.options),this.option(e);var i=++a;this.element.outlayerGUID=i,(h[i]=this)._create(),this.options.isInitLayout&&this.layout()}else y&&y.error("Bad "+this.settings.namespace+" element: "+t)}function s(t,e){t.prototype[e]=l({},r.prototype[e])}var a=0,h={};return r.prototype.settings={namespace:"outlayer",item:n},r.prototype.options={containerStyle:{position:"relative"},isInitLayout:!0,isOriginLeft:!0,isOriginTop:!0,isResizeBound:!0,transitionDuration:"0.4s",hiddenStyle:{opacity:0,transform:"scale(0.001)"},visibleStyle:{opacity:1,transform:"scale(1)"}},l(r.prototype,i.prototype),r.prototype.option=function(t){l(this.options,t)},r.prototype._create=function(){this.reloadItems(),this.stamps=[],this.stamp(this.options.stamp),l(this.element.style,this.options.containerStyle),this.options.isResizeBound&&this.bindResize()},r.prototype.reloadItems=function(){this.items=this._itemize(this.element.children)},r.prototype._itemize=function(t){for(var e=this._filterFindItemElements(t),i=this.settings.item,n=[],o=0,r=e.length;o<r;o++){var s=new i(e[o],this);n.push(s)}return n},r.prototype._filterFindItemElements=function(t){t=u(t);for(var e=this.options.itemSelector,i=[],n=0,o=t.length;n<o;n++){var r=t[n];if(_(r))if(e){f(r,e)&&i.push(r);for(var s=r.querySelectorAll(e),a=0,h=s.length;a<h;a++)i.push(s[a])}else i.push(r)}return i},r.prototype.getItemElements=function(){for(var t=[],e=0,i=this.items.length;e<i;e++)t.push(this.items[e].element);return t},r.prototype.layout=function(){this._resetLayout(),this._manageStamps();var t=void 0!==this.options.isLayoutInstant?this.options.isLayoutInstant:!this._isLayoutInited;this.layoutItems(this.items,t),this._isLayoutInited=!0},r.prototype._init=r.prototype.layout,r.prototype._resetLayout=function(){this.getSize()},r.prototype.getSize=function(){this.size=o(this.element)},r.prototype._getMeasurement=function(t,e){var i,n=this.options[t];n?("string"==typeof n?i=this.element.querySelector(n):_(n)&&(i=n),this[t]=i?o(i)[e]:n):this[t]=0},r.prototype.layoutItems=function(t,e){t=this._getItemsForLayout(t),this._layoutItems(t,e),this._postLayout()},r.prototype._getItemsForLayout=function(t){for(var e=[],i=0,n=t.length;i<n;i++){var o=t[i];o.isIgnored||e.push(o)}return e},r.prototype._layoutItems=function(t,e){if(t&&t.length){this._itemsOn(t,"layout",function(){this.emitEvent("layoutComplete",[this,t])});for(var i=[],n=0,o=t.length;n<o;n++){var r=t[n],s=this._getItemLayoutPosition(r);s.item=r,s.isInstant=e,i.push(s)}this._processLayoutQueue(i)}else this.emitEvent("layoutComplete",[this,t])},r.prototype._getItemLayoutPosition=function(){return{x:0,y:0}},r.prototype._processLayoutQueue=function(t){for(var e=0,i=t.length;e<i;e++){var n=t[e];this._positionItem(n.item,n.x,n.y,n.isInstant)}},r.prototype._positionItem=function(t,e,i,n){n?t.goTo(e,i):t.moveTo(e,i)},r.prototype._postLayout=function(){var t=this._getContainerSize();t&&(this._setContainerMeasure(t.width,!0),this._setContainerMeasure(t.height,!1))},r.prototype._getContainerSize=v,r.prototype._setContainerMeasure=function(t,e){if(void 0!==t){var i=this.size;i.isBorderBox&&(t+=e?i.paddingLeft+i.paddingRight+i.borderLeftWidth+i.borderRightWidth:i.paddingBottom+i.paddingTop+i.borderTopWidth+i.borderBottomWidth),t=Math.max(t,0),this.element.style[e?"width":"height"]=t+"px"}},r.prototype._itemsOn=function(t,e,i){function n(){return++o===r&&i.call(s),!0}for(var o=0,r=t.length,s=this,a=0,h=t.length;a<h;a++){t[a].on(e,n)}},r.prototype.ignore=function(t){var e=this.getItem(t);e&&(e.isIgnored=!0)},r.prototype.unignore=function(t){var e=this.getItem(t);e&&delete e.isIgnored},r.prototype.stamp=function(t){if(t=this._find(t)){this.stamps=this.stamps.concat(t);for(var e=0,i=t.length;e<i;e++){var n=t[e];this.ignore(n)}}},r.prototype.unstamp=function(t){if(t=this._find(t))for(var e=0,i=t.length;e<i;e++){var n=t[e];d(n,this.stamps),this.unignore(n)}},r.prototype._find=function(t){return t?("string"==typeof t&&(t=this.element.querySelectorAll(t)),t=u(t)):void 0},r.prototype._manageStamps=function(){if(this.stamps&&this.stamps.length){this._getBoundingRect();for(var t=0,e=this.stamps.length;t<e;t++){var i=this.stamps[t];this._manageStamp(i)}}},r.prototype._getBoundingRect=function(){var t=this.element.getBoundingClientRect(),e=this.size;this._boundingRect={left:t.left+e.paddingLeft+e.borderLeftWidth,top:t.top+e.paddingTop+e.borderTopWidth,right:t.right-(e.paddingRight+e.borderRightWidth),bottom:t.bottom-(e.paddingBottom+e.borderBottomWidth)}},r.prototype._manageStamp=v,r.prototype._getElementOffset=function(t){var e=t.getBoundingClientRect(),i=this._boundingRect,n=o(t);return{left:e.left-i.left-n.marginLeft,top:e.top-i.top-n.marginTop,right:i.right-e.right-n.marginRight,bottom:i.bottom-e.bottom-n.marginBottom}},r.prototype.handleEvent=function(t){var e="on"+t.type;this[e]&&this[e](t)},r.prototype.bindResize=function(){this.isResizeBound||(t.bind(p,"resize",this),this.isResizeBound=!0)},r.prototype.unbindResize=function(){t.unbind(p,"resize",this),this.isResizeBound=!1},r.prototype.onresize=function(){function t(){e.resize(),delete e.resizeTimeout}this.resizeTimeout&&clearTimeout(this.resizeTimeout);var e=this;this.resizeTimeout=setTimeout(t,100)},r.prototype.resize=function(){var t=o(this.element);this.size&&t&&t.innerWidth===this.size.innerWidth||this.layout()},r.prototype.addItems=function(t){var e=this._itemize(t);return e.length&&(this.items=this.items.concat(e)),e},r.prototype.appended=function(t){var e=this.addItems(t);e.length&&(this.layoutItems(e,!0),this.reveal(e))},r.prototype.prepended=function(t){var e=this._itemize(t);if(e.length){var i=this.items.slice(0);this.items=e.concat(i),this._resetLayout(),this._manageStamps(),this.layoutItems(e,!0),this.reveal(e),this.layoutItems(i)}},r.prototype.reveal=function(t){if(t&&t.length)for(var e=0,i=t.length;e<i;e++){t[e].reveal()}},r.prototype.hide=function(t){if(t&&t.length)for(var e=0,i=t.length;e<i;e++){t[e].hide()}},r.prototype.getItem=function(t){for(var e=0,i=this.items.length;e<i;e++){var n=this.items[e];if(n.element===t)return n}},r.prototype.getItems=function(t){if(t&&t.length){for(var e=[],i=0,n=t.length;i<n;i++){var o=t[i],r=this.getItem(o);r&&e.push(r)}return e}},r.prototype.remove=function(t){t=u(t);var e=this.getItems(t);if(e&&e.length){this._itemsOn(e,"remove",function(){this.emitEvent("removeComplete",[this,e])});for(var i=0,n=e.length;i<n;i++){var o=e[i];o.remove(),d(o,this.items)}}},r.prototype.destroy=function(){var t=this.element.style;t.height="",t.position="",t.width="";for(var e=0,i=this.items.length;e<i;e++){this.items[e].destroy()}this.unbindResize(),delete this.element.outlayerGUID,g&&g.removeData(this.element,this.settings.namespace)},r.data=function(t){var e=t&&t.outlayerGUID;return e&&h[e]},r.create=function(p,t){function u(){r.apply(this,arguments)}return l(u.prototype,r.prototype),s(u,"options"),s(u,"settings"),l(u.prototype.options,t),u.prototype.settings.namespace=p,u.data=r.data,u.Item=function(){n.apply(this,arguments)},u.Item.prototype=new n,u.prototype.settings.item=u.Item,e(function(){for(var t=c(p),e=m.querySelectorAll(".js-"+t),i="data-"+t+"-options",n=0,o=e.length;n<o;n++){var r,s=e[n],a=s.getAttribute(i);try{r=a&&JSON.parse(a)}catch(f){y&&y.error("Error parsing "+i+" on "+s.nodeName.toLowerCase()+(s.id?"#"+s.id:"")+": "+f);continue}var h=new u(s,r);g&&g.data(s,p,h)}}),g&&g.bridget&&g.bridget(p,u),u},r.Item=n,r}var m=p.document,y=p.console,g=p.jQuery,v=function(){},e=Object.prototype.toString,_="object"==typeof HTMLElement?function(t){return t instanceof HTMLElement}:function(t){return t&&"object"==typeof t&&1===t.nodeType&&"string"==typeof t.nodeName},n=Array.prototype.indexOf?function(t,e){return t.indexOf(e)}:function(t,e){for(var i=0,n=t.length;i<n;i++)if(t[i]===e)return i;return-1};"function"==typeof define&&define.amd?define("outlayer/outlayer",["eventie/eventie","doc-ready/doc-ready","eventEmitter/EventEmitter","get-size/get-size","matches-selector/matches-selector","./item"],t):p.Outlayer=t(p.eventie,p.docReady,p.EventEmitter,p.getSize,p.matchesSelector,p.Outlayer.Item)}(window),function(t){function e(t,p){var e=t.create("masonry");return e.prototype._resetLayout=function(){this.getSize(),this._getMeasurement("columnWidth","outerWidth"),this._getMeasurement("gutter","outerWidth"),this.measureColumns();var t=this.cols;for(this.colYs=[];t--;)this.colYs.push(0);this.maxY=0},e.prototype.measureColumns=function(){if(this.getContainerWidth(),!this.columnWidth){var t=this.items[0],e=t&&t.element;this.columnWidth=e&&p(e).outerWidth||this.containerWidth}this.columnWidth+=this.gutter,this.cols=Math.floor((this.containerWidth+this.gutter)/this.columnWidth),this.cols=Math.max(this.cols,1)},e.prototype.getContainerWidth=function(){var t=this.options.isFitWidth?this.element.parentNode:this.element,e=p(t);this.containerWidth=e&&e.innerWidth},e.prototype._getItemLayoutPosition=function(t){t.getSize();var e=t.size.outerWidth%this.columnWidth,i=Math[e&&e<1?"round":"ceil"](t.size.outerWidth/this.columnWidth);i=Math.min(i,this.cols);for(var n=this._getColGroup(i),o=Math.min.apply(Math,n),r=u(n,o),s={x:this.columnWidth*r,y:o},a=o+t.size.outerHeight,h=this.cols+1-n.length,p=0;p<h;p++)this.colYs[r+p]=a;return s},e.prototype._getColGroup=function(t){if(t<2)return this.colYs;for(var e=[],i=this.cols+1-t,n=0;n<i;n++){var o=this.colYs.slice(n,n+t);e[n]=Math.max.apply(Math,o)}return e},e.prototype._manageStamp=function(t){var e=p(t),i=this._getElementOffset(t),n=this.options.isOriginLeft?i.left:i.right,o=n+e.outerWidth,r=Math.floor(n/this.columnWidth);r=Math.max(0,r);var s=Math.floor(o/this.columnWidth);s=Math.min(this.cols-1,s);for(var a=(this.options.isOriginTop?i.top:i.bottom)+e.outerHeight,h=r;h<=s;h++)this.colYs[h]=Math.max(a,this.colYs[h])},e.prototype._getContainerSize=function(){this.maxY=Math.max.apply(Math,this.colYs);var t={height:this.maxY};return this.options.isFitWidth&&(t.width=this._getContainerFitWidth()),t},e.prototype._getContainerFitWidth=function(){for(var t=0,e=this.cols;--e&&0===this.colYs[e];)t++;return(this.cols-t)*this.columnWidth-this.gutter},e.prototype.resize=function(){var t=this.containerWidth;this.getContainerWidth(),t!==this.containerWidth&&this.layout()},e}var u=Array.prototype.indexOf?function(t,e){return t.indexOf(e)}:function(t,e){for(var i=0,n=t.length;i<n;i++){if(t[i]===e)return i}return-1};"function"==typeof define&&define.amd?define(["outlayer/outlayer","get-size/get-size"],e):t.Masonry=e(t.Outlayer,t.getSize)}(window);