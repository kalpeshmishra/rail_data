!function(r){r.color={},r.color.make=function(t,i,e,o){var n={};return n.r=t||0,n.g=i||0,n.b=e||0,n.a=null!=o?o:1,n.add=function(t,i){for(var e=0;e<t.length;++e)n[t.charAt(e)]+=i;return n.normalize()},n.scale=function(t,i){for(var e=0;e<t.length;++e)n[t.charAt(e)]*=i;return n.normalize()},n.toString=function(){return 1<=n.a?"rgb("+[n.r,n.g,n.b].join(",")+")":"rgba("+[n.r,n.g,n.b,n.a].join(",")+")"},n.normalize=function(){function t(t,i,e){return i<t?t:e<i?e:i}return n.r=t(0,parseInt(n.r),255),n.g=t(0,parseInt(n.g),255),n.b=t(0,parseInt(n.b),255),n.a=t(0,n.a,1),n},n.clone=function(){return r.color.make(n.r,n.b,n.g,n.a)},n.normalize()},r.color.extract=function(t,i){var e;do{if(""!=(e=t.css(i).toLowerCase())&&"transparent"!=e)break;t=t.parent()}while(!r.nodeName(t.get(0),"body"));return"rgba(0, 0, 0, 0)"==e&&(e="transparent"),r.color.parse(e)},r.color.parse=function(t){var i,e=r.color.make;if(i=/rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/.exec(t))return e(parseInt(i[1],10),parseInt(i[2],10),parseInt(i[3],10));if(i=/rgba\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]+(?:\.[0-9]+)?)\s*\)/.exec(t))return e(parseInt(i[1],10),parseInt(i[2],10),parseInt(i[3],10),parseFloat(i[4]));if(i=/rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)/.exec(t))return e(2.55*parseFloat(i[1]),2.55*parseFloat(i[2]),2.55*parseFloat(i[3]));if(i=/rgba\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\s*\)/.exec(t))return e(2.55*parseFloat(i[1]),2.55*parseFloat(i[2]),2.55*parseFloat(i[3]),parseFloat(i[4]));if(i=/#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(t))return e(parseInt(i[1],16),parseInt(i[2],16),parseInt(i[3],16));if(i=/#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/.exec(t))return e(parseInt(i[1]+i[1],16),parseInt(i[2]+i[2],16),parseInt(i[3]+i[3],16));var o=r.trim(t).toLowerCase();return"transparent"==o?e(255,255,255,0):e((i=n[o]||[0,0,0])[0],i[1],i[2])};var n={aqua:[0,255,255],azure:[240,255,255],beige:[245,245,220],black:[0,0,0],blue:[0,0,255],brown:[165,42,42],cyan:[0,255,255],darkblue:[0,0,139],darkcyan:[0,139,139],darkgrey:[169,169,169],darkgreen:[0,100,0],darkkhaki:[189,183,107],darkmagenta:[139,0,139],darkolivegreen:[85,107,47],darkorange:[255,140,0],darkorchid:[153,50,204],darkred:[139,0,0],darksalmon:[233,150,122],darkviolet:[148,0,211],fuchsia:[255,0,255],gold:[255,215,0],green:[0,128,0],indigo:[75,0,130],khaki:[240,230,140],lightblue:[173,216,230],lightcyan:[224,255,255],lightgreen:[144,238,144],lightgrey:[211,211,211],lightpink:[255,182,193],lightyellow:[255,255,224],lime:[0,255,0],magenta:[255,0,255],maroon:[128,0,0],navy:[0,0,128],olive:[128,128,0],orange:[255,165,0],pink:[255,192,203],purple:[128,0,128],violet:[128,0,128],red:[255,0,0],silver:[192,192,192],white:[255,255,255],yellow:[255,255,0]}}(jQuery),function(xt){function gt(t,i){var e=i.children("."+t)[0];if(null==e&&((e=document.createElement("canvas")).className=t,xt(e).css({direction:"ltr",position:"absolute",left:0,top:0}).appendTo(i),!e.getContext)){if(!window.G_vmlCanvasManager)throw new Error("Canvas is not available. If you're using IE with a fall-back such as Excanvas, then there's either a mistake in your conditional include, or the page has no DOCTYPE and is rendering in Quirks Mode.");e=window.G_vmlCanvasManager.initElement(e)}this.element=e;var o=this.context=e.getContext("2d"),n=window.devicePixelRatio||1,r=o.webkitBackingStorePixelRatio||o.mozBackingStorePixelRatio||o.msBackingStorePixelRatio||o.oBackingStorePixelRatio||o.backingStorePixelRatio||1;this.pixelRatio=n/r,this.resize(i.width(),i.height()),this.textContainer=null,this.text={},this._textCache={}}function o(x,t,i,o){function M(t,i){i=[dt].concat(i);for(var e=0;e<t.length;++e)t[e].apply(this,i)}function e(){for(var t={Canvas:gt},i=0;i<o.length;++i){var e=o[i];e.init(dt,t),e.options&&xt.extend(!0,it,e.options)}}function n(t){xt.extend(!0,it,t),t&&t.colors&&(it.colors=t.colors),null==it.xaxis.color&&(it.xaxis.color=xt.color.parse(it.grid.color).scale("a",.22).toString()),null==it.yaxis.color&&(it.yaxis.color=xt.color.parse(it.grid.color).scale("a",.22).toString()),null==it.xaxis.tickColor&&(it.xaxis.tickColor=it.grid.tickColor||it.xaxis.color),null==it.yaxis.tickColor&&(it.yaxis.tickColor=it.grid.tickColor||it.yaxis.color),null==it.grid.borderColor&&(it.grid.borderColor=it.grid.color),null==it.grid.tickColor&&(it.grid.tickColor=xt.color.parse(it.grid.color).scale("a",.22).toString());var i,e,o,n={style:x.css("font-style"),size:Math.round(.8*(+x.css("font-size").replace("px","")||13)),variant:x.css("font-variant"),weight:x.css("font-weight"),family:x.css("font-family")};for(n.lineHeight=1.15*n.size,o=it.xaxes.length||1,i=0;i<o;++i)(e=it.xaxes[i])&&!e.tickColor&&(e.tickColor=e.color),e=xt.extend(!0,{},it.xaxis,e),(it.xaxes[i]=e).font&&(e.font=xt.extend({},n,e.font),e.font.color||(e.font.color=e.color));for(o=it.yaxes.length||1,i=0;i<o;++i)(e=it.yaxes[i])&&!e.tickColor&&(e.tickColor=e.color),e=xt.extend(!0,{},it.yaxis,e),(it.yaxes[i]=e).font&&(e.font=xt.extend({},n,e.font),e.font.color||(e.font.color=e.color));for(it.xaxis.noTicks&&null==it.xaxis.ticks&&(it.xaxis.ticks=it.xaxis.noTicks),it.yaxis.noTicks&&null==it.yaxis.ticks&&(it.yaxis.ticks=it.yaxis.noTicks),it.x2axis&&(it.xaxes[1]=xt.extend(!0,{},it.xaxis,it.x2axis),it.xaxes[1].position="top"),it.y2axis&&(it.yaxes[1]=xt.extend(!0,{},it.yaxis,it.y2axis),it.yaxes[1].position="right"),it.grid.coloredAreas&&(it.grid.markings=it.grid.coloredAreas),it.grid.coloredAreasColor&&(it.grid.markingsColor=it.grid.coloredAreasColor),it.lines&&xt.extend(!0,it.series.lines,it.lines),it.points&&xt.extend(!0,it.series.points,it.points),it.bars&&xt.extend(!0,it.series.bars,it.bars),null!=it.shadowSize&&(it.series.shadowSize=it.shadowSize),null!=it.highlightColor&&(it.series.highlightColor=it.highlightColor),i=0;i<it.xaxes.length;++i)p(lt,i+1).options=it.xaxes[i];for(i=0;i<it.yaxes.length;++i)p(st,i+1).options=it.yaxes[i];for(var r in ut)it.hooks[r]&&it.hooks[r].length&&(ut[r]=ut[r].concat(it.hooks[r]));M(ut.processOptions,[it])}function r(t){tt=a(t),s(),c()}function a(t){for(var i=[],e=0;e<t.length;++e){var o=xt.extend(!0,{},it.series);null!=t[e].data?(o.data=t[e].data,delete t[e].data,xt.extend(!0,o,t[e]),t[e].data=o.data):o.data=t[e],i.push(o)}return i}function d(t,i){var e=t[i+"axis"];return"object"==typeof e&&(e=e.n),"number"!=typeof e&&(e=1),e}function C(){return xt.grep(lt.concat(st),function(t){return t})}function f(t){var i,e,o={};for(i=0;i<lt.length;++i)(e=lt[i])&&e.used&&(o["x"+e.n]=e.c2p(t.left));for(i=0;i<st.length;++i)(e=st[i])&&e.used&&(o["y"+e.n]=e.c2p(t.top));return o.x1!==undefined&&(o.x=o.x1),o.y1!==undefined&&(o.y=o.y1),o}function l(t){var i,e,o,n={};for(i=0;i<lt.length;++i)if((e=lt[i])&&e.used&&(null==t[o="x"+e.n]&&1==e.n&&(o="x"),null!=t[o])){n.left=e.p2c(t[o]);break}for(i=0;i<st.length;++i)if((e=st[i])&&e.used&&(null==t[o="y"+e.n]&&1==e.n&&(o="y"),null!=t[o])){n.top=e.p2c(t[o]);break}return n}function p(t,i){return t[i-1]||(t[i-1]={n:i,direction:t==lt?"x":"y",options:xt.extend(!0,{},t==lt?it.xaxis:it.yaxis)}),t[i-1]}function s(){var t,i=tt.length,e=-1;for(t=0;t<tt.length;++t){var o=tt[t].color;null!=o&&(i--,"number"==typeof o&&e<o&&(e=o))}i<=e&&(i=e+1);var n,r=[],a=it.colors,l=a.length,s=0;for(t=0;t<i;t++)n=xt.color.parse(a[t%l]||"#666"),t%l==0&&t&&(s=0<=s?s<.5?-s-.2:0:-s),r[t]=n.scale("rgb",1+s);var c,f=0;for(t=0;t<tt.length;++t){if(null==(c=tt[t]).color?(c.color=r[f].toString(),++f):"number"==typeof c.color&&(c.color=r[c.color].toString()),null==c.lines.show){var h,u=!0;for(h in c)if(c[h]&&c[h].show){u=!1;break}u&&(c.lines.show=!0)}null==c.lines.zero&&(c.lines.zero=!!c.lines.fill),c.xaxis=p(lt,d(c,"x")),c.yaxis=p(st,d(c,"y"))}}function c(){function t(t,i,e){i<t.datamin&&i!=-m&&(t.datamin=i),e>t.datamax&&e!=m&&(t.datamax=e)}var i,e,o,n,r,a,l,s,c,f,h,u,d=Number.POSITIVE_INFINITY,p=Number.NEGATIVE_INFINITY,m=Number.MAX_VALUE;for(xt.each(C(),function(t,i){i.datamin=d,i.datamax=p,i.used=!1}),i=0;i<tt.length;++i)(r=tt[i]).datapoints={points:[]},M(ut.processRawData,[r,r.data,r.datapoints]);for(i=0;i<tt.length;++i){if(h=(r=tt[i]).data,!(u=r.datapoints.format)){if((u=[]).push({x:!0,number:!0,required:!0}),u.push({y:!0,number:!0,required:!0}),r.bars.show||r.lines.show&&r.lines.fill){var x=!!(r.bars.show&&r.bars.zero||r.lines.show&&r.lines.zero);u.push({y:!0,number:!0,required:!1,defaultValue:0,autoscale:x}),r.bars.horizontal&&(delete u[u.length-1].y,u[u.length-1].x=!0)}r.datapoints.format=u}if(null==r.datapoints.pointsize){r.datapoints.pointsize=u.length,l=r.datapoints.pointsize,a=r.datapoints.points;var g=r.lines.show&&r.lines.steps;for(r.xaxis.used=r.yaxis.used=!0,e=o=0;e<h.length;++e,o+=l){var b=null==(f=h[e]);if(!b)for(n=0;n<l;++n)s=f[n],(c=u[n])&&(c.number&&null!=s&&(s=+s,isNaN(s)?s=null:s==Infinity?s=m:s==-Infinity&&(s=-m)),null==s&&(c.required&&(b=!0),null!=c.defaultValue&&(s=c.defaultValue))),a[o+n]=s;if(b)for(n=0;n<l;++n)null!=(s=a[o+n])&&(c=u[n]).autoscale&&(c.x&&t(r.xaxis,s,s),c.y&&t(r.yaxis,s,s)),a[o+n]=null;else if(g&&0<o&&null!=a[o-l]&&a[o-l]!=a[o]&&a[o-l+1]!=a[o+1]){for(n=0;n<l;++n)a[o+l+n]=a[o+n];a[o+1]=a[o-l+1],o+=l}}}}for(i=0;i<tt.length;++i)r=tt[i],M(ut.processDatapoints,[r,r.datapoints]);for(i=0;i<tt.length;++i){a=(r=tt[i]).datapoints.points,l=r.datapoints.pointsize,u=r.datapoints.format;var v=d,k=d,y=p,w=p;for(e=0;e<a.length;e+=l)if(null!=a[e])for(n=0;n<l;++n)s=a[e+n],(c=u[n])&&!1!==c.autoscale&&s!=m&&s!=-m&&(c.x&&(s<v&&(v=s),y<s&&(y=s)),c.y&&(s<k&&(k=s),w<s&&(w=s)));if(r.bars.show){var T;switch(r.bars.align){case"left":T=0;break;case"right":T=-r.bars.barWidth;break;case"center":T=-r.bars.barWidth/2;break;default:throw new Error("Invalid bar alignment: "+r.bars.align)}r.bars.horizontal?(k+=T,w+=T+r.bars.barWidth):(v+=T,y+=T+r.bars.barWidth)}t(r.xaxis,v,y),t(r.yaxis,k,w)}xt.each(C(),function(t,i){i.datamin==d&&(i.datamin=null),i.datamax==p&&(i.datamax=null)})}function h(){x.css("padding",0).children(":not(.flot-base,.flot-overlay)").remove(),"static"==x.css("position")&&x.css("position","relative"),et=new gt("flot-base",x),ot=new gt("flot-overlay",x),rt=et.context,at=ot.context,nt=xt(ot.element).unbind();var t=x.data("plot");t&&(t.shutdown(),ot.clear()),x.data("plot",dt)}function u(){it.grid.hoverable&&(nt.mousemove(G),nt.bind("mouseleave",_)),it.grid.clickable&&nt.click(V),M(ut.bindEvents,[nt])}function m(){mt&&clearTimeout(mt),nt.unbind("mousemove",G),nt.unbind("mouseleave",_),nt.unbind("click",V),M(ut.shutdown,[nt])}function g(t){function i(t){return t}var e,o,n=t.options.transform||i,r=t.options.inverseTransform;"x"==t.direction?(e=t.scale=ft/Math.abs(n(t.max)-n(t.min)),o=Math.min(n(t.max),n(t.min))):(e=-(e=t.scale=ht/Math.abs(n(t.max)-n(t.min))),o=Math.max(n(t.max),n(t.min))),t.p2c=n==i?function(t){return(t-o)*e}:function(t){return(n(t)-o)*e},t.c2p=r?function(t){return r(o+t/e)}:function(t){return o+t/e}}function b(t){var i=t.options,e=t.ticks||[],o=i.labelWidth||0,n=i.labelHeight||0,r=o||"x"==t.direction?Math.floor(et.width/(e.length||1)):null;legacyStyles=t.direction+"Axis "+t.direction+t.n+"Axis",layer="flot-"+t.direction+"-axis flot-"+t.direction+t.n+"-axis "+legacyStyles,font=i.font||"flot-tick-label tickLabel";for(var a=0;a<e.length;++a){var l=e[a];if(l.label){var s=et.getTextInfo(layer,l.label,font,null,r);o=Math.max(o,s.width),n=Math.max(n,s.height)}}t.labelWidth=i.labelWidth||o,t.labelHeight=i.labelHeight||n}function v(t){var i,e=t.labelWidth,o=t.labelHeight,n=t.options.position,r=t.options.tickLength,a=it.grid.axisMargin,l=it.grid.labelMargin,s="x"==t.direction?lt:st,c=xt.grep(s,function(t){return t&&t.options.position==n&&t.reserveSpace});if(xt.inArray(t,c)==c.length-1&&(a=0),null==r){var f=xt.grep(s,function(t){return t&&t.reserveSpace});r=(i=0==xt.inArray(t,f))?"full":5}isNaN(+r)||(l+=+r),"x"==t.direction?(o+=l,"bottom"==n?(ct.bottom+=o+a,t.box={top:et.height-ct.bottom,height:o}):(t.box={top:ct.top+a,height:o},ct.top+=o+a)):(e+=l,"left"==n?(t.box={left:ct.left+a,width:e},ct.left+=e+a):(ct.right+=e+a,t.box={left:et.width-ct.right,width:e})),t.position=n,t.tickLength=r,t.box.padding=l,t.innermost=i}function k(t){"x"==t.direction?(t.box.left=ct.left-t.labelWidth/2,t.box.width=et.width-ct.left-ct.right+t.labelWidth):(t.box.top=ct.top-t.labelHeight/2,t.box.height=et.height-ct.bottom-ct.top+t.labelHeight)}function y(){var t,i=it.grid.minBorderMargin,o={x:0,y:0};if(null==i)for(t=i=0;t<tt.length;++t)i=Math.max(i,2*(tt[t].points.radius+tt[t].points.lineWidth/2));o.x=o.y=Math.ceil(i),xt.each(C(),function(t,i){var e=i.direction;i.reserveSpace&&(o[e]=Math.ceil(Math.max(o[e],("x"==e?i.labelWidth:i.labelHeight)/2)))}),ct.left=Math.max(o.x,ct.left),ct.right=Math.max(o.x,ct.right),ct.top=Math.max(o.y,ct.top),ct.bottom=Math.max(o.y,ct.bottom)}function w(){var t,i=C(),e=it.grid.show;for(var o in ct){var n=it.grid.margin||0;ct[o]="number"==typeof n?n:n[o]||0}for(var o in M(ut.processOffset,[ct]),ct)"object"==typeof it.grid.borderWidth?ct[o]+=e?it.grid.borderWidth[o]:0:ct[o]+=e?it.grid.borderWidth:0;if(xt.each(i,function(t,i){i.show=i.options.show,null==i.show&&(i.show=i.used),i.reserveSpace=i.show||i.options.reserveSpace,T(i)}),e){var r=xt.grep(i,function(t){return t.reserveSpace});for(xt.each(r,function(t,i){S(i),W(i),z(i,i.ticks),b(i)}),t=r.length-1;0<=t;--t)v(r[t]);y(),xt.each(r,function(t,i){k(i)})}ft=et.width-ct.left-ct.right,ht=et.height-ct.bottom-ct.top,xt.each(i,function(t,i){g(i)}),e&&N(),B()}function T(t){var i=t.options,e=+(null!=i.min?i.min:t.datamin),o=+(null!=i.max?i.max:t.datamax),n=o-e;if(0==n){var r=0==o?1:.01;null==i.min&&(e-=r),null!=i.max&&null==i.min||(o+=r)}else{var a=i.autoscaleMargin;null!=a&&(null==i.min&&(e-=n*a)<0&&null!=t.datamin&&0<=t.datamin&&(e=0),null==i.max&&0<(o+=n*a)&&null!=t.datamax&&t.datamax<=0&&(o=0))}t.min=e,t.max=o}function S(t){var i,e=t.options;i="number"==typeof e.ticks&&0<e.ticks?e.ticks:.3*Math.sqrt("x"==t.direction?et.width:et.height);var o=(t.max-t.min)/i,n=-Math.floor(Math.log(o)/Math.LN10),r=e.tickDecimals;null!=r&&r<n&&(n=r);var a,l=Math.pow(10,-n),s=o/l;if(s<1.5?a=1:s<3?(a=2,2.25<s&&(null==r||n+1<=r)&&(a=2.5,++n)):a=s<7.5?5:10,a*=l,null!=e.minTickSize&&a<e.minTickSize&&(a=e.minTickSize),t.delta=o,t.tickDecimals=Math.max(0,null!=r?r:n),t.tickSize=e.tickSize||a,"time"==e.mode&&!t.tickGenerator)throw new Error("Time mode requires the flot.time plugin.");if(t.tickGenerator||(t.tickGenerator=function(t){for(var i,e=[],o=bt(t.min,t.tickSize),n=0,r=Number.NaN;i=r,r=o+n*t.tickSize,e.push(r),++n,r<t.max&&r!=i;);return e},t.tickFormatter=function(t,i){var e=i.tickDecimals?Math.pow(10,i.tickDecimals):1,o=""+Math.round(t*e)/e;if(null!=i.tickDecimals){var n=o.indexOf("."),r=-1==n?0:o.length-n-1;if(r<i.tickDecimals)return(r?o:o+".")+(""+e).substr(1,i.tickDecimals-r)}return o}),xt.isFunction(e.tickFormatter)&&(t.tickFormatter=function(t,i){return""+e.tickFormatter(t,i)}),null!=e.alignTicksWithAxis){var c=("x"==t.direction?lt:st)[e.alignTicksWithAxis-1];if(c&&c.used&&c!=t){var f=t.tickGenerator(t);if(0<f.length&&(null==e.min&&(t.min=Math.min(t.min,f[0])),null==e.max&&1<f.length&&(t.max=Math.max(t.max,f[f.length-1]))),t.tickGenerator=function(t){var i,e,o=[];for(e=0;e<c.ticks.length;++e)i=(c.ticks[e].v-c.min)/(c.max-c.min),i=t.min+i*(t.max-t.min),o.push(i);return o},!t.mode&&null==e.tickDecimals){var h=Math.max(0,1-Math.floor(Math.log(t.delta)/Math.LN10)),u=t.tickGenerator(t);1<u.length&&/\..*0$/.test((u[1]-u[0]).toFixed(h))||(t.tickDecimals=h)}}}}function W(t){var i,e,o=t.options.ticks,n=[];for(null==o||"number"==typeof o&&0<o?n=t.tickGenerator(t):o&&(n=xt.isFunction(o)?o(t):o),t.ticks=[],i=0;i<n.length;++i){var r=null,a=n[i];"object"==typeof a?(e=+a[0],1<a.length&&(r=a[1])):e=+a,null==r&&(r=t.tickFormatter(e,t)),isNaN(e)||t.ticks.push({v:e,label:r})}}function z(t,i){t.options.autoscaleMargin&&0<i.length&&(null==t.options.min&&(t.min=Math.min(t.min,i[0].v)),null==t.options.max&&1<i.length&&(t.max=Math.max(t.max,i[i.length-1].v)))}function I(){et.clear(),M(ut.drawBackground,[rt]);var t=it.grid;t.show&&t.backgroundColor&&P(),t.show&&!t.aboveData&&F();for(var i=0;i<tt.length;++i)M(ut.drawSeries,[rt,tt[i]]),D(tt[i]);M(ut.draw,[rt]),t.show&&t.aboveData&&F(),et.render(),Y()}function A(t,i){for(var e,o,n,r,a=C(),l=0;l<a.length;++l)if((e=a[l]).direction==i&&(t[r=i+e.n+"axis"]||1!=e.n||(r=i+"axis"),t[r])){o=t[r].from,n=t[r].to;break}if(t[r]||(e="x"==i?lt[0]:st[0],o=t[i+"1"],n=t[i+"2"]),null!=o&&null!=n&&n<o){var s=o;o=n,n=s}return{from:o,to:n,axis:e}}function P(){rt.save(),rt.translate(ct.left,ct.top),rt.fillStyle=Z(it.grid.backgroundColor,ht,0,"rgba(255, 255, 255, 0)"),rt.fillRect(0,0,ft,ht),rt.restore()}function F(){var t,i,e,o;rt.save(),rt.translate(ct.left,ct.top);var n=it.grid.markings;if(n)for(xt.isFunction(n)&&((i=dt.getAxes()).xmin=i.xaxis.min,i.xmax=i.xaxis.max,i.ymin=i.yaxis.min,i.ymax=i.yaxis.max,n=n(i)),t=0;t<n.length;++t){var r=n[t],a=A(r,"x"),l=A(r,"y");null==a.from&&(a.from=a.axis.min),null==a.to&&(a.to=a.axis.max),null==l.from&&(l.from=l.axis.min),null==l.to&&(l.to=l.axis.max),a.to<a.axis.min||a.from>a.axis.max||l.to<l.axis.min||l.from>l.axis.max||(a.from=Math.max(a.from,a.axis.min),a.to=Math.min(a.to,a.axis.max),l.from=Math.max(l.from,l.axis.min),l.to=Math.min(l.to,l.axis.max),a.from==a.to&&l.from==l.to||(a.from=a.axis.p2c(a.from),a.to=a.axis.p2c(a.to),l.from=l.axis.p2c(l.from),l.to=l.axis.p2c(l.to),a.from==a.to||l.from==l.to?(rt.beginPath(),rt.strokeStyle=r.color||it.grid.markingsColor,rt.lineWidth=r.lineWidth||it.grid.markingsLineWidth,rt.moveTo(a.from,l.from),rt.lineTo(a.to,l.to),rt.stroke()):(rt.fillStyle=r.color||it.grid.markingsColor,rt.fillRect(a.from,l.to,a.to-a.from,l.from-l.to))))}i=C(),e=it.grid.borderWidth;for(var s=0;s<i.length;++s){var c,f,h,u,d=i[s],p=d.box,m=d.tickLength;if(d.show&&0!=d.ticks.length){for(rt.lineWidth=1,"x"==d.direction?(c=0,f="full"==m?"top"==d.position?0:ht:p.top-ct.top+("top"==d.position?p.height:0)):(f=0,c="full"==m?"left"==d.position?0:ft:p.left-ct.left+("left"==d.position?p.width:0)),d.innermost||(rt.strokeStyle=d.options.color,rt.beginPath(),h=u=0,"x"==d.direction?h=ft+1:u=ht+1,1==rt.lineWidth&&("x"==d.direction?f=Math.floor(f)+.5:c=Math.floor(c)+.5),rt.moveTo(c,f),rt.lineTo(c+h,f+u),rt.stroke()),rt.strokeStyle=d.options.tickColor,rt.beginPath(),t=0;t<d.ticks.length;++t){var x=d.ticks[t].v;h=u=0,isNaN(x)||x<d.min||x>d.max||"full"==m&&("object"==typeof e&&0<e[d.position]||0<e)&&(x==d.min||x==d.max)||("x"==d.direction?(c=d.p2c(x),u="full"==m?-ht:m,"top"==d.position&&(u=-u)):(f=d.p2c(x),h="full"==m?-ft:m,"left"==d.position&&(h=-h)),1==rt.lineWidth&&("x"==d.direction?c=Math.floor(c)+.5:f=Math.floor(f)+.5),rt.moveTo(c,f),rt.lineTo(c+h,f+u))}rt.stroke()}}e&&(o=it.grid.borderColor,"object"==typeof e||"object"==typeof o?("object"!=typeof e&&(e={top:e,right:e,bottom:e,left:e}),"object"!=typeof o&&(o={top:o,right:o,bottom:o,left:o}),0<e.top&&(rt.strokeStyle=o.top,rt.lineWidth=e.top,rt.beginPath(),rt.moveTo(0-e.left,0-e.top/2),rt.lineTo(ft,0-e.top/2),rt.stroke()),0<e.right&&(rt.strokeStyle=o.right,rt.lineWidth=e.right,rt.beginPath(),rt.moveTo(ft+e.right/2,0-e.top),rt.lineTo(ft+e.right/2,ht),rt.stroke()),0<e.bottom&&(rt.strokeStyle=o.bottom,rt.lineWidth=e.bottom,rt.beginPath(),rt.moveTo(ft+e.right,ht+e.bottom/2),rt.lineTo(0,ht+e.bottom/2),rt.stroke()),0<e.left&&(rt.strokeStyle=o.left,rt.lineWidth=e.left,rt.beginPath(),rt.moveTo(0-e.left/2,ht+e.bottom),rt.lineTo(0-e.left/2,0),rt.stroke())):(rt.lineWidth=e,rt.strokeStyle=it.grid.borderColor,rt.strokeRect(-e/2,-e/2,ft+e,ht+e))),rt.restore()}function N(){xt.each(C(),function(t,i){if(i.show&&0!=i.ticks.length){var e,o,n,r,a,l=i.box,s=i.direction+"Axis "+i.direction+i.n+"Axis",c="flot-"+i.direction+"-axis flot-"+i.direction+i.n+"-axis "+s,f=i.options.font||"flot-tick-label tickLabel";et.removeText(c);for(var h=0;h<i.ticks.length;++h)!(e=i.ticks[h]).label||e.v<i.min||e.v>i.max||("x"==i.direction?(r="center",o=ct.left+i.p2c(e.v),"bottom"==i.position?n=l.top+l.padding:(n=l.top+l.height-l.padding,a="bottom")):(a="middle",n=ct.top+i.p2c(e.v),"left"==i.position?(o=l.left+l.width-l.padding,r="right"):o=l.left+l.padding),et.addText(c,o,n,e.label,f,null,null,r,a))}})}function D(t){t.lines.show&&L(t),t.bars.show&&R(t),t.points.show&&O(t)}function L(t){function i(t,i,e,o,n){var r=t.points,a=t.pointsize,l=null,s=null;rt.beginPath();for(var c=a;c<r.length;c+=a){var f=r[c-a],h=r[c-a+1],u=r[c],d=r[c+1];if(null!=f&&null!=u){if(h<=d&&h<n.min){if(d<n.min)continue;f=(n.min-h)/(d-h)*(u-f)+f,h=n.min}else if(d<=h&&d<n.min){if(h<n.min)continue;u=(n.min-h)/(d-h)*(u-f)+f,d=n.min}if(d<=h&&h>n.max){if(d>n.max)continue;f=(n.max-h)/(d-h)*(u-f)+f,h=n.max}else if(h<=d&&d>n.max){if(h>n.max)continue;u=(n.max-h)/(d-h)*(u-f)+f,d=n.max}if(f<=u&&f<o.min){if(u<o.min)continue;h=(o.min-f)/(u-f)*(d-h)+h,f=o.min}else if(u<=f&&u<o.min){if(f<o.min)continue;d=(o.min-f)/(u-f)*(d-h)+h,u=o.min}if(u<=f&&f>o.max){if(u>o.max)continue;h=(o.max-f)/(u-f)*(d-h)+h,f=o.max}else if(f<=u&&u>o.max){if(f>o.max)continue;d=(o.max-f)/(u-f)*(d-h)+h,u=o.max}f==l&&h==s||rt.moveTo(o.p2c(f)+i,n.p2c(h)+e),l=u,s=d,rt.lineTo(o.p2c(u)+i,n.p2c(d)+e)}}rt.stroke()}function e(t,i,e){for(var o=t.points,n=t.pointsize,r=Math.min(Math.max(0,e.min),e.max),a=0,l=!1,s=1,c=0,f=0;!(0<n&&a>o.length+n);){var h=o[(a+=n)-n],u=o[a-n+s],d=o[a],p=o[a+s];if(l){if(0<n&&null!=h&&null==d){f=a,n=-n,s=2;continue}if(n<0&&a==c+n){rt.fill(),l=!1,s=1,a=c=f+(n=-n);continue}}if(null!=h&&null!=d){if(h<=d&&h<i.min){if(d<i.min)continue;u=(i.min-h)/(d-h)*(p-u)+u,h=i.min}else if(d<=h&&d<i.min){if(h<i.min)continue;p=(i.min-h)/(d-h)*(p-u)+u,d=i.min}if(d<=h&&h>i.max){if(d>i.max)continue;u=(i.max-h)/(d-h)*(p-u)+u,h=i.max}else if(h<=d&&d>i.max){if(h>i.max)continue;p=(i.max-h)/(d-h)*(p-u)+u,d=i.max}if(l||(rt.beginPath(),rt.moveTo(i.p2c(h),e.p2c(r)),l=!0),u>=e.max&&p>=e.max)rt.lineTo(i.p2c(h),e.p2c(e.max)),rt.lineTo(i.p2c(d),e.p2c(e.max));else if(u<=e.min&&p<=e.min)rt.lineTo(i.p2c(h),e.p2c(e.min)),rt.lineTo(i.p2c(d),e.p2c(e.min));else{var m=h,x=d;u<=p&&u<e.min&&p>=e.min?(h=(e.min-u)/(p-u)*(d-h)+h,u=e.min):p<=u&&p<e.min&&u>=e.min&&(d=(e.min-u)/(p-u)*(d-h)+h,p=e.min),p<=u&&u>e.max&&p<=e.max?(h=(e.max-u)/(p-u)*(d-h)+h,u=e.max):u<=p&&p>e.max&&u<=e.max&&(d=(e.max-u)/(p-u)*(d-h)+h,p=e.max),h!=m&&rt.lineTo(i.p2c(m),e.p2c(u)),rt.lineTo(i.p2c(h),e.p2c(u)),rt.lineTo(i.p2c(d),e.p2c(p)),d!=x&&(rt.lineTo(i.p2c(d),e.p2c(p)),rt.lineTo(i.p2c(x),e.p2c(p)))}}}}rt.save(),rt.translate(ct.left,ct.top),rt.lineJoin="round";var o=t.lines.lineWidth,n=t.shadowSize;if(0<o&&0<n){rt.lineWidth=n,rt.strokeStyle="rgba(0,0,0,0.1)";var r=Math.PI/18;i(t.datapoints,Math.sin(r)*(o/2+n/2),Math.cos(r)*(o/2+n/2),t.xaxis,t.yaxis),rt.lineWidth=n/2,i(t.datapoints,Math.sin(r)*(o/2+n/4),Math.cos(r)*(o/2+n/4),t.xaxis,t.yaxis)}rt.lineWidth=o,rt.strokeStyle=t.color;var a=j(t.lines,t.color,0,ht);a&&(rt.fillStyle=a,e(t.datapoints,t.xaxis,t.yaxis)),0<o&&i(t.datapoints,0,0,t.xaxis,t.yaxis),rt.restore()}function O(t){function i(t,i,e,o,n,r,a,l){for(var s=t.points,c=t.pointsize,f=0;f<s.length;f+=c){var h=s[f],u=s[f+1];null==h||h<r.min||h>r.max||u<a.min||u>a.max||(rt.beginPath(),h=r.p2c(h),u=a.p2c(u)+o,"circle"==l?rt.arc(h,u,i,0,n?Math.PI:2*Math.PI,!1):l(rt,h,u,i,n),rt.closePath(),e&&(rt.fillStyle=e,rt.fill()),rt.stroke())}}rt.save(),rt.translate(ct.left,ct.top);var e=t.points.lineWidth,o=t.shadowSize,n=t.points.radius,r=t.points.symbol;if(0==e&&(e=1e-4),0<e&&0<o){var a=o/2;rt.lineWidth=a,rt.strokeStyle="rgba(0,0,0,0.1)",i(t.datapoints,n,null,a+a/2,!0,t.xaxis,t.yaxis,r),rt.strokeStyle="rgba(0,0,0,0.2)",i(t.datapoints,n,null,a/2,!0,t.xaxis,t.yaxis,r)}rt.lineWidth=e,rt.strokeStyle=t.color,i(t.datapoints,n,j(t.points,t.color),0,!1,t.xaxis,t.yaxis,r),rt.restore()}function E(t,i,e,o,n,r,a,l,s,c,f,h){var u,d,p,m,x,g,b,v,k;f?(v=g=b=!0,x=!1,m=i+o,p=i+n,(d=t)<(u=e)&&(k=d,d=u,u=k,g=!(x=!0))):(x=g=b=!0,v=!1,u=t+o,d=t+n,(m=i)<(p=e)&&(k=m,m=p,p=k,b=!(v=!0))),d<l.min||u>l.max||m<s.min||p>s.max||(u<l.min&&(u=l.min,x=!1),d>l.max&&(d=l.max,g=!1),p<s.min&&(p=s.min,v=!1),m>s.max&&(m=s.max,b=!1),u=l.p2c(u),p=s.p2c(p),d=l.p2c(d),m=s.p2c(m),a&&(c.beginPath(),c.moveTo(u,p),c.lineTo(u,m),c.lineTo(d,m),c.lineTo(d,p),c.fillStyle=a(p,m),c.fill()),0<h&&(x||g||b||v)&&(c.beginPath(),c.moveTo(u,p+r),x?c.lineTo(u,m+r):c.moveTo(u,m+r),b?c.lineTo(d,m+r):c.moveTo(d,m+r),g?c.lineTo(d,p+r):c.moveTo(d,p+r),v?c.lineTo(u,p+r):c.moveTo(u,p+r),c.stroke()))}function R(f){function t(t,i,e,o,n,r,a){for(var l=t.points,s=t.pointsize,c=0;c<l.length;c+=s)null!=l[c]&&E(l[c],l[c+1],l[c+2],i,e,o,n,r,a,rt,f.bars.horizontal,f.bars.lineWidth)}var i;switch(rt.save(),rt.translate(ct.left,ct.top),rt.lineWidth=f.bars.lineWidth,rt.strokeStyle=f.color,f.bars.align){case"left":i=0;break;case"right":i=-f.bars.barWidth;break;case"center":i=-f.bars.barWidth/2;break;default:throw new Error("Invalid bar alignment: "+f.bars.align)}var e=f.bars.fill?function(t,i){return j(f.bars,f.color,t,i)}:null;t(f.datapoints,i,i+f.bars.barWidth,0,e,f.xaxis,f.yaxis),rt.restore()}function j(t,i,e,o){var n=t.fill;if(!n)return null;if(t.fillColor)return Z(t.fillColor,e,o,i);var r=xt.color.parse(i);return r.a="number"==typeof n?n:.4,r.normalize(),r.toString()}function B(){if(x.find(".legend").remove(),it.legend.show){for(var t,i,e=[],o=[],n=!1,r=it.legend.labelFormatter,a=0;a<tt.length;++a)(t=tt[a]).label&&(i=r?r(t.label,t):t.label)&&o.push({label:i,color:t.color});if(it.legend.sorted)if(xt.isFunction(it.legend.sorted))o.sort(it.legend.sorted);else if("reverse"==it.legend.sorted)o.reverse();else{var l="descending"!=it.legend.sorted;o.sort(function(t,i){return t.label==i.label?0:t.label<i.label!=l?1:-1})}for(a=0;a<o.length;++a){var s=o[a];a%it.legend.noColumns==0&&(n&&e.push("</tr>"),e.push("<tr>"),n=!0),e.push('<td class="legendColorBox"><div style="border:1px solid '+it.legend.labelBoxBorderColor+';padding:1px"><div style="width:4px;height:0;border:5px solid '+s.color+';overflow:hidden"></div></div></td><td class="legendLabel">'+s.label+"</td>")}if(n&&e.push("</tr>"),0!=e.length){var c='<table style="font-size:smaller;color:'+it.grid.color+'">'+e.join("")+"</table>";if(null!=it.legend.container)xt(it.legend.container).html(c);else{var f="",h=it.legend.position,u=it.legend.margin;null==u[0]&&(u=[u,u]),"n"==h.charAt(0)?f+="top:"+(u[1]+ct.top)+"px;":"s"==h.charAt(0)&&(f+="bottom:"+(u[1]+ct.bottom)+"px;"),"e"==h.charAt(1)?f+="right:"+(u[0]+ct.right)+"px;":"w"==h.charAt(1)&&(f+="left:"+(u[0]+ct.left)+"px;");var d=xt('<div class="legend">'+c.replace('style="','style="position:absolute;'+f+";")+"</div>").appendTo(x);if(0!=it.legend.backgroundOpacity){var p=it.legend.backgroundColor;null==p&&((p=(p=it.grid.backgroundColor)&&"string"==typeof p?xt.color.parse(p):xt.color.extract(d,"background-color")).a=1,p=p.toString());var m=d.children();xt('<div style="position:absolute;width:'+m.width()+"px;height:"+m.height()+"px;"+f+"background-color:"+p+';"> </div>').prependTo(d).css("opacity",it.legend.backgroundOpacity)}}}}}function H(t,i,e){var o,n,r,a=it.grid.mouseActiveRadius,l=a*a+1,s=null;for(o=tt.length-1;0<=o;--o)if(e(tt[o])){var c=tt[o],f=c.xaxis,h=c.yaxis,u=c.datapoints.points,d=f.c2p(t),p=h.c2p(i),m=a/f.scale,x=a/h.scale;if(r=c.datapoints.pointsize,f.options.inverseTransform&&(m=Number.MAX_VALUE),h.options.inverseTransform&&(x=Number.MAX_VALUE),c.lines.show||c.points.show)for(n=0;n<u.length;n+=r){var g=u[n],b=u[n+1];if(null!=g&&!(m<g-d||g-d<-m||x<b-p||b-p<-x)){var v=Math.abs(f.p2c(g)-t),k=Math.abs(h.p2c(b)-i),y=v*v+k*k;y<l&&(l=y,s=[o,n/r])}}if(c.bars.show&&!s){var w="left"==c.bars.align?0:-c.bars.barWidth/2,T=w+c.bars.barWidth;for(n=0;n<u.length;n+=r){g=u[n],b=u[n+1];var M=u[n+2];null!=g&&((tt[o].bars.horizontal?d<=Math.max(M,g)&&d>=Math.min(M,g)&&b+w<=p&&p<=b+T:g+w<=d&&d<=g+T&&p>=Math.min(M,b)&&p<=Math.max(M,b))&&(s=[o,n/r]))}}}return s?(o=s[0],n=s[1],r=tt[o].datapoints.pointsize,{datapoint:tt[o].datapoints.points.slice(n*r,(n+1)*r),dataIndex:n,series:tt[o],seriesIndex:o}):null}function G(t){it.grid.hoverable&&X("plothover",t,function(t){return 0!=t.hoverable})}function _(t){it.grid.hoverable&&X("plothover",t,function(){return!1})}function V(t){X("plotclick",t,function(t){return 0!=t.clickable})}function X(t,i,e){var o=nt.offset(),n=i.pageX-o.left-ct.left,r=i.pageY-o.top-ct.top,a=f({left:n,top:r});a.pageX=i.pageX,a.pageY=i.pageY;var l=H(n,r,e);if(l&&(l.pageX=parseInt(l.series.xaxis.p2c(l.datapoint[0])+o.left+ct.left,10),l.pageY=parseInt(l.series.yaxis.p2c(l.datapoint[1])+o.top+ct.top,10)),it.grid.autoHighlight){for(var s=0;s<pt.length;++s){var c=pt[s];c.auto!=t||l&&c.series==l.series&&c.point[0]==l.datapoint[0]&&c.point[1]==l.datapoint[1]||U(c.series,c.point)}l&&Q(l.series,l.datapoint,t)}x.trigger(t,[a,l])}function Y(){var t=it.interaction.redrawOverlayInterval;-1!=t?mt||(mt=setTimeout(q,t)):q()}function q(){var t,i;for(mt=null,at.save(),ot.clear(),at.translate(ct.left,ct.top),t=0;t<pt.length;++t)(i=pt[t]).series.bars.show?K(i.series,i.point):$(i.series,i.point);at.restore(),M(ut.drawOverlay,[at])}function Q(t,i,e){if("number"==typeof t&&(t=tt[t]),"number"==typeof i){var o=t.datapoints.pointsize;i=t.datapoints.points.slice(o*i,o*(i+1))}var n=J(t,i);-1==n?(pt.push({series:t,point:i,auto:e}),Y()):e||(pt[n].auto=!1)}function U(t,i){if(null==t&&null==i)return pt=[],void Y();if("number"==typeof t&&(t=tt[t]),"number"==typeof i){var e=t.datapoints.pointsize;i=t.datapoints.points.slice(e*i,e*(i+1))}var o=J(t,i);-1!=o&&(pt.splice(o,1),Y())}function J(t,i){for(var e=0;e<pt.length;++e){var o=pt[e];if(o.series==t&&o.point[0]==i[0]&&o.point[1]==i[1])return e}return-1}function $(t,i){var e=i[0],o=i[1],n=t.xaxis,r=t.yaxis,a="string"==typeof t.highlightColor?t.highlightColor:xt.color.parse(t.color).scale("a",.5).toString();if(!(e<n.min||e>n.max||o<r.min||o>r.max)){var l=t.points.radius+t.points.lineWidth/2;at.lineWidth=l,at.strokeStyle=a;var s=1.5*l;e=n.p2c(e),o=r.p2c(o),at.beginPath(),"circle"==t.points.symbol?at.arc(e,o,s,0,2*Math.PI,!1):t.points.symbol(at,e,o,s,!1),at.closePath(),at.stroke()}}function K(t,i){var e="string"==typeof t.highlightColor?t.highlightColor:xt.color.parse(t.color).scale("a",.5).toString(),o=e,n="left"==t.bars.align?0:-t.bars.barWidth/2;at.lineWidth=t.bars.lineWidth,at.strokeStyle=e,E(i[0],i[1],i[2]||0,n,n+t.bars.barWidth,0,function(){return o},t.xaxis,t.yaxis,at,t.bars.horizontal,t.bars.lineWidth)}function Z(t,i,e,o){if("string"==typeof t)return t;for(var n=rt.createLinearGradient(0,e,0,i),r=0,a=t.colors.length;r<a;++r){var l=t.colors[r];if("string"!=typeof l){var s=xt.color.parse(o);null!=l.brightness&&(s=s.scale("rgb",l.brightness)),null!=l.opacity&&(s.a*=l.opacity),l=s.toString()}n.addColorStop(r/(a-1),l)}return n}var tt=[],it={colors:["#edc240","#afd8f8","#cb4b4b","#4da74d","#9440ed"],legend:{show:!0,noColumns:1,labelFormatter:null,labelBoxBorderColor:"#ccc",container:null,position:"ne",margin:5,backgroundColor:null,backgroundOpacity:.85,sorted:null},xaxis:{show:null,position:"bottom",mode:null,font:null,color:null,tickColor:null,transform:null,inverseTransform:null,min:null,max:null,autoscaleMargin:null,ticks:null,tickFormatter:null,labelWidth:null,labelHeight:null,reserveSpace:null,tickLength:null,alignTicksWithAxis:null,tickDecimals:null,tickSize:null,minTickSize:null},yaxis:{autoscaleMargin:.02,position:"left"},xaxes:[],yaxes:[],series:{points:{show:!1,radius:3,lineWidth:2,fill:!0,fillColor:"#ffffff",symbol:"circle"},lines:{lineWidth:2,fill:!1,fillColor:null,steps:!1},bars:{show:!1,lineWidth:2,barWidth:1,fill:!0,fillColor:null,align:"left",horizontal:!1,zero:!0},shadowSize:3,highlightColor:null},grid:{show:!0,aboveData:!1,color:"#545454",backgroundColor:null,borderColor:null,tickColor:null,margin:0,labelMargin:5,axisMargin:8,borderWidth:2,minBorderMargin:null,markings:null,markingsColor:"#f4f4f4",markingsLineWidth:2,clickable:!1,hoverable:!1,autoHighlight:!0,mouseActiveRadius:10},interaction:{redrawOverlayInterval:1e3/60},hooks:{}},et=null,ot=null,nt=null,rt=null,at=null,lt=[],st=[],ct={left:0,right:0,top:0,bottom:0},ft=0,ht=0,ut={processOptions:[],processRawData:[],processDatapoints:[],processOffset:[],drawBackground:[],drawSeries:[],draw:[],bindEvents:[],drawOverlay:[],shutdown:[]},dt=this;dt.setData=r,dt.setupGrid=w,dt.draw=I,dt.getPlaceholder=function(){return x},dt.getCanvas=function(){return et.element},dt.getPlotOffset=function(){return ct},dt.width=function(){return ft},dt.height=function(){return ht},dt.offset=function(){var t=nt.offset();return t.left+=ct.left,t.top+=ct.top,t},dt.getData=function(){return tt},dt.getAxes=function(){var e={};return xt.each(lt.concat(st),function(t,i){i&&(e[i.direction+(1!=i.n?i.n:"")+"axis"]=i)}),e},dt.getXAxes=function(){return lt},dt.getYAxes=function(){return st},dt.c2p=f,dt.p2c=l,dt.getOptions=function(){return it},dt.highlight=Q,dt.unhighlight=U,dt.triggerRedrawOverlay=Y,
dt.pointOffset=function(t){return{left:parseInt(lt[d(t,"x")-1].p2c(+t.x)+ct.left,10),top:parseInt(st[d(t,"y")-1].p2c(+t.y)+ct.top,10)}},dt.shutdown=m,dt.resize=function(){var t=x.width(),i=x.height();et.resize(t,i),ot.resize(t,i)},dt.hooks=ut,e(dt),n(i),h(),r(t),w(),I(),u();var pt=[],mt=null}function bt(t,i){return i*Math.floor(t/i)}var d=Object.prototype.hasOwnProperty;gt.prototype.resize=function(t,i){if(t<=0||i<=0)throw new Error("Invalid dimensions for plot, width = "+t+", height = "+i);var e=this.element,o=this.context,n=this.pixelRatio;this.width!=t&&(e.width=t*n,e.style.width=t+"px",this.width=t),this.height!=i&&(e.height=i*n,e.style.height=i+"px",this.height=i),o.restore(),o.save(),o.scale(n,n)},gt.prototype.clear=function(){this.context.clearRect(0,0,this.width,this.height)},gt.prototype.render=function(){var t=this._textCache;for(var i in t)if(d.call(t,i)){var e=this.getTextLayer(i),o=t[i];for(var n in e.hide(),o)if(d.call(o,n)){var r=o[n];for(var a in r)if(d.call(r,a)){for(var l,s=r[a].positions,c=0;l=s[c];c++)l.active?l.rendered||(e.append(l.element),l.rendered=!0):(s.splice(c--,1),l.rendered&&l.element.detach());0==s.length&&delete r[a]}}e.show()}},gt.prototype.getTextLayer=function(t){var i=this.text[t];return null==i&&(null==this.textContainer&&(this.textContainer=xt("<div class='flot-text'></div>").css({position:"absolute",top:0,left:0,bottom:0,right:0,"font-size":"smaller",color:"#545454"}).insertAfter(this.element)),i=this.text[t]=xt("<div></div>").addClass(t).css({position:"absolute",top:0,left:0,bottom:0,right:0}).appendTo(this.textContainer)),i},gt.prototype.getTextInfo=function(t,i,e,o,n){var r,a,l,s;if(i=""+i,r="object"==typeof e?e.style+" "+e.variant+" "+e.weight+" "+e.size+"px/"+e.lineHeight+"px "+e.family:e,null==(a=this._textCache[t])&&(a=this._textCache[t]={}),null==(l=a[r])&&(l=a[r]={}),null==(s=l[i])){var c=xt("<div></div>").html(i).css({position:"absolute","max-width":n,top:-9999}).appendTo(this.getTextLayer(t));"object"==typeof e?c.css({font:r,color:e.color}):"string"==typeof e&&c.addClass(e),s=l[i]={width:c.outerWidth(!0),height:c.outerHeight(!0),element:c,positions:[]},c.detach()}return s},gt.prototype.addText=function(t,i,e,o,n,r,a,l,s){var c=this.getTextInfo(t,o,n,r,a),f=c.positions;"center"==l?i-=c.width/2:"right"==l&&(i-=c.width),"middle"==s?e-=c.height/2:"bottom"==s&&(e-=c.height);for(var h,u=0;h=f[u];u++)if(h.x==i&&h.y==e)return void(h.active=!0);h={active:!0,rendered:!1,element:f.length?c.element.clone():c.element,x:i,y:e},f.push(h),h.element.css({top:Math.round(e),left:Math.round(i),"text-align":l})},gt.prototype.removeText=function(t,i,e,o,n,r){if(null==o){var a=this._textCache[t];if(null!=a)for(var l in a)if(d.call(a,l)){var s=a[l];for(var c in s)if(d.call(s,c))for(var f=s[c].positions,h=0;u=f[h];h++)u.active=!1}}else{var u;for(f=this.getTextInfo(t,o,n,r).positions,h=0;u=f[h];h++)u.x==i&&u.y==e&&(u.active=!1)}},xt.plot=function(t,i,e){return new o(xt(t),i,e,xt.plot.plugins)},xt.plot.version="0.8.1",xt.plot.plugins=[],xt.fn.plot=function(t,i){return this.each(function(){xt.plot(this,t,i)})}}(jQuery);